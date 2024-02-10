// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.23 <0.9.0;

import { PRBTest } from "@prb/test/src/PRBTest.sol";
import { Lock } from "../../contracts/Lock.sol";



contract LockTest is PRBTest {
    Lock public lock;
    address payable public owner;

    receive() external payable {}

    function setUp() public {
        owner = payable(address(this));
        uint256 unlockTime = block.timestamp + 1 days; // Set unlock time to 1 day from now
        lock = new Lock{ value: 1 ether}(unlockTime);
    }

    function testInitialOwner() public {
        assertEq(lock.owner(), owner);
    }

    function testWithdrawal() public {
        // Fast forward time to surpass the unlockTime
        vm.warp(block.timestamp + 2 days);

        uint256 initialBalance = address(this).balance;
        lock.withdraw();
        uint256 finalBalance = address(this).balance;

        // Check if the contract's balance was transferred to the owner
        assertGt(finalBalance, initialBalance);
    }

    function testFailWithdrawTooEarly() public {
        // This test is expected to fail as the withdrawal is too early
        lock.withdraw();
    }

    function testFailWithdrawByNonOwner() public {
        // Change the sender to someone other than the owner
        vm.prank(address(0x123));
        lock.withdraw();
    }
}