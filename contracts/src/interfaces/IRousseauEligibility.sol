// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.16;

/// @title IRousseauEligibility
/// @author Newt team
/// @notice This interface is used to be inherited to check the rights that a user has on the rousseau protocol
interface IRousseauEligibility {
    /// @notice Checks if the address can vote on a proposal
    /// @param _address Address to check
    /// @param _proposalId Proposal ID to check
    /// @param _data Custom data to check eligibility
    /// @return True if the address can vote on a proposal
    function canVote(
        address _address,
        uint256 _proposalId,
        bytes calldata _data
    ) external view returns (bool);

    /// @notice Checks if the address can create a new proposal
    /// @param _address Address to check
    /// @param _data Custom data to check eligibility
    /// @return True if the address can create a new on a proposal
    function canPropose(address _address, bytes calldata _data)
        external
        view
        returns (bool);

    /// @notice Checks if the address has voted on a proposal
    /// @param _address Address to check
    /// @param _proposalId Proposal ID to check
    /// @param _data Custom data to do custom checks
    /// @return True if the address has voted on a proposal
    function hasVoted(
        address _address,
        uint256 _proposalId,
        bytes calldata _data
    ) external view returns (bool);

    /// @notice Sets the address as voted on a proposal
    /// @param _address Address to set
    /// @param _proposalId Proposal ID to set
    /// @param _data Custom data to do custom checks
    function setVoted(
        address _address,
        uint256 _proposalId,
        bytes calldata _data
    ) external;

    /// @notice Get the vote weight of an address in a certain proposal
    /// @param _voter Address of the voter to check
    /// @param _proposalId Proposal ID to check
    /// @param _data Custom data to do custom checks
    /// @return The vote weight of an address in a certain proposal
    function getVoteWeight(
        address _voter,
        uint256 _proposalId,
        bytes calldata _data
    ) external view returns (uint256);
}
