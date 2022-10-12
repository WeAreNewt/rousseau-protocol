// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.16;

interface IRousseauRepository {
    function addValue(
        uint256 proposalId,
        string calldata value,
        uint256 data,
        uint256 date
    ) external;

    function removeValue(
        uint256 proposalId,
        string calldata value,
        uint256 data,
        uint256 date
    ) external;

    function replaceValue(
        uint256 proposalId,
        string calldata value,
        uint256 data,
        uint256 date
    ) external;

    function canRemove(
        uint256 proposalId,
        uint256 kind,
        uint256 data,
        uint256 start
    ) external returns (bool);

    function canReplace(
        uint256 proposalId,
        uint256 kind,
        uint256 data,
        uint256 start
    ) external returns (bool);

    function addComment(uint256 proposalId, string calldata value) external;
}
∫