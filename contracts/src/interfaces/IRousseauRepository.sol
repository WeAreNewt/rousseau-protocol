// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.13;

interface IRousseauRepository {
  function addValue(bytes calldata data) external;
  function removeValue(bytes calldata data) external;
  function replaceValue(bytes calldata data) external;
  function canRemove(bytes calldata data) external returns(bool);
  function canReplace(bytes calldata data) external returns(bool);
  function addComment(bytes calldata data) external;
}
