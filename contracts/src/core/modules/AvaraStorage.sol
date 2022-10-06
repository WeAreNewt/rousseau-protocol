// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.13;

import "../../interfaces/IAvaraStorage.sol";
import "../../libraries/DataTypes.sol";


contract AvaraStorage is IAvaraStorage {
  function addValue(string calldata value) external { // Only AvaraProtocol

  }
  function removeValue(uint256 index) external { // Only AvaraProtocol

  }
  function replaceValue(uint256 index, string calldata value) external { // Only AvaraProtocol

  }
  // To check if timelock is there
  function canRemove(uint256 index) external returns(bool) {
    return true;
  }
  // To check if timelock is there
  function canReplace(uint256 index) external returns(bool) {

    return true;
  }
}
