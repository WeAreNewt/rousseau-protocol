// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.13;

import "../../interfaces/IAvaraElegibility.sol";
import "../../interfaces/IAvaraQuorum.sol";
import "../../interfaces/IAvaraStorage.sol";
import "../../libraries/DataTypes.sol";

contract AvaraProtocol {

  event ProposalCreated();
  event ProposalDeleted();
  event ProposalUpdated();
  event ProposalExecuted();

  error ValueMustNotBeNull();
  error NotElegible();
  error NoQuorum();
  error AlreadyVoted();
  error VoteNotStarted();
  error VoteStillGoing();
  error VoteAlreadyFinished();
  
  mapping(uint256 => DataTypes.Proposal) private _proposals;

  uint256 _counter = 0;

  IAvaraElegibility avaraElegibility;
  IAvaraQuorum avaraQuorum;
  IAvaraStorage avaraStorage;
  constructor(address _avaraElegibility, address _avaraQuorum, address _avaraStorage) {
    avaraElegibility = IAvaraElegibility(_avaraElegibility);
    avaraQuorum = IAvaraQuorum(_avaraQuorum);
    avaraStorage = IAvaraStorage(_avaraStorage);
  }

  function createProposal(string calldata _value, uint8 _proposalType, uint256 _data) external {
    if(bytes(_value).length == 0 ) revert ValueMustNotBeNull();
    if(!(avaraElegibility.isElegible(msg.sender))) revert NotElegible();

    // Check conditions in IStorage before actually creating it

    DataTypes.Proposal storage newProposal = _proposals[++_counter];
    newProposal.value = _value;
    newProposal.start = block.timestamp;
    newProposal.kind = DataTypes.ProposalType(_proposalType);
    newProposal.data = _data;
  }

  function executeProposal(uint256 _proposalId) external {
    DataTypes.Proposal storage proposal = _proposals[_proposalId];
    if(!avaraQuorum.hasQuorum(proposal.votes[DataTypes.VoteType.YES], proposal.votes[DataTypes.VoteType.NO], proposal.votes[DataTypes.VoteType.ABSTAIN])) revert NoQuorum();
    if(block.timestamp < proposal.start + avaraQuorum.getVotePeriod() + avaraQuorum.getVoteDelay()) revert VoteStillGoing();

    if(proposal.kind == DataTypes.ProposalType.ADD) {
      avaraStorage.addValue(proposal.value);
    } else if(proposal.kind == DataTypes.ProposalType.REMOVE) {
      avaraStorage.removeValue(proposal.data);
    } else {
      avaraStorage.replaceValue(proposal.data, proposal.value);
    }
  }

  function voteProposal(uint256 _proposalId, uint8 _voteType) external {
    if(!avaraElegibility.isElegible(msg.sender)) revert NotElegible();
    if(avaraElegibility.hasVoted(msg.sender, _proposalId)) revert AlreadyVoted();

    DataTypes.Proposal storage proposal = _proposals[_proposalId];

    if(block.timestamp < proposal.start + avaraQuorum.getVoteDelay()) revert VoteNotStarted();
    if(block.timestamp > proposal.start + avaraQuorum.getVotePeriod() + avaraQuorum.getVoteDelay()) revert VoteAlreadyFinished();

    proposal.votes[DataTypes.VoteType(_voteType)]++;
    avaraElegibility.setVoted(msg.sender, _proposalId);
  }
}