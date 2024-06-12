// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

// 发送ETH相关
contract  senderETH {
    // 三种发送ETH的方法：
    // call没有gas限制，最为灵活，是最提倡的方法；
    // transfer有2300的gas限制，但是发送失败会自动revert交易，是次优选择；
    // send有2300的gas限制，而且发送失败不会自动revert交易，几乎没有人用它。
    // 向testReceiveETH合约发送ETH
    // 构造函数：payable再部署的时候转eth过去
    constructor() payable {}
    // receive，接收eth时触发
    receive() external payable { }

    error SendFailed(); // 用send发送ETH失败error
    error CallFailed(); // 用call发送ETH失败error

    // 1、transfer：接收方底子.transfer(转过去的ETH数额)，transfer的gas限制是2300，足够用于转账，但是对方合约的fallback和receive函数不能实现太复杂的逻辑，transfer如果转账失败，会自动revert交易
    function transferETH(address payable _to, uint256 amount) external payable {
        // _to表示ReceiveETH合约的地址，amount表示ETH转账的金额
        _to.transfer(amount);
    }

    // 2、send：接收方地址.send(发送ETH数额)
    // send()的gas限制是2300，够用于转账，但是fallback和receive函数不能实现太复杂的逻辑，转账失败不会revert，返回值是bool，代表转账成功或失败，需要额外代码处理下

    // send发送ETH：
    function sendETH(address payable _to, uint256 amount) external payable{
        // 处理下send的返回值，如果失败，revert交易并发送error
        bool success = _to.send(amount);
        if(!success){
            revert SendFailed();
        }
    }

    // 3、call发送ETH：用法是接收方地址.call{value: 发送ETH数额}("")。
    // 没有gas限制，可以支持fallback或receive函数的实现复杂的逻辑，如果转账失败，不会revert，返回值是(bool,data),bool表示转账成功或者失败，
    // call()发送ETH
    function callETH(address payable _to, uint256 amount) external payable{
        // 处理下call的返回值，如果失败，revert交易并发送error
        (bool success,) = _to.call{value: amount}("");
        if(!success){
            revert CallFailed();
        }
    }

}

contract testReceiveETH {
    // 收到eth事件，记录amount和gas
    event Log(uint amount, uint gas);
    // receive方法，接收eth时被触发
    receive() external payable{
        emit Log(msg.value, gasleft());
    }
    // 返回合约ETH余额
    function getBalance() view public returns(uint) {
        return address(this).balance;
    }
}



// 接收ETH相关
contract receiveETH {
    // solidity 支持两种特殊的回调函数，recevie()和fallback(),在两种情况下被使用：
    // 1、接收ETH
    // 2、处理合约中不存在的函数调用(代理合约proxy contract)
    // 在solidity 0.6.x的版本之前，语法上只有fallback()函数，用来接收用户发送的ETH时调用，以及被调用函数签名没有匹配到时，来调用，
    // 在0.6版本之后，才将fallback()拆分为receive()和fallback()两个函数

    // 接收ETH的函数receive()只处理接收ETH，一个合约最多只有一个receive函数，
    // receive声明和一般函数不一样，不需要function关键字，且不能有任何参数，不能有返回值，必须包含external、payable
    // 示例如下：
    
    // 定义事件
    event Recevied(address Sender, uint Value);
    // 接收ETH时释放的Received事件
    receive() external payable {
        emit Recevied(msg.sender, msg.value);
    }

    // 回退函数：fallback，调用合约中不存在的函数时触发，可用于接收ETH,也可用于代理合约proxy contract，
    // fallback声明时不需要function关键字，必须有external修饰，一般也会用payable修饰，用于接收ETH: fallback() external payable {};
    // 声明一个事件
    event fallbackCalled(address sender, uint value, bytes data);
    fallback() external payable {
        emit fallbackCalled(msg.sender, msg.value, msg.data);
    }

    // receive和fallback的区别
    // 两者都能接受ETH，触发规则存在差异：
    // 接收ETH,msg.data为空且receive()存在，走receive(),如果不存在则走fallback()
    // 接收ETH,msg.data不为空，走fallback();
    // receive()和payable fallback()均不存在的时候，向合约直接发送ETH将会报错（你仍可以通过带有payable的函数向合约发送ETH）。
}

