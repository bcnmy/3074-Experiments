// SPDX-License-Identifier: MIT

pragma solidity ^0.8.23;

import { Test } from "forge-std/src/Test.sol";
import { EntryPoint, PackedUserOperation } from "@account-abstraction/contracts/core/EntryPoint.sol";
import { ToArrayUtils } from "./utils/ToArrayUtils.sol";

/* solhint-disable ordering*/

abstract contract SATestBase is Test, ToArrayUtils {
    // Test Accounts
    struct TestAccount {
        address payable addr;
        uint256 privateKey;
    }

    // Test Environment Configuration
    string internal constant MNEMONIC = "test test test test test test test test test test test junk";
    uint256 internal constant TEST_ACCOUNT_COUNT = 10;
    uint256 internal constant INITIAL_MAIN_ACCOUNT_FUNDS = 100_000 ether;
    uint256 internal constant DEFAULT_PRE_VERIFICATIION_GAS = 21_000;

    uint32 internal nextKeyIndex;

    TestAccount[] internal testAccounts;
    mapping(address account => TestAccount) internal testAccountsByAddress;
    TestAccount internal alice;
    TestAccount internal bob;
    TestAccount internal charlie;
    TestAccount internal dan;
    TestAccount internal emma;
    TestAccount internal frank;
    TestAccount internal george;
    TestAccount internal henry;
    TestAccount internal ida;

    TestAccount internal owner;

    // ERC4337 Contracts
    EntryPoint internal entryPoint;

    function getNextPrivateKey() internal returns (uint256) {
        return vm.deriveKey(MNEMONIC, ++nextKeyIndex);
    }

    function setUp() public virtual {
        // Generate Test Addresses
        for (uint256 i = 0; i < TEST_ACCOUNT_COUNT; i++) {
            uint256 privateKey = getNextPrivateKey();
            testAccounts.push(TestAccount(payable(vm.addr(privateKey)), privateKey));
            testAccountsByAddress[testAccounts[i].addr] = testAccounts[i];

            deal(testAccounts[i].addr, INITIAL_MAIN_ACCOUNT_FUNDS);
        }

        // Name Test Addresses
        alice = testAccounts[0];
        vm.label(alice.addr, string.concat("Alice", vm.toString(uint256(0))));

        bob = testAccounts[1];
        vm.label(bob.addr, string.concat("Bob", vm.toString(uint256(1))));

        charlie = testAccounts[2];
        vm.label(charlie.addr, string.concat("Charlie", vm.toString(uint256(2))));

        dan = testAccounts[3];
        vm.label(dan.addr, string.concat("Dan", vm.toString(uint256(3))));

        emma = testAccounts[4];
        vm.label(emma.addr, string.concat("Emma", vm.toString(uint256(4))));

        frank = testAccounts[5];
        vm.label(frank.addr, string.concat("Frank", vm.toString(uint256(5))));

        george = testAccounts[6];
        vm.label(george.addr, string.concat("George", vm.toString(uint256(6))));

        henry = testAccounts[7];
        vm.label(henry.addr, string.concat("Henry", vm.toString(uint256(7))));

        ida = testAccounts[7];
        vm.label(ida.addr, string.concat("Ida", vm.toString(uint256(8))));

        // Name Owner
        owner = testAccounts[8];
        vm.label(owner.addr, string.concat("Owner", vm.toString(uint256(9))));

        // Deploy ERC4337 Contracts
        entryPoint = new EntryPoint();
        vm.label(address(entryPoint), "Entry Point");

        // Ensure non zero timestamp
        vm.warp(1_703_452_990); // Sunday, December 24, 2023 9:23:10 PM GMT
    }
}
