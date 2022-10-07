// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../../../src/core/modules/RousseauQuorum.sol";
import "../../../src/core/modules/RousseauEligibility.sol";
import "../../../src/mocks/AvaraNFT.sol";

contract RousseauQuorumTests is Test {

    RousseauQuorum quorum;
    AvaraNFT nft;
    function setUp() public {
        nft = new AvaraNFT('AVARA NFT', 'AVR');
        quorum = new RousseauQuorum(100, 101, address(nft), address(0), 50);
    }

    function testGetVotePeriod() public {
        assertEq(quorum.getVotePeriod(), 100);
    }

    function testGetVoteDelay() public {
        assertEq(quorum.getVoteDelay(), 101);
    }

    function testHasQuorumTrue() public {
        nft.mint(address(this));
        assertEq(quorum.hasQuorum(2, 0, 0), true);
    }

    function testHasQuorumFalse() public {
        nft.mint(address(this));
        assertEq(quorum.hasQuorum(2, 0, 0), true);
    }

    // TODO: Deeply test hasquorum function
    
}
