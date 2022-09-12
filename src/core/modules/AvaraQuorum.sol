// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.13;

import "../../interfaces/IAvaraQuorum.sol";
import "../../libraries/DataTypes.sol";
import "@openzeppelin/token/ERC721/IERC721.sol";

contract AvaraQuorum is IAvaraQuorum {

  uint256 private votePeriod;
  uint256 private voteDelay;
  IERC721 private nftCollection;

  constructor(uint256 _votePeriod, uint256 _voteDelay, address nftCollectionAddress) {
    votePeriod = _votePeriod;
    voteDelay = _voteDelay;
    nftCollection = IERC721(nftCollectionAddress);
  }

  function hasQuorum(uint256 yes, uint256 no, uint256 abstain) external view returns(bool) {
    return true;
  }
  function getVotePeriod() external view returns (uint256) {
    return votePeriod;
  }
  function getVoteDelay() external view returns (uint256) {
    return voteDelay;
  }
}
