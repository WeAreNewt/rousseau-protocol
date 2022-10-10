// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.13;

import "../../interfaces/IRousseauEligibility.sol";
import "../../../src/mocks/AvaraNFT.sol";
import "../../libraries/DataTypes.sol";
import "@openzeppelin/token/ERC721/IERC721.sol";

contract RousseauEligibility is IRousseauEligibility {

  mapping(uint256 => mapping(uint256 => bool)) hasVotedOnProposal;

  AvaraNFT nftCollection;

  constructor(address _nftCollection) {
    nftCollection = AvaraNFT(_nftCollection);
  }

  function isElegible(address _address, bytes calldata data) external view returns (bool) {
    uint256 tokenId = abi.decode(data, (uint256));
    return nftCollection.ownerOf(tokenId) == _address && nftCollection.isActive(tokenId);
  }
  function hasVoted(address _address, uint256 _proposalId, bytes calldata data) external view returns(bool) {
    uint256 tokenId = abi.decode(data, (uint256));
    return hasVotedOnProposal[_proposalId][tokenId];
  }
  function setVoted(address _address, uint256 _proposalId, bytes calldata data) external { //TODO: Only RousseauProtocol
    uint256 tokenId = abi.decode(data, (uint256));
    hasVotedOnProposal[_proposalId][tokenId] = true;
  }

  function getVoteWeight(address _address, uint256 _proposalId, bytes calldata data) external view returns (uint256) { // TODO: Discuss ovte weight in our specific usecase
    uint256 tokenId = abi.decode(data, (uint256));
    return hasVotedOnProposal[_proposalId][tokenId] ? 0 : 1;
  }
}
