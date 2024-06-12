// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
contract variableType{
    // bool
    bool public _bool = true;
    bool public _bool1 = !_bool; // 非
    bool public _bool2 = _bool && _bool1; // 与
    bool public _bool3 = _bool || _bool1; // 或
    bool public _bool4 = _bool == _bool1; // 相等
    bool public _bool5 = _bool != _bool1; // 不等

    // int：整型
    int public _int = -1; // 整数，包括负数
    int public _uint = 1; // 正整数
    uint256 public _number  = 20240601; // 256位正整数
    // 运算符：+、-、*、/、**(指数)、%(取余)、

    // 地址类型：address：存储20字节的值(以太坊地址的大小)
    address public _address = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
    address payable public _address1 = payable(_address); // payable address，可以转账、查余额；
    // 地址类型的成员
    uint256 public balance = _address1.balance; // balance of address


    // 定长字节数组：bytes：分两种类型：定长(byte、bytes8、bytes32)，定长的bytes可以存一些数据，消耗gas比较少; 不定长：引用类型
    bytes32 public _byte32 = "MiniSolidity"; // 以字节的方式存储到变量_byte32中，转为16进制：0x4d696e69536f6c69646974790000000000000000000000000000000000000000
    bytes1 public _byte = _byte32[0]; // 存储_byte32的第一个字节：为0x4d；

    // 枚举类型：enum(冷门的变量，几乎没人使用)，属于solidity中用户定义的数据类型；主要用于为uint分配名称，让程序更易读，
    enum ActionSet {Buy, Hold, Sell } // 用enum将uint 0,1,2表示为Buy、Hold、Sell
    // ActionSet action = ActionSet.Buy; // 创建enum变量action，赋予其ActionSet的第一个元素,返回：uint256: 0
    ActionSet action = ActionSet.Sell; // 创建enum变量action，赋予其ActionSet的第三个元素,返回：uint256: 2

    // 可以显示的和uint互转，并且会检查转换的正整数是否存在枚举的长度内，不然会报错
    function enumToUint() external view returns(uint) {
        return uint(action); // 进行显示的转换，把enum转为了uint
    }
}