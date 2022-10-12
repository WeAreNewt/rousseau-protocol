// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.16;

interface IRousseauQuorum {
    function hasQuorum(
        uint256 yes,
        uint256 no,
        uint256 abstain
    ) external view returns (bool);

    function getVotePeriod() external view returns (uint256);

    function getVoteDelay() external view returns (uint256);
}
