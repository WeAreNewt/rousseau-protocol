// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.16;

import "../../interfaces/IRousseauRepository.sol";
import "../../libraries/DataTypes.sol";


contract RousseauRepository is IRousseauRepository {
  
  mapping(uint256 => uint256) timelocks;

  function addValue(uint256 proposalId, string calldata value, uint256 data, uint256 date) external { //TODO: Only RousseauProtocol
  
  }

  function removeValue(uint256 proposalId, string calldata value, uint256 data, uint256 date) external { //TODO:  Only RousseauProtocol

  }

  function replaceValue(uint256 proposalId, string calldata value, uint256 data, uint256 date) external { //TODO: Only RousseauProtocol

  }
  
  // TODO: check if timelock is there
  function canRemove(uint256 proposalId, uint256 kind, uint256 data, uint256 start) external returns(bool) {
    return true;
  }
  
  // TODO: check if timelock is there
  function canReplace(uint256 proposalId, uint256 kind, uint256 data, uint256 start) external returns(bool) {
    return true;
  }

  function addComment(uint256 proposalId, string calldata value) external {

  }
}
