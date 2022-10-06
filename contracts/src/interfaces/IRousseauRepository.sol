// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.13;

interface IRousseauRepository {
  function addValue(string calldata value) external;
  function removeValue(uint256 index) external;
  function replaceValue(uint256 index, string calldata value) external;
  function canRemove(uint256 index) external returns(bool);
  function canReplace(uint256 index) external returns(bool);
  function addComment(uint256 proposalId, string calldata comment) external;
}
