// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
contract delegatecallFun {
    // delegatecall与call类似，是solidity中地址类型的低级成员函数，表示委托的意思
    // 用户A通过合约B来delegatecall调用合约C，执行的合约C的函数，语境仍然是合约B，msg.sender是A的地址，函数状态改变的变量会作用于合约B的变量上
    // 我买了一笔基金，交给基金经理交易(执行他的函数)，但是最终我的钱发生了变化；
    // 语法：目标合约地址.delegatecall(二进制编码); 
    // abi.encodeWithSignature("函数签名", 逗号分隔的具体参数)、abi.encodeWithSignature("f(uint256,address)", _x, _addr)
    // 和call不一样，delegatecall在调用合约时可以指定交易发送的gas，但不能指定发送的ETH数额
    // 注意：delegatecall有安全隐患，使用时要保证当前合约和目标合约的状态变量存储结构相同，并且目标合约安全，不然会造成资产损失。

    // 使用到delegate的场景如下：
    // 1、代理合约：将智能合约的存储合约和逻辑合约分开，代理合约存储所有的相关的变量，保存逻辑合约的地址，所有合约存在逻辑合约里，通过delegate执行，升级时将代理合约指向新的合约逻辑；
    // 2、钻石，支持构建可以坐在生产中扩展的模块化智能合约系统的标准，具有多个实施合同的代理合同；

    // delegate例子：调用结构，通过A通过合约B调用目标合约C
}



contract bFun {
    uint public num;
    address public sender;
    
    // 通过call来调用 C中的setVars()函数，将改变合约C里的状态变量
    function callSetVars(address _addr, uint _num) external payable {
        // call setVars
       (bool success, bytes memory data) = _addr.call(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );
    }

    // 通过delegate来调用C中的setVars()函数
    function delegateCallSetVars(address _addr, uint _num) external payable {
        // delegatecall setVar()
        (bool success, bytes memory data) = _addr.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );
    }
}

contract cFun {
    uint public num;
    address public sender;
    
    function setVars(uint _num) public payable {
        num = _num;
        sender = msg.sender;
    }
}

