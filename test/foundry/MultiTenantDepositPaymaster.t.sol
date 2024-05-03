// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import { BaseTest } from "./BaseTest.t.sol";
import { IEntryPoint, PackedUserOperation } from "@account-abstraction/contracts/interfaces/IEntrypoint.sol";
import { ERC4337Invoker } from "contracts/ERC4337Invoker.sol";
import { MultiTenantDepositPaymaster } from "contracts/MultiTenantDepositPaymaster.sol";

contract Test {
    event Log(address sender, string message);

    function emitLog(string memory message) public {
        emit Log(msg.sender, message);
    }
}

contract MultiTenantDepositPaymasterTest is BaseTest {
    Test internal test;
    ERC4337Invoker internal invoker;
    MultiTenantDepositPaymaster internal paymaster;

    function setUp() public override {
        super.setUp();

        test = new Test();
        invoker = new ERC4337Invoker(IEntryPoint(address(entryPoint)));
        paymaster = new MultiTenantDepositPaymaster(entryPoint);

        // Initial Paymaster Deposit into EP
        entryPoint.depositTo{ value: 1 ether }(address(paymaster));
    }

    function testSelfSponosredUserOperationExecution() public {
        // Deposit Initial Funds into Paymaster
        vm.prank(alice.addr);
        paymaster.depositTo{ value: 1 ether }(alice.addr);

        // Create Sponsorship User Operation
        PackedUserOperation memory op = PackedUserOperation({
            sender: address(invoker),
            nonce: uint256(bytes32(bytes20(address(alice.addr)))),
            initCode: hex"",
            callData: abi.encodePacked(
                ERC4337Invoker.executeUserOp.selector, abi.encode(test, 0, abi.encodeCall(Test.emitLog, "hello world"))
                ),
            paymasterAndData: abi.encodePacked(address(paymaster), uint128(1_000_000), uint128(1_000_000)),
            gasFees: bytes32(uint256((1 << 128) + 1)),
            accountGasLimits: bytes32(abi.encodePacked(uint128(1_000_000), uint128(1_000_000))),
            preVerificationGas: 1_000_000,
            signature: hex""
        });
        uint256 aliceNonce = vm.getNonce(alice.addr);
        bytes32 userOpHash = entryPoint.getUserOpHash(op);
        bytes32 hash = invoker.getDigest(userOpHash, aliceNonce);
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(alice.privateKey, hash);
        op.signature = abi.encodePacked(aliceNonce, r, s, v);

        // Execute User Operation
        entryPoint.handleOps(toArray(op), bob.addr);
    }
}
