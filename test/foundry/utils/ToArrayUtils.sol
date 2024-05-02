// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { PackedUserOperation } from "@account-abstraction/contracts/core/EntryPoint.sol";

abstract contract ToArrayUtils {
    // User Operations
    function toArray(PackedUserOperation memory _op) internal pure returns (PackedUserOperation[] memory) {
        PackedUserOperation[] memory ops = new PackedUserOperation[](1);
        ops[0] = _op;
        return ops;
    }

    function toArray(
        PackedUserOperation memory _op1,
        PackedUserOperation memory _op2
    )
        internal
        pure
        returns (PackedUserOperation[] memory)
    {
        PackedUserOperation[] memory ops = new PackedUserOperation[](2);
        ops[0] = _op1;
        ops[1] = _op2;
        return ops;
    }

    function toArray(
        PackedUserOperation memory _op1,
        PackedUserOperation memory _op2,
        PackedUserOperation memory _op3
    )
        internal
        pure
        returns (PackedUserOperation[] memory)
    {
        PackedUserOperation[] memory ops = new PackedUserOperation[](3);
        ops[0] = _op1;
        ops[1] = _op2;
        ops[2] = _op3;
        return ops;
    }

    // uint64
    function toArrayU64(uint64 _a) internal pure returns (uint64[] memory) {
        uint64[] memory arr = new uint64[](1);
        arr[0] = _a;
        return arr;
    }

    function toArrayU64(uint64 _a, uint64 _b) internal pure returns (uint64[] memory) {
        uint64[] memory arr = new uint64[](2);
        arr[0] = _a;
        arr[1] = _b;
        return arr;
    }

    function toArrayU64(uint64 _a, uint64 _b, uint64 _c) internal pure returns (uint64[] memory) {
        uint64[] memory arr = new uint64[](3);
        arr[0] = _a;
        arr[1] = _b;
        arr[2] = _c;
        return arr;
    }

    // uint256
    function toArray(uint256 _a) internal pure returns (uint256[] memory) {
        uint256[] memory arr = new uint256[](1);
        arr[0] = _a;
        return arr;
    }

    function toArray(uint256 _a, uint256 _b) internal pure returns (uint256[] memory) {
        uint256[] memory arr = new uint256[](2);
        arr[0] = _a;
        arr[1] = _b;
        return arr;
    }

    function toArray(uint256 _a, uint256 _b, uint256 _c) internal pure returns (uint256[] memory) {
        uint256[] memory arr = new uint256[](3);
        arr[0] = _a;
        arr[1] = _b;
        arr[2] = _c;
        return arr;
    }

    // bytes
    function toArray(bytes memory _a) internal pure returns (bytes[] memory) {
        bytes[] memory arr = new bytes[](1);
        arr[0] = _a;
        return arr;
    }

    function toArray(bytes memory _a, bytes memory _b) internal pure returns (bytes[] memory) {
        bytes[] memory arr = new bytes[](2);
        arr[0] = _a;
        arr[1] = _b;
        return arr;
    }

    function toArray(bytes memory _a, bytes memory _b, bytes memory _c) internal pure returns (bytes[] memory) {
        bytes[] memory arr = new bytes[](3);
        arr[0] = _a;
        arr[1] = _b;
        arr[2] = _c;
        return arr;
    }

    // address
    function toArray(address _a) internal pure returns (address[] memory) {
        address[] memory arr = new address[](1);
        arr[0] = _a;
        return arr;
    }

    function toArray(address _a, address _b) internal pure returns (address[] memory) {
        address[] memory arr = new address[](2);
        arr[0] = _a;
        arr[1] = _b;
        return arr;
    }

    function toArray(address _a, address _b, address _c) internal pure returns (address[] memory) {
        address[] memory arr = new address[](3);
        arr[0] = _a;
        arr[1] = _b;
        arr[2] = _c;
        return arr;
    }

    // bytes32
    function toArray(bytes32 _a) internal pure returns (bytes32[] memory) {
        bytes32[] memory arr = new bytes32[](1);
        arr[0] = _a;
        return arr;
    }

    function toArray(bytes32 _a, bytes32 _b) internal pure returns (bytes32[] memory) {
        bytes32[] memory arr = new bytes32[](2);
        arr[0] = _a;
        arr[1] = _b;
        return arr;
    }

    function toArray(bytes32 _a, bytes32 _b, bytes32 _c) internal pure returns (bytes32[] memory) {
        bytes32[] memory arr = new bytes32[](3);
        arr[0] = _a;
        arr[1] = _b;
        arr[2] = _c;
        return arr;
    }
}
