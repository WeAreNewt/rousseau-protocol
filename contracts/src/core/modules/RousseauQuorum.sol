// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.13;


import "../../interfaces/IRousseauEligibility.sol";
import "../../interfaces/IRousseauQuorum.sol";
import "../../libraries/DataTypes.sol";
import "@openzeppelin/token/ERC721/IERC721.sol";

contract RousseauQuorum is IRousseauQuorum {

  error NotElegible();

  uint256 private votePeriod;
  uint256 private voteDelay;
  address private nftCollectionAddress;
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
    nftCollectionAddress = _nftCollectionAddress;
    eligibilityModuleAddress = _eligibilityModuleAddress;
    quorumPercentage = _quorumPercentage;
  }

  function hasQuorum(uint256 yes, uint256 no, uint256 abstain) external view returns(bool) {
    //IERC721(nftCollectionAddress).co
  }
  function getVotePeriod() external view returns (uint256) {
    return votePeriod;
  }
  function getVoteDelay() external view returns (uint256) {
    return voteDelay;
  }
  
  function getVoteWeight(address voter, uint256 proposalId, bytes calldata data) external view returns (uint256) {
    if(IRousseauEligibility(eligibilityModuleAddress).isElegible(voter, data)) return 1;
    revert NotElegible();
  }
}
