// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.13;

import "../../interfaces/IRousseauRepository.sol";
import "../../libraries/DataTypes.sol";


contract RousseauRepository is IRousseauRepository {
  
  
  function addValue(string calldata value) external { // Only RousseauProtocol

  }

  function removeValue(uint256 index) external { // Only RousseauProtocol

  }

  function replaceValue(uint256 index, string calldata value) external { // Only RousseauProtocol

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
