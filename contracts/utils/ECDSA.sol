// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

// @credit: https://github.com/leekt/3074-invokers/blob/main/src/utils.sol

function vToYParity(uint8 v) pure returns (uint8 yParity_) {
    assembly {
        switch lt(v, 35)
        case true { yParity_ := eq(v, 28) }
        default { yParity_ := mod(sub(v, 35), 2) }
    }
}
