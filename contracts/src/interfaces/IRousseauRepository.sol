// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.16;

interface IRousseauRepository {
    /// @notice Adds a new value to the repository
    /// @param proposalId Proposal ID to add
    /// @param value Value to add
    /// @param date Date when you add the value
    /// @param customData Custom data to do custom features
    function addValue(
        uint256 proposalId,
        string calldata value,
        uint256 date,
        bytes calldata customData
    ) external;

    /// @notice Removes a value from the repository
    /// @param proposalId Proposal ID to remove
    /// @param data Number of the proposal that you are targeting to replace or remove
    /// @param date Date when you remove the value
    /// @param customData Custom data to do custom features 
    function removeValue(
        uint256 proposalId,
        uint256 data,
        uint256 date,
        bytes calldata customData
    ) external;

    /// @notice Replaces a value from the repository
    /// @param proposalId Proposal ID that wants to do the replace
    /// @param value Value to replace
    /// @param data Number of the proposal that you are targeting to replace or remove
    /// @param date Date when you replace the value
    /// @param customData Custom data to do custom features
    function replaceValue(
        uint256 proposalId,
        string calldata value,
        uint256 data,
        uint256 date,
        bytes calldata customData
    ) external;

    /// @notice Checks if the proposal can be removed
    /// @param proposalId Proposal ID to check
    /// @param data Number of the proposal that you are targeting to replace or remove
    /// @return True if the proposal can be removed 
    function canRemove(
        uint256 proposalId,
        uint256 data
    ) external returns (bool);

    /// @notice Checks if the proposal can be replaced
    /// @param proposalId Proposal ID to check
    /// @param data Number of the proposal that you are targeting to replace or remove
    /// @return True if the proposal can be replaced
    function canReplace(
        uint256 proposalId,
        uint256 data
    ) external returns (bool);

    /// @notice Adds comment to a certain proposal
    /// @param proposalId Proposal ID to add the comment
    /// @param value Comment to add
    /// @param author Author of the comment
    function addComment(
        uint256 proposalId,
        string calldata value,
        address author
    ) external;
}
