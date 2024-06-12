// SPDX-License-Identifier: MIT

// public: 内部外部均可见。
// private: 只能从本合约内部访问，继承的合约也不能用。
// external: 只能从合约外部访问（但是可以用this.f()来调用，f是函数名）。
// internal: 只能从合约内部访问，继承的合约可以用。
// 决定函数权限/功能的关键字:pure(无法读写)|view(可读不可写)|payable，不写任何值时，可读可写
pragma solidity ^0.8.4;
contract FunctionTypes{
    // public：内部外部均可访问
    uint256 public number = 5;
    // pure：无法读取和修改合约内的状态变量
    function addPure(uint256 _number) external pure returns(uint256 new_number){
        new_number = _number + 1; // 返回的是一个新的变量
    }
    // view：可以查看合约内的状态变量
    function addView() external view returns(uint256 new_number){
        new_number = number + 1; // 返回一个新的变量，没法直接改变number的值
    }
    // internal：只能从合约内部访问，继承的合约可以用
    function minus() internal {
        number = number - 1;
    }
    // 只能从合约外部访问
    function minusCall() external {
        minus();
    }
    // payable：递钱，能给合约支付eth的函数,
    function minusPayable() external payable returns(uint256 balance) {
        // 作用：间接的调用minus(),并且返回合约里的ETJ余额(this关键字可以让我们引用合约地址)，可以在调用minusPayable()函数时，往合约里转入1个ETH;
        minus();
        balance = address(this).balance;
    }

}

