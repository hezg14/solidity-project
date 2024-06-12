// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract OtherContract {
    // call：是address类型的低级成员，与其他合约交互，返回值是(bool,data)，分别对应call是否成功以及目标函数的返回值
    // 官方推荐的通过触发fallback或者receive函数发生ETH的方法；
    // 不推荐用call来调用另一个合约(当调用不安全的合约函数时，会把主动权给到它)，推荐什么合约变量后调用函数
    // 不知道对方合约的源代码或者ABI，没法生成合约变量，但是仍然可以通过call调用对方合约的函数；
    // 使用方法：目标合约地址.call(二进制编码)，示例如下：
    // abi.encodeWithSignature("函数签名", 具体参数，参数之间逗号分割);
    // abi.encodeWithSignature("f(uint256,address)", _x, _addr)

    uint256 private _x = 0;
    // 收到eth的事件，记录amount和gas,
    event Log(uint amount, uint gas);
    fallback() external payable { }
    receive() external payable { }

    // 返回合约的ETH余额
    function getBalance() view public returns(uint) {
        return address(this).balance;
    }

    // 往合约内转入ETH
    function setX(uint256 x) external payable {
        _x = x;
        // 转入ETH，释放Log事件
        if (msg.value > 0) {
            emit Log(msg.value, gasleft());
        }
    }

    // 读取x
    function getX() external view returns (uint x) {
        x = _x;
    }
}

contract Call{
    // 定义Response事件，输出call返回的结果success和data
    event Response(bool success, bytes data);

    // 调用目标合约中的setX()函数，转入一定数额的ETH 
    function callSetX(address payable _addr, uint256 x) public payable {
        // call setX()，同时可以发送ETH
        (bool success, bytes memory data) = _addr.call{value: msg.value}(
            abi.encodeWithSignature("setX(uint256)", x)
        );
        // 输出success和data
        emit Response(success, data); //释放事件
    }

    // 返回目标合约的_x的值
    function callGetX(address _addr) external returns(uint256){
        // call getX()
        (bool success, bytes memory data) = _addr.call(
            abi.encodeWithSignature("getX()")
        );

        emit Response(success, data); //释放事件
        return abi.decode(data, (uint256));
    }

    // call了不存在的foo函数。call仍能执行成功，并返回success，但其实调用的目标合约fallback函数。
    function callNonExist(address _addr) external{
        // call 不存在的函数
        (bool success, bytes memory data) = _addr.call(
            abi.encodeWithSignature("foo(uint256)")
        );

        emit Response(success, data); //释放事件
    }
}