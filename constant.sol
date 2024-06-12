// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
contract constantFun{
    // solidity中的两个关键字：constant(常量)、immutable(不变量)；声明之后不允许修改，节省gas;让不应该变的变量保持不变。这样的做法能在节省gas的同时提升合约的安全性。
    // 只有数值变量可以声明constant和immutable;string和bytes可以声明constant，但不能声明：innutable;
    //constant声明的常量必须在初始化的时候就赋值，
    uint256 constant CONSTANT_NUM = 20; // 修改常量时会报错： Cannot assign to a constant variable.
    string constant CONSTANT_STRING = "test";
    bytes constant CONSTANT_BYTES = "WTF";
    address constant CONSTANT_ADDRESS = 0x0000000000000000000000000000000000000000;

    // immutable声明的常量可以在声明时或者构造函数中初始化，相对来说灵活性更好
    uint256 public immutable IMMUTABLE_NUM = 21; // 修改时报错： Immutable state variable already initialized.
    address public immutable IMMUTABLE_ADDRESS;
    uint256 public immutable IMMUTABLE_BLOCK;
    uint256 public immutable IMMUTABLE_TEST;

    // 使用test函数给immutable常量初始化
    constructor() {
        IMMUTABLE_ADDRESS = address(this);
        IMMUTABLE_BLOCK = block.number;
        IMMUTABLE_TEST = test();
    }
    function test() public pure returns (uint256) {
        uint256 what = 9;
        return(what);
    }
}