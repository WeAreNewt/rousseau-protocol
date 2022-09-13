// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.13;


import "../../interfaces/IAvaraElegibility.sol";
import "../../interfaces/IAvaraQuorum.sol";
import "../../libraries/DataTypes.sol";
import "@openzeppelin/token/ERC721/IERC721.sol";

contract AvaraQuorum is IAvaraQuorum {

  error NotElegible();

  uint256 private votePeriod;
  uint256 private voteDelay;
  address private nftCollectionAddress;
  address private elegibilityModuleAddress;

  constructor(uint256 _votePeriod, uint256 _voteDelay, address _nftCollectionAddress, address _elegibilityModuleAddress) {
    votePeriod = _votePeriod;
    voteDelay = _voteDelay;
    nftCollectionAddress = _nftCollectionAddress;
    elegibilityModuleAddress = _elegibilityModuleAddress;
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
  
  function getVoteWeight(address voter, uint256 proposalId) external view returns (uint256) {
    if(IAvaraElegibility(elegibilityModuleAddress).isElegible(voter)) return 1;
    revert NotElegible();
  }
}
