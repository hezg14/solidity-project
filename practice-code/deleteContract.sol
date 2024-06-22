// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract DeleteContract {
    // selfdestruct 删除智能合约，并将该合约剩余的ETH转到指定地址，为了应对合约出错的极端情况而设计的
    // 用法：selfdestruct(_addr)
    uint public value = 10;
    constructor() payable {}
    receive() external payable {}
    function deleteContract() external {
        // 调用selfdestruct销毁合约，并将剩余的ETH转给msg.sender
        selfdestruct(payable(msg.sender));
    }
    function getBalance() external view  returns (uint balance) {
        balance = address(this).balance;
    }
}