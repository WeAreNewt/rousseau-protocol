// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.16;

import "@openzeppelin/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/access/Ownable.sol";

contract AvaraNFT is ERC721Enumerable, Ownable {
    mapping(uint256 => bool) public isActive;
    uint256 counter = 0;
    uint256 public activeCount = 0;

    error NotTokenOwner();

    /// @notice constructor of the contract
    /// @param name name of the NFT
    /// @param symbol symbol of the NFT
    constructor(string memory name, string memory symbol)
        ERC721(name, symbol)
        Ownable()
    {}

    /// @notice mint a new NFT
    /// @param to address to mint to
    function mint(address to) public {
        super._mint(to, counter);
        isActive[counter] = true;
        ++counter;
        ++activeCount;
    }

    /// @notice burn an NFT
    /// @param tokenId id of the NFT to burn
    function burn(uint256 tokenId) public {
        if(msg.sender != ownerOf(tokenId)) revert NotTokenOwner();
        isActive[counter] = false;
        --activeCount;
        super._burn(tokenId);
    }

    /// @notice set the active status of an NFT
    /// @param tokenId id of the NFT to set the active status of
    /// @param status the new active status
    function setIsActive(uint256 tokenId, bool status) public onlyOwner {
        isActive[tokenId] = status;
        status ? ++counter : --counter;
    }
}
