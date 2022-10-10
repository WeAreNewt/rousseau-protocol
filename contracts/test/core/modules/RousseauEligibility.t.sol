// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../../../src/core/modules/RousseauEligibility.sol";
import "../../../src/mocks/AvaraNFT.sol";

contract RousseauEligibilityTests is Test {
    RousseauEligibility eligibility;
    AvaraNFT nft;

    address[] users = [address(1), address(2), address(3)];

    function setUp() public {
        nft = new AvaraNFT('AVARA NFT', 'AVR');
        eligibility = new RousseauEligibility(address(nft));

        nft.mint(users[0]);
        nft.mint(users[1]);
        nft.setIsActive(0, true);
        nft.setIsActive(1, false);

        assertEq(nft.isActive(0), true);
        assertEq(nft.isActive(1), false);
    }

    function testIsElegibleIfActiveNFTHolder() public {
        bool res = eligibility.isElegible(users[0], abi.encode(0));
        assertTrue(res);
    }

    function testIsElegibleIfInactiveNFTHolder() public {
        bool res = eligibility.isElegible(users[1], abi.encode(1));
        assertFalse(res);
    }
    
    function testIsElegibleIfNotNFTHolder() public {
        bool res = eligibility.isElegible(users[2], abi.encode(0));
        assertFalse(res);
    }

    function testSetVoted() public {
        eligibility.setVoted(users[0], 0, abi.encode(0));
        bool res = eligibility.hasVoted(users[0], 0, abi.encode(0));
        assertTrue(res);
    }

    function testHasVotedIfVoted() public {
        eligibility.setVoted(users[0], 0, abi.encode(0));
        bool res = eligibility.hasVoted(users[0], 0, abi.encode(0));
        assertTrue(res);
    }

    function testHasVotedIfNotVoted() public {
        bool res = eligibility.hasVoted(users[0], 0, abi.encode(0));
        assertFalse(res);
    }

    function testGetVoteWeightIfVoted() public {
        eligibility.setVoted(users[0], 0, abi.encode(0));
        uint256 res = eligibility.getVoteWeight(users[0], 0, abi.encode(0));
        assertEq(res, 0);
    }

    function testGetVoteWeightIfNotVoted() public {
        uint256 res = eligibility.getVoteWeight(users[0], 0, abi.encode(0));
        assertEq(res, 1);
    }
}
