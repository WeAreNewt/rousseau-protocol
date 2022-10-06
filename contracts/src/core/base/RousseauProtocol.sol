// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.13;

import "../../interfaces/IRousseauEligibility.sol";
import "../../interfaces/IRousseauQuorum.sol";
import "../../interfaces/IRousseauRepository.sol";
import "../../libraries/DataTypes.sol";

contract RousseauProtocol {

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

  IRousseauEligibility rousseauEligibility;
  IRousseauQuorum rousseauQuorum;
  IRousseauRepository rousseauRepository;
  
  constructor(address _rousseauEligibility, address _rousseauQuorum, address _rousseauRepository) {
    rousseauEligibility = IRousseauEligibility(_rousseauEligibility);
    rousseauQuorum = IRousseauQuorum(_rousseauQuorum);
    rousseauRepository = IRousseauRepository(_rousseauRepository);
  }

  function createProposal(string calldata _value, uint8 _proposalType, uint256 _data) external {
    if(bytes(_value).length == 0 ) revert ValueMustNotBeNull();
    if(!(rousseauEligibility.isElegible(msg.sender))) revert NotElegible();

    // Check conditions in IRepository before actually creating it

    DataTypes.Proposal storage newProposal = _proposals[++_counter];
    newProposal.value = _value;
    newProposal.start = block.timestamp;
    newProposal.kind = DataTypes.ProposalType(_proposalType);
    newProposal.data = _data;
  }

  function executeProposal(uint256 _proposalId) external {
    DataTypes.Proposal storage proposal = _proposals[_proposalId];
    if(!rousseauQuorum.hasQuorum(proposal.votes[DataTypes.VoteType.YES], proposal.votes[DataTypes.VoteType.NO], proposal.votes[DataTypes.VoteType.ABSTAIN])) revert NoQuorum();
    if(block.timestamp < proposal.start + rousseauQuorum.getVotePeriod() + rousseauQuorum.getVoteDelay()) revert VoteStillGoing();

    if(proposal.kind == DataTypes.ProposalType.ADD) {
      rousseauRepository.addValue(proposal.value);
    } else if(proposal.kind == DataTypes.ProposalType.REMOVE) {
      rousseauRepository.removeValue(proposal.data);
    } else {
      rousseauRepository.replaceValue(proposal.data, proposal.value);
    }
  }

  function voteProposal(uint256 _proposalId, uint8 _voteType) external {
    if(!rousseauEligibility.isElegible(msg.sender)) revert NotElegible();
    if(rousseauEligibility.hasVoted(msg.sender, _proposalId)) revert AlreadyVoted();

    DataTypes.Proposal storage proposal = _proposals[_proposalId];

    if(block.timestamp < proposal.start + rousseauQuorum.getVoteDelay()) revert VoteNotStarted();
    if(block.timestamp > proposal.start + rousseauQuorum.getVotePeriod() + rousseauQuorum.getVoteDelay()) revert VoteAlreadyFinished();

    // creation of custom vote counter
    proposal.votes[DataTypes.VoteType(_voteType)]++;
    rousseauEligibility.setVoted(msg.sender, _proposalId);
  }
}