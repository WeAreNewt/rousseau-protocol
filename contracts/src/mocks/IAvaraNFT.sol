// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.13;

interface IAvaraNFT {
  function setIsActive(uint256 tokenId, bool status) external;
}
