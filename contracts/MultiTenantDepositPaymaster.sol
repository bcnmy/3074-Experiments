// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import { Auth } from "./utils/Auth.sol";
import "./utils/ECDSA.sol";
import { IPaymaster } from "@account-abstraction/contracts/interfaces/IPaymaster.sol";
import { IEntryPoint, PackedUserOperation } from "@account-abstraction/contracts/interfaces/IEntryPoint.sol";
import { ERC4337Invoker } from "./ERC4337Invoker.sol";

// Warning: This contract is for testing purposes only. It is not secure and should not be used in production.

contract MultiTenantDepositPaymaster is IPaymaster, Auth {
    IEntryPoint public immutable ep;
    uint256 public constant POST_OP_GAS = 1_000_000;

    event Deposit(address indexed account, uint256 amount);

    mapping(address => uint256) public deposit;

    constructor(IEntryPoint _ep) {
        ep = _ep;
    }

    function depositTo(address account) external payable {
        deposit[account] += msg.value;
    }

    function validatePaymasterUserOp(
        PackedUserOperation calldata userOp,
        bytes32 userOpHash,
        uint256 maxCost
    )
        external
        returns (bytes memory context, uint256 validationData)
    {
        address caller = ERC4337Invoker(userOp.sender).getAuthSigner(userOp, userOpHash);
        if (deposit[caller] < maxCost) {
            return (bytes(""), 1);
        }
        deposit[caller] -= maxCost;

        return (abi.encode(caller, userOpHash, maxCost, userOp.sender, userOp.signature[32:]), 0);
    }

    function postOp(
        PostOpMode mode,
        bytes calldata context,
        uint256 actualGasCost,
        uint256 actualUserOpFeePerGas
    )
        external
    {
        uint256 postOpGas = POST_OP_GAS * actualUserOpFeePerGas;
        actualGasCost += postOpGas;

        (address caller, bytes32 userOpHash, uint256 maxCost, ERC4337Invoker invoker, bytes memory rawAuthSignature) =
            abi.decode(context, (address, bytes32, uint256, ERC4337Invoker, bytes));

        uint256 unusedDeposit = maxCost - actualGasCost;

        uint256 callerBalanceLeft = address(caller).balance;
        uint256 fundsToRecover = actualGasCost <= callerBalanceLeft ? actualGasCost : callerBalanceLeft;
        if (fundsToRecover > 0) {
            invoker.transfer(caller, address(this), fundsToRecover, rawAuthSignature, userOpHash);
            deposit[caller] += unusedDeposit + fundsToRecover;
        } else {
            deposit[caller] += unusedDeposit;
        }
    }

    fallback() external payable {
        emit Deposit(msg.sender, msg.value);
    }
}
