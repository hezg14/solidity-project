// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract overLoading {
    // 同名函数在经过编译器编译之后，由于存在不同的参数类型，所以会变成不同的函数选择器(selector)，返回不同的结果，被区分为不同的函数
    function saySomething() public pure returns (string memory) {
        return ("Nothing");
    }

    function saySomething(string memory something)
        public
        pure
        returns (string memory)
    {
        return (something);
    }

    // 实参匹配：调用重载函数时，会把输入的实际参数和函数参数的变量类型做匹配。 如果出现多个匹配的重载函数，则会报错：示例如下：
    function f(uint8 _in) public pure returns (uint8 out) {
        out = _in;
    }

    function f(uint256 _in) public pure returns (uint256 out) {
        out = _in;
    }
    // 调用f(50)，因为50既可以被转换为uint8，也可以被转换为uint256，因此会报错。
}
