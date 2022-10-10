// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.13;

import "../../interfaces/IRousseauRepository.sol";
import "../../libraries/DataTypes.sol";


contract RousseauRepository is IRousseauRepository {
  
  

  function addValue(string calldata value) external { //TODO: Only RousseauProtocol

  }

  function removeValue(uint256 index) external { //TODO:  Only RousseauProtocol

  }

  function replaceValue(uint256 index, string calldata value) external { //TODO: Only RousseauProtocol

  }
  
  // TODO: check if timelock is there
  function canRemove(uint256 index) external returns(bool) {
    return true;
  }
  
  // TODO: check if timelock is there
  function canReplace(uint256 index) external returns(bool) {
    return true;
  }

  function addComment(uint256 proposalId, string calldata comment) external {

  }
}
