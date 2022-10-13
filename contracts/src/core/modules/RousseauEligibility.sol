// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.16;

import "../../interfaces/IRousseauEligibility.sol";
import "../../../src/mocks/AvaraNFT.sol";
import "../../libraries/DataTypes.sol";
import "@openzeppelin/token/ERC721/IERC721.sol";

/// @title RousseauEligibility
/// @author Newt team
/// @notice This contract is used to check if a user is elegible to do actions in the rousseau protocol
contract RousseauEligibility is IRousseauEligibility {
    mapping(uint256 => mapping(uint256 => bool)) public hasVotedOnProposal;

    AvaraNFT nftCollection;

    constructor(address _nftCollection) {
        nftCollection = AvaraNFT(_nftCollection);
    }

    function canPropose(address _address, bytes calldata data)
        external
        view
        returns (bool)
    {
        for (uint256 i = 0; i < nftCollection.balanceOf(_address); i++) {
            if (
                nftCollection.isActive(
                    nftCollection.tokenOfOwnerByIndex(_address, i)
                )
            ) {
                return true;
            }
        }
        return false;
    }

    function canVote(
        address _address,
        uint256 _proposalId,
        bytes calldata data
    ) external view returns (bool) {
        uint256 tokenId = abi.decode(data, (uint256));
        return
            nftCollection.ownerOf(tokenId) == _address &&
            nftCollection.isActive(tokenId) &&
            !hasVotedOnProposal[_proposalId][tokenId];
    }

    function hasVoted(
        address _address,
        uint256 _proposalId,
        bytes calldata data
    ) external view returns (bool) {
        uint256 tokenId = abi.decode(data, (uint256));
        return hasVotedOnProposal[_proposalId][tokenId];
    }

    function setVoted(
        address _address,
        uint256 _proposalId,
        bytes calldata data
    ) external {
        //TODO: Only RousseauProtocol
        uint256 tokenId = abi.decode(data, (uint256));
        hasVotedOnProposal[_proposalId][tokenId] = true;
    }

    function getVoteWeight(
        address _address,
        uint256 _proposalId,
        bytes calldata data
    ) external view returns (uint256) {
        uint256 tokenId = abi.decode(data, (uint256));
        return hasVotedOnProposal[_proposalId][tokenId] ? 0 : 1;
    }
}
