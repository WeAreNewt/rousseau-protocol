// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../../src/mocks/AvaraNFT.sol";

contract AvaraNFTTest is Test {
    address deployer = address(1);
    address user1 = address(3);
    address user2 = address(2);
    AvaraNFT nftCollection;

    function setUp() public {
        vm.prank(deployer);
        nftCollection = new AvaraNFT("TEST", "TST");
    }

    function testMint() public {
        nftCollection.mint(user1);
        assertEq(1, nftCollection.balanceOf(user1));
    }

    function testBurn() public {
        vm.startPrank(user1);
        nftCollection.mint(user1);
        nftCollection.burn(1);
        assertEq(0, nftCollection.balanceOf(user1));
    }

    function testIsActiveIfOwner() public {
        vm.startPrank(deployer);
        nftCollection.mint(user1);
        nftCollection.setIsActive(1, true);
        assertEq(nftCollection.isActive(1), true);
    }  
     function testIsActiveIfNotOwner() public {
        nftCollection.mint(user1);
        vm.expectRevert("Ownable: caller is not the owner");
        nftCollection.setIsActive(1, true);
    }    
}
