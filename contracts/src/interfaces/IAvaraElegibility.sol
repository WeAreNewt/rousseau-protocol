// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.13;

interface IAvaraElegibility {
  function isElegible(address _address) external view returns (bool);
  function hasVoted(address _address, uint256 _proposalId) external view returns(bool);
  function setVoted(address _address, uint256 _proposalId) external;
}
