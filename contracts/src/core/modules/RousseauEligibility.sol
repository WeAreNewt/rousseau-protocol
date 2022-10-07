// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.13;

import "../../interfaces/IRousseauEligibility.sol";
import "../../libraries/DataTypes.sol";
import "@openzeppelin/token/ERC721/IERC721.sol";

contract RousseauEligibility is IRousseauEligibility {

  mapping(uint256 => mapping(address => bool)) hasVotedOnProposal;

  IERC721 nftCollection;

  constructor(address _nftCollection) {
    nftCollection = IERC721(_nftCollection);
  }

  function isElegible(address _address, bytes calldata data) external view returns (bool) {
    return nftCollection.balanceOf(_address) > 0;
  }
  function hasVoted(address _address, uint256 _proposalId, bytes calldata data) external view returns(bool) {
    return hasVotedOnProposal[_proposalId][_address];
  }
  function setVoted(address _address, uint256 _proposalId, bytes calldata data) external { //Only RousseauProtocol
    hasVotedOnProposal[_proposalId][_address] = true;
  }

  function getVoteWeight(address _address, uint256 proposalId, bytes calldata data) external view returns (uint256) {
    if(nftCollection.balanceOf(_address) > 0) return 1;
    revert();
  }
}
