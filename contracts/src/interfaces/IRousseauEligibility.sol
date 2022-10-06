// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.13;

interface IRousseauEligibility {
  function isElegible(address _address, bytes calldata data) external view returns (bool);
  function hasVoted(address _address, uint256 _proposalId, bytes calldata data) external view returns(bool);
  function setVoted(address _address, uint256 _proposalId, bytes calldata data) external;
}
