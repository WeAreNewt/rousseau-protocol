// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.16;

import "forge-std/Test.sol";
import "../../../src/core/modules/RousseauRepository.sol";

contract RousseauRepositoryTests is Test {
    RousseauRepository repository;
    address deployer = address(1);
    address protocol = address(2);

    function setUp() public {
        vm.startPrank(deployer);
        repository = new RousseauRepository();
    }

    function testCanNotInitializeIfNotOwner() public {
        vm.stopPrank();
        vm.prank(address(3));
        vm.expectRevert("Ownable: caller is not the owner");
        repository.initialize(protocol);
    }

    function testCanInitializeIfOwner() public {
        repository.initialize(protocol);
        assertEq(deployer, repository.owner());
    }

    function testInitializeWithZeroAddress() public {
        vm.expectRevert(abi.encodeWithSignature("ZeroAddressNotAllowed()"));
        repository.initialize(address(0));
    }

    function testCanNotCallAddValueIfNotInitialized() public {
        vm.expectRevert(abi.encodeWithSignature("NotInitialized()"));
        repository.addValue(
            0,
            "test value",
            block.timestamp,
            abi.encode("0")
        );
    }

    function testCanNotCallRemoveValueIfNotInitialized() public {
        vm.expectRevert(abi.encodeWithSignature("NotInitialized()"));
        repository.removeValue(0, 0, block.timestamp, abi.encode("0"));
    }

    function testCanNotCallReplaceValueIfNotInitialized() public {
        vm.expectRevert(abi.encodeWithSignature("NotInitialized()"));
        repository.replaceValue(
            0,
            "test value",
            0,
            block.timestamp,
            abi.encode("0")
        );
    }

    function testCanNotCallCanRemoveIfNotInitialized() public {
        vm.expectRevert(abi.encodeWithSignature("NotInitialized()"));
        repository.removeValue(0, 0, block.timestamp, abi.encode("0"));
    }

    function testCanNotCallAddCommentIfNotInitialized() public {
        vm.expectRevert(abi.encodeWithSignature("NotInitialized()"));
        repository.addComment(0, "test value", msg.sender);
    }

    function testAddValue() public {
        repository.initialize(protocol);
        vm.stopPrank();
        vm.startPrank(protocol);
        repository.addValue(
            0,
            "test value",
            block.timestamp,
            abi.encode("0")
        );
        assertEq(repository.activeValues(0), 0);
    }

    function testRemoveValue() public {
        repository.initialize(protocol);
        vm.stopPrank();
        vm.startPrank(protocol);
        repository.addValue(
            0,
            "test value",
            block.timestamp,
            abi.encode(block.timestamp)
        );
        repository.removeValue(1, 0, block.timestamp, abi.encode("0"));
        assertEq(repository.activeValues(0), 0);
    }

    function testRemoveValueIfTimelockedPermanently() public {
        repository.initialize(protocol);
        vm.stopPrank();
        vm.startPrank(protocol);
        repository.addValue(
            0,
            "test value",
            block.timestamp,
            abi.encode("1")
        );
        console.log(repository.timelocks(0));
        vm.expectRevert(abi.encodeWithSignature("Timelocked()"));
        repository.removeValue(1, 0, block.timestamp, abi.encode(""));
    }

    function testRemoveValueIfTimelocked() public {
        repository.initialize(protocol);
        vm.stopPrank();
        vm.startPrank(protocol);
        repository.addValue(
            0,
            "test value",
            block.timestamp,
            abi.encode("2")
        );
        vm.expectRevert(abi.encodeWithSignature("Timelocked()"));
        repository.removeValue(1, 0, block.timestamp, abi.encode("0"));
    }

    function testReplaceValueIfTimelockedPermanently() public {
        repository.initialize(protocol);
        vm.stopPrank();
        vm.startPrank(protocol);
        repository.addValue(
            0,
            "test value",
            block.timestamp,
            abi.encode("1")
        );
        console.log(repository.timelocks(0));
        vm.expectRevert(abi.encodeWithSignature("Timelocked()"));
        repository.replaceValue(
            1,
            "new value",
            0,
            block.timestamp,
            abi.encode("")
        );
    }

    function testReplaceValueIfTimelocked() public {
        repository.initialize(protocol);
        vm.stopPrank();
        vm.startPrank(protocol);
        repository.addValue(
            0,
            "test value",
            block.timestamp,
            abi.encode("10")
        );
        vm.expectRevert(abi.encodeWithSignature("Timelocked()"));
        repository.replaceValue(
            1,
            "new value",
            0,
            block.timestamp,
            abi.encode("0")
        );
    }

    function testReplaceValue() public {
        repository.initialize(protocol);
        vm.stopPrank();
        vm.startPrank(protocol);
        repository.addValue(
            0,
            "test value",
            block.timestamp,
            abi.encode("0")
        );
        console.log(repository.timelocks(0));
        repository.replaceValue(
            1,
            "new value",
            0,
            block.timestamp,
            abi.encode("")
        );
        assertEq(repository.activeValues(0), 1);
    }

    function testCanRemoveWithPermamentTimelock() public {
        repository.initialize(protocol);
        vm.stopPrank();
        vm.startPrank(protocol);
        repository.addValue(
            0,
            "test value",
            block.timestamp,
            abi.encode("1")
        );
        assertEq(repository.canRemove(1, 0), false);
    }

    function testCanRemoveWithTimelock() public {
        repository.initialize(protocol);
        vm.stopPrank();
        vm.startPrank(protocol);
        repository.addValue(
            0,
            "test value",
            block.timestamp,
            abi.encode("10")
        );
        assertEq(repository.canRemove(1, 0), false);
    }

    function testCanReplaceWithTimelock() public {
        repository.initialize(protocol);
        vm.stopPrank();
        vm.startPrank(protocol);
        repository.addValue(
            0,
            "test value",
            block.timestamp,
            abi.encode("10")
        );
        assertEq(repository.canReplace(1, 0), false);
    }

    function testCanReplaceWithPermanentTimelock() public {
        repository.initialize(protocol);
        vm.stopPrank();
        vm.startPrank(protocol);
        repository.addValue(
            0,
            "test value",
            block.timestamp,
            abi.encode("1")
        );
        assertEq(repository.canReplace(1, 0), false);
    }

    function testCanRemoveWithoutTimelock() public {
        repository.initialize(protocol);
        vm.stopPrank();
        vm.startPrank(protocol);
        repository.addValue(
            0,
            "test value",
            block.timestamp,
            abi.encode("0")
        );
        assertEq(repository.canRemove(1, 0), true);
    }

    function testCanReplaceWithoutTimelock() public {
        repository.initialize(protocol);
        vm.stopPrank();
        vm.startPrank(protocol);
        repository.addValue(
            0,
            "test value",
            block.timestamp,
            abi.encode("0")
        );
        assertEq(repository.canReplace(1, 0), true);
    }

    function testAddComment() public {
        repository.initialize(protocol);
        vm.stopPrank();
        vm.startPrank(protocol);
        repository.addValue(
            0,
            "test value",
            block.timestamp,
            abi.encode("0")
        );
        repository.addComment(0, "test comment", msg.sender);
        string memory value;
        uint256 date;
        address author;
        (value, date, author) = repository.comments(0, 0);
        assertEq(author, msg.sender);
    }
}
