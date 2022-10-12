// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.16;

import "@openzeppelin/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/access/Ownable.sol";

contract AvaraNFT is ERC721Enumerable, Ownable {

  mapping(uint256 => bool) public isActive;
  uint256 counter = 0;
  uint256 public activeCount = 0;
  constructor(string memory name, string memory symbol) ERC721 (name, symbol) Ownable() {}

  function mint(address to) public {
    super._mint(to, counter);
    isActive[counter] = true;
    ++counter;
    ++activeCount;
  }
  
  function burn(uint256 tokenId) public {
    isActive[counter] = false;
    --activeCount;
    super._burn(tokenId);
  }

  function setIsActive(uint256 tokenId, bool status) public onlyOwner {
    isActive[tokenId] = status;
    status? ++counter: --counter;
  }
}
