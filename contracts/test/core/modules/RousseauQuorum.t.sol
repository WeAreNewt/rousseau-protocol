// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../../../src/core/modules/RousseauQuorum.sol";
import "../../../src/core/modules/RousseauEligibility.sol";
import "../../../src/mocks/AvaraNFT.sol";

contract RousseauQuorumTests is Test {

    RousseauQuorum quorum;
    RousseauEligibility eligibility;
    AvaraNFT nft;
    function setUp() public {
        nft = new AvaraNFT('AVARA NFT', 'AVR');
        quorum = new RousseauQuorum(100, 100, address(nft), address(0), 50);
    }

    function testExample() public {
        assertTrue(true);
    }
}
