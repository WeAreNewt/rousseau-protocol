// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.13;

import "../../interfaces/IRousseauRepository.sol";
import "../../libraries/DataTypes.sol";


contract RousseauRepository is IRousseauRepository {
  
  function addValue(bytes calldata data) external { //TODO: Only RousseauProtocol

  }

  function removeValue(bytes calldata data) external { //TODO:  Only RousseauProtocol

  }

  function replaceValue(bytes calldata data) external { //TODO: Only RousseauProtocol

  }
  
  // TODO: check if timelock is there
  function canRemove(bytes calldata data) external returns(bool) {
    return true;
  }
  
  // TODO: check if timelock is there
  function canReplace(bytes calldata data) external returns(bool) {
    return true;
  }

  function addComment(bytes calldata data) external {

  }
}
