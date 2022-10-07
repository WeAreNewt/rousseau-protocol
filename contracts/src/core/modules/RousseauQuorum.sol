// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.13;

import "../../interfaces/IRousseauQuorum.sol";
import "../../libraries/DataTypes.sol";
import "../../mocks/AvaraNFT.sol";
import "@openzeppelin/token/ERC721/IERC721.sol";

contract RousseauQuorum is IRousseauQuorum {

  error NotElegible();

  uint256 private votePeriod;
  uint256 private voteDelay;
  AvaraNFT private nftCollection;
  address private eligibilityModuleAddress;
  uint256 private quorumPercentage;

  constructor(
    uint256 _votePeriod,
    uint256 _voteDelay,
    address _nftCollectionAddress,
    address _eligibilityModuleAddress,
    uint256 _quorumPercentage
  ) {
    votePeriod = _votePeriod;
    voteDelay = _voteDelay;
    nftCollection = AvaraNFT(_nftCollectionAddress);
    eligibilityModuleAddress = _eligibilityModuleAddress;
    quorumPercentage = _quorumPercentage;
  }

  function hasQuorum(uint256 yes, uint256 no, uint256 abstain) external view returns(bool) {
    return nftCollection.activeCount() > 0 && (yes + no + abstain) * 100 / nftCollection.activeCount() >= quorumPercentage && yes > no;
  }

  function getVotePeriod() external view returns (uint256) {
    return votePeriod;
  }
  
  function getVoteDelay() external view returns (uint256) {
    return voteDelay;
  }
}
