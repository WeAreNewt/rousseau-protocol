// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.13;

import "@openzeppelin/token/ERC721/ERC721.sol";
import "@openzeppelin/access/Ownable.sol";

contract AvaraNFT is ERC721, Ownable {

  mapping(uint256 => bool) public isActive;
  uint256 counter = 0;
  uint256 public activeCount = 0;
  constructor(string memory name, string memory symbol) ERC721 (name, symbol) Ownable() {
    
  }

  function mint(address to) public {
    super._mint(to, ++counter);
  }
  
  function burn(uint256 tokenId) public {
    super._burn(tokenId);
  }

  function setIsActive(uint256 tokenId, bool status) public onlyOwner {
    isActive[tokenId] = status;
    status? counter++: counter--;
  }
}
