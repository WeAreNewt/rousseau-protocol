// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.16;

interface IRousseauEligibility {
    function canVote(
        address _address,
        uint256 _proposalId,
        bytes calldata _data
    ) external view returns (bool);

    function canPropose(address _address, bytes calldata _data)
        external
        view
        returns (bool);

    function hasVoted(
        address _address,
        uint256 _proposalId,
        bytes calldata _data
    ) external view returns (bool);

    function setVoted(
        address _address,
        uint256 _proposalId,
        bytes calldata _data
    ) external;

    function getVoteWeight(
        address _voter,
        uint256 _proposalId,
        bytes calldata _data
    ) external view returns (uint256);
}