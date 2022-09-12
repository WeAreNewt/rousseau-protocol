// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.13;

import "@openzeppelin/token/ERC721/ERC721.sol";
import "@openzeppelin/access/Ownable.sol";

contract AvaraNFT is ERC721, Ownable {

  mapping(uint256 => bool) public isActive;
  uint256 counter = 0;
  constructor() ERC721 ("test", "TST") Ownable() {
    
  }

  function mint(uint256 amount) public {
    for(uint256 i = 0; i < amount; i++) {
      super._mint(msg.sender, ++counter);
    } 
  }
  
  function burn(uint256 tokenId) public {
    super._burn(tokenId);
  }

  function setIsActive(uint256 tokenId, bool status) public onlyOwner {
    isActive[tokenId] = status;
  }
}
