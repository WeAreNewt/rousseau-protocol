// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.16;

interface IRousseauQuorum {
    /// @notice Checks if the quorum has been reached
    /// @param yes The number of yes votes
    /// @param no The number of no votes
    /// @param abstain The number of abstain votes
    function hasQuorum(
        uint256 yes,
        uint256 no,
        uint256 abstain
    ) external view returns (bool);

    /// @notice Gets the vote period
    /// @return The vote period
    function getVotePeriod() external view returns (uint256);

    /// @notice Gets the vote delay
    /// @return The vote delay
    function getVoteDelay() external view returns (uint256);
}
