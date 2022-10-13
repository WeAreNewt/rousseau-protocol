// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.16;

library DataTypes {
    /// @notice Vote type enumerator
    /// @param YES The 0 value is for yes votes
    /// @param NO The 1 value is for no votes
    /// @param ABSTAIN The 2 value is for abstain votes
    enum VoteType {
        YES,
        NO,
        ABSTAIN
    }

    /// @notice Proposal type enumerator
    /// @param ADD The 0 value is for add proposals
    /// @param REMOVE The 1 value is for remove proposals
    /// @param REPLACE The 2 value is for replace proposals
    enum ProposalType {
        ADD,
        REMOVE,
        REPLACE
    }

    /// @notice Proposal struct
    /// @param value The value of the proposal
    /// @param votes A mapping to store the votes
    /// @param proposalType The type of the proposal
    /// @param data Number of the proposal that you are targeting to replace or remove
    /// @param date The date of the proposal
    /// @param customData The custom data of the proposal
    struct Proposal {
        string value;
        mapping(VoteType => uint256) votes;
        ProposalType kind;
        uint256 data;
        uint256 start;
        bytes customData;
    }
    
    /// @notice Comments
    /// @param value The value of the comment
    /// @param date The date of the comment
    /// @param author The author of the comment
    struct Comment {
        string value;
        uint256 date;
        address author;
    }
}
