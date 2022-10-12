// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.16;

import "forge-std/Test.sol";
import "../../../src/core/modules/RousseauEligibility.sol";
import "../../../src/core/modules/RousseauQuorum.sol";
import "../../../src/core/modules/RousseauRepository.sol";
import "../../../src/mocks/AvaraNFT.sol";
import "../../../src/core/base/RousseauProtocol.sol";
import "../../../src/libraries/DataTypes.sol";

contract RousseauProtocolTests is Test {
    RousseauProtocol protocol;
    RousseauEligibility eligibility;
    RousseauQuorum quorum;
    RousseauRepository repository;
    AvaraNFT nft;

    address[] users = [
        address(1),
        address(2),
        address(3),
        address(4),
        address(5)
    ];

    function setUp() public {
        nft = new AvaraNFT("AVARA NFT", "AVR");
        eligibility = new RousseauEligibility(address(nft));
        // vote period, vote delay, nft collection address, eligibility module address, quorum percentage
        quorum = new RousseauQuorum(100, 101, address(nft), 50);
        repository = new RousseauRepository();
        protocol = new RousseauProtocol(
            address(eligibility),
            address(quorum),
            address(repository)
        );
        repository.initialize(address(protocol));
        /*
        Setup users to do tests, here your setup might change because you will need to give different eligibility status to different users
        */

        // Everyone will have a nft but not the user 4
        for (uint256 i = 0; i < users.length - 1; i++) {
            nft.mint(users[i]);
        }

        // The user 3 will ha ve the nft disabled
        nft.setIsActive(3, false);
    }

    function testCreateProposalWithNullValue() public {
        vm.prank(users[0]);
        vm.expectRevert(abi.encodeWithSignature("ValueMustNotBeNull()"));
        protocol.createProposal("", 1, 0, abi.encode(""), abi.encode(0));
    }

    function testCreateProposalWithoutNFT() public {
        vm.prank(users[4]);
        vm.expectRevert(abi.encodeWithSignature("NotElegible()"));
        protocol.createProposal("test", 1, 0, abi.encode(""), abi.encode(0));
    }

    function testCreateProposalWithInactiveNFT() public {
        vm.prank(users[3]);
        vm.expectRevert(abi.encodeWithSignature("NotElegible()"));
        protocol.createProposal("test", 1, 0, abi.encode(""), abi.encode(0));
    }

    function testCreateProposalWithInvalidType() public {
        vm.prank(users[0]);
        vm.expectRevert(abi.encodeWithSignature("InvalidProposalType()"));
        protocol.createProposal("test", 3, 1, abi.encode(""), abi.encode(0));
    }

    function testCreateRemoveProposalWithRepositoryLock() public {
        vm.prank(users[0]);
        //TODO: Revisit once we have the repository done: vm.expectRevert(abi.encodeWithSignature('RepositoryError()'));
        protocol.createProposal("test", 1, 1, abi.encode(""), abi.encode(0));
    }

    function testCreateReplaceProposalWithRepositoryLock() public {
        vm.prank(users[0]);
        //TODO: Revisit once we have the repository done: vm.expectRevert(abi.encodeWithSignature('RepositoryError()'));
        protocol.createProposal("test", 2, 1, abi.encode(""), abi.encode(0));
    }

    function testCreateRemoveProposalWithoutRepositoryLock() public {
        vm.prank(users[0]);
        protocol.createProposal("test", 1, 1, abi.encode(""), abi.encode(0));
        //TODO: check the revert
    }

    function testCreateReplaceProposalWithoutRepositoryLock() public {
        vm.prank(users[0]);
        protocol.createProposal("test", 2, 1, abi.encode(""), abi.encode(0));
        //TODO: check if the proposal was created
    }

    function testVoteProposalIfCanVote() public {
        setupTestProposal();

        vm.warp(block.timestamp + quorum.getVoteDelay());
        vm.prank(users[1]);
        protocol.voteProposal(0, 1, "This is a comment", abi.encode(1));
        //TODO: check that the vote was increased with the good weight to yes and it's registered on eligibility
    }

    function testVoteProposalIfCantVote() public {
        setupTestProposal();

        vm.warp(block.timestamp + quorum.getVoteDelay());
        vm.prank(users[3]);
        vm.expectRevert(abi.encodeWithSignature("NotElegible()"));
        protocol.voteProposal(0, 1, "This is a comment", abi.encode(3));
    }

    function testVoteProposalIfVoteNotStarted() public {
        setupTestProposal();

        vm.prank(users[1]);
        vm.expectRevert(abi.encodeWithSignature("VoteNotStarted()"));
        protocol.voteProposal(0, 1, "This is a comment", abi.encode(1));
    }

    function testVoteProposalIfVoteFinished() public {
        setupTestProposal();
        vm.warp(
            block.timestamp + quorum.getVotePeriod() + quorum.getVoteDelay() + 1
        );
        vm.prank(users[1]);
        vm.expectRevert(abi.encodeWithSignature("VoteAlreadyFinished()"));
        protocol.voteProposal(0, 0, "This is a comment", abi.encode(1));
    }

    function testVoteIfAlreadyVoted() public {
        setupTestProposal();

        vm.prank(users[1]);
        vm.warp(block.timestamp + quorum.getVoteDelay() + 1);
        vm.expectRevert(abi.encodeWithSignature("NotElegible()"));
        protocol.voteProposal(0, 1, "This is a comment", abi.encode(1));
    }

    function testExecuteProposalIfQuorumNotReached() public {
        setupTestProposal();
        vm.warp(block.timestamp + quorum.getVoteDelay());
        vm.prank(users[1]);
        protocol.voteProposal(0, 1, "This is a comment", abi.encode(1));
        vm.warp(
            block.timestamp + quorum.getVotePeriod() + quorum.getVoteDelay() + 1
        );
        vm.expectRevert(abi.encodeWithSignature("QuorumNotReached()"));
        protocol.executeProposal(0);
    }

    function testExecuteWithVoteStillGoing() public {
        setupTestProposal();
        fillQuorum();
        vm.expectRevert(abi.encodeWithSignature("VoteStillGoing()"));
        protocol.executeProposal(0);
    }

    function testExecuteAddProposal() public {
        vm.prank(users[0]);
        protocol.createProposal("test", 0, 1, abi.encode(""), abi.encode(0));
        fillQuorum();
        vm.warp(block.timestamp + quorum.getVotePeriod() + 1);
        protocol.executeProposal(0);
    }

    function testExecutionRemoveProposal() public {
        vm.prank(users[0]);
        protocol.createProposal("test", 1, 1, abi.encode(""), abi.encode(0));
        fillQuorum();
        vm.warp(block.timestamp + quorum.getVotePeriod() + 1);
        protocol.executeProposal(0);
    }

    function testExecutionReplaceProposal() public {
        vm.prank(users[0]);
        protocol.createProposal("test", 2, 1, abi.encode(""), abi.encode(0));
        fillQuorum();
        vm.warp(block.timestamp + quorum.getVotePeriod() + 1);
        protocol.executeProposal(0);
    }

    function setupTestProposal() internal {
        vm.prank(users[0]);
        protocol.createProposal("test", 1, 1, abi.encode(""), abi.encode(0));
    }

    function fillQuorum() internal {
        vm.warp(block.timestamp + quorum.getVoteDelay() + 1);
        vm.prank(users[0]);
        protocol.voteProposal(0, 0, "This is a comment", abi.encode(0));
        vm.prank(users[1]);
        protocol.voteProposal(0, 0, "This is a comment", abi.encode(1));
        vm.prank(users[2]);
        protocol.voteProposal(0, 0, "This is a comment", abi.encode(2));
    }
}
