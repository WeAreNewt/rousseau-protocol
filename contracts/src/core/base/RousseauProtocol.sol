// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.16;

import "../../interfaces/IRousseauEligibility.sol";
import "../../interfaces/IRousseauQuorum.sol";
import "../../interfaces/IRousseauRepository.sol";
import "../../libraries/DataTypes.sol";

/// @title RousseauProtocol
/// @author Newt team
/// @notice This contract is used to create proposals of values and vote on them
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

    /// @notice Constructor of the rousseau protocol
    /// @param _rousseauEligibility Address of the rousseau eligibility module
    /// @param _rousseauQuorum Address of the rousseau quorum module
    /// @param _rousseauRepository Address of the rousseau repository module
    constructor(
        address _rousseauEligibility,
        address _rousseauQuorum,
        address _rousseauRepository
    ) {
        rousseauEligibility = IRousseauEligibility(_rousseauEligibility);
        rousseauQuorum = IRousseauQuorum(_rousseauQuorum);
        rousseauRepository = IRousseauRepository(_rousseauRepository);
    }

    /// @notice Creates a new proposal
    /// @param _value Value of the proposal
    /// @param _proposalType Type of the proposal
    /// @param _data Number of the proposal that you are targeting to replace or remove
    /// @param _eligibilityData Custom data for the eligibility module
    /// @param _customData Custom data of the proposal
    function createProposal(
        string calldata _value,
        uint8 _proposalType,
        uint256 _data,
        bytes calldata _eligibilityData,
        bytes calldata _customData
    ) external {
        if (bytes(_value).length == 0) revert ValueMustNotBeNull();
        if (_proposalType > 2) revert InvalidProposalType();

        DataTypes.Proposal storage newProposal = proposals[++_counter];
        newProposal.value = _value;
        newProposal.start = block.timestamp;
        newProposal.kind = DataTypes.ProposalType(_proposalType);
        newProposal.data = _data;
        newProposal.customData = _customData;

        if (!(rousseauEligibility.canPropose(msg.sender, _eligibilityData)))
            revert NotElegible();
        if (
            (!rousseauRepository.canRemove(_counter, _data) &&
                _proposalType == 1) ||
            (!rousseauRepository.canReplace(_counter, _data) &&
                _proposalType == 2)
        ) revert RepositoryError();
    }

    /// @notice Executes a proposal
    /// @param _proposalId Id of the proposal
    function executeProposal(uint256 _proposalId) external {
        DataTypes.Proposal storage proposal = proposals[_proposalId];
        if (
            !rousseauQuorum.hasQuorum(
                proposal.votes[DataTypes.VoteType.YES],
                proposal.votes[DataTypes.VoteType.NO],
                proposal.votes[DataTypes.VoteType.ABSTAIN]
            )
        ) revert QuorumNotReached();
        if (
            block.timestamp <
            proposal.start +
                rousseauQuorum.getVotePeriod() +
                rousseauQuorum.getVoteDelay()
        ) revert VoteStillGoing();

        if (proposal.kind == DataTypes.ProposalType.ADD) {
            rousseauRepository.addValue(
                _proposalId,
                proposal.value,
                block.timestamp,
                proposal.customData
            );
        } else if (proposal.kind == DataTypes.ProposalType.REMOVE) {
            rousseauRepository.removeValue(
                _proposalId,
                proposal.data,
                block.timestamp,
                proposal.customData
            );
        } else {
            rousseauRepository.replaceValue(
                _proposalId,
                proposal.value,
                proposal.data,
                block.timestamp,
                proposal.customData
            );
        }
    }

    /// @notice Votes on a proposal
    /// @param _proposalId Id of the proposal
    /// @param _voteType Type of the vote
    /// @param _comment Comment of the vote
    /// @param _data Custom data of the vote for the eligibility module
    function voteProposal(
        uint256 _proposalId,
        uint8 _voteType,
        string calldata _comment,
        bytes calldata _data
    ) external {
        DataTypes.Proposal storage proposal = proposals[_proposalId];

        if (!rousseauEligibility.canVote(msg.sender, _proposalId, _data))
            revert NotElegible();
        if (block.timestamp < proposal.start + rousseauQuorum.getVoteDelay())
            revert VoteNotStarted();
        if (
            block.timestamp >
            proposal.start +
                rousseauQuorum.getVotePeriod() +
                rousseauQuorum.getVoteDelay()
        ) revert VoteAlreadyFinished();

        proposal.votes[DataTypes.VoteType(_voteType)] += rousseauEligibility
            .getVoteWeight(msg.sender, _proposalId, _data);
        rousseauRepository.addComment(_proposalId, _comment, msg.sender);
        rousseauEligibility.setVoted(msg.sender, _proposalId, _data);
    }
}
