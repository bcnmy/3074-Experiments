// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import { IEntryPoint } from "@account-abstraction/contracts/interfaces/IEntrypoint.sol";
import { IAccount, PackedUserOperation } from "@account-abstraction/contracts/interfaces/IAccount.sol";
import { IAccountExecute } from "@account-abstraction/contracts/interfaces/IAccountExecute.sol";
import { Auth } from "./utils/AUTH.sol";
import "forge-std/src/console2.sol";
import "./utils/ECDSA.sol";

// based on https://github.com/leekt/3074-invokers/blob/main/src/EIP3074Account.sol

contract ERC4337Invoker is IAccount, IAccountExecute, Auth {
    IEntryPoint public immutable ep;

    constructor(IEntryPoint _ep) {
        ep = _ep;
    }

    function validateUserOp(
        PackedUserOperation calldata userOp,
        bytes32 userOpHash,
        uint256 missingAccountFunds
    )
        external
        returns (uint256)
    {
        require(msg.sender == address(ep), "!ep");
        address caller = address(bytes20(bytes32(userOp.nonce)));
        address signer = getAuthSigner(userOp, userOpHash);

        return caller == signer ? 0 : 1; // return true when caller == signer
    }

    function getAuthSigner(
        PackedUserOperation calldata userOp,
        bytes32 userOpHash
    )
        public
        view
        returns (address signer)
    {
        uint256 nonce = uint256(bytes32(userOp.signature[0:32]));
        bytes32 digest = getDigest(userOpHash, nonce);
        signer = ecrecover(
            digest,
            uint8(bytes1(userOp.signature[96])),
            bytes32(userOp.signature[32:64]),
            bytes32(userOp.signature[64:96])
        );
    }

    function executeUserOp(PackedUserOperation calldata userOp, bytes32 userOpHash) external {
        require(msg.sender == address(ep), "!ep");
        address caller = address(bytes20(bytes32(userOp.nonce)));
        Signature memory sig = _rawAuthToAuthSignature(caller, userOp.signature[32:]);

        auth(userOpHash, sig);

        (address to, uint256 value, bytes memory data) = abi.decode(userOp.callData[4:], (address, uint256, bytes));
        authcall(to, data, value, gasleft());
    }

    // TODO: Implement a permissioning system to allow only certain contracts to call this function under certain
    // conditions
    function transfer(address from, address to, uint256 value, bytes calldata authRawSig, bytes32 commit) external {
        Signature memory sig = _rawAuthToAuthSignature(from, authRawSig);
        auth(commit, sig);
        (bool success,) = authcall(to, bytes(""), value, gasleft());
        require(success, "authcall failed");
    }

    function _rawAuthToAuthSignature(
        address caller,
        bytes calldata auth
    )
        internal
        pure
        returns (Signature memory sig)
    {
        sig = Signature({
            signer: caller,
            yParity: vToYParity(uint8(bytes1(auth[64]))),
            r: bytes32(auth[0:32]),
            s: bytes32(auth[32:64])
        });
    }
}
