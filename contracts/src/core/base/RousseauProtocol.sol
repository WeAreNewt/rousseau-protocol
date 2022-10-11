// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.13;

import "../../interfaces/IRousseauEligibility.sol";
import "../../interfaces/IRousseauQuorum.sol";
import "../../interfaces/IRousseauRepository.sol";
import "../../libraries/DataTypes.sol";

contract RousseauProtocol {

  event ProposalCreated();
  event ProposalUpdated();
  event ProposalExecuted();

  error ValueMustNotBeNull();
  error NotElegible();
  error QuorumNotReached();
  error VoteNotStarted();
  error VoteStillGoing();
  error VoteAlreadyFinished();
  error RepositoryError();
  error InvalidProposalType();

  mapping(uint256 => DataTypes.Proposal) public proposals;

  uint256 _counter = 0;

  IRousseauEligibility rousseauEligibility;
  IRousseauQuorum rousseauQuorum;
  IRousseauRepository rousseauRepository;
  
  constructor(address _rousseauEligibility, address _rousseauQuorum, address _rousseauRepository) {
    rousseauEligibility = IRousseauEligibility(_rousseauEligibility);
    rousseauQuorum = IRousseauQuorum(_rousseauQuorum);
    rousseauRepository = IRousseauRepository(_rousseauRepository);
  }

  function createProposal(string calldata _value, uint8 _proposalType, uint256 _data, bytes calldata _elegibilityData) external {
    if(bytes(_value).length == 0 ) revert ValueMustNotBeNull();
    if(!(rousseauEligibility.canPropose(msg.sender, _elegibilityData))) revert NotElegible();
    if(_proposalType > 2) revert InvalidProposalType();
    if(!rousseauRepository.canRemove(_data) && _proposalType == 1 || !rousseauRepository.canReplace(_data) && _proposalType == 2) revert RepositoryError();

    DataTypes.Proposal storage newProposal = proposals[++_counter];
    newProposal.value = _value;
    newProposal.start = block.timestamp;
    newProposal.kind = DataTypes.ProposalType(_proposalType);
    newProposal.data = _data;
  }

  function executeProposal(uint256 _proposalId) external {
    DataTypes.Proposal storage proposal = proposals[_proposalId];
    if(!rousseauQuorum.hasQuorum(proposal.votes[DataTypes.VoteType.YES], proposal.votes[DataTypes.VoteType.NO], proposal.votes[DataTypes.VoteType.ABSTAIN])) revert QuorumNotReached();
    if(block.timestamp < proposal.start + rousseauQuorum.getVotePeriod() + rousseauQuorum.getVoteDelay()) revert VoteStillGoing();

    if(proposal.kind == DataTypes.ProposalType.ADD) {
      rousseauRepository.addValue(
        abi.encode(
          proposal.value,
          proposal.votes,
          proposal.kind,
          proposal.data,
          proposal.start
        )
      );
    } else if(proposal.kind == DataTypes.ProposalType.REMOVE) {
      rousseauRepository.removeValue(proposal.data);
    } else {
      rousseauRepository.replaceValue(proposal.data, proposal.value);
    }
  }

  function voteProposal(uint256 _proposalId, uint8 _voteType, string calldata _comment, bytes calldata _data) external {
    if(!rousseauEligibility.canVote(msg.sender, _proposalId, _data)) revert NotElegible();

    DataTypes.Proposal storage proposal = proposals[_proposalId];

    if(block.timestamp < proposal.start + rousseauQuorum.getVoteDelay()) revert VoteNotStarted();
    if(block.timestamp > proposal.start + rousseauQuorum.getVotePeriod() + rousseauQuorum.getVoteDelay()) revert VoteAlreadyFinished();

    proposal.votes[DataTypes.VoteType(_voteType)] += rousseauEligibility.getVoteWeight(msg.sender, _proposalId, _data);
    rousseauRepository.addComment(_proposalId, _comment);
    rousseauEligibility.setVoted(msg.sender, _proposalId, _data);
  }
}