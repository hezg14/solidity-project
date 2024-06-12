// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
contract initVariable{
    // 变量初始值
    // bool：false、string: ""、int：0、uint：0、enum：枚举中的第一个元素、address：0x0000000000000000000000000000000000000000 (或 address(0))、function：internal\external(空白方程)
    bool public _bool; // false
    string public _string; // ""
    int public _int; // 0
    uint public _uint; // 0
    address public _address; // 0x0000000000000000000000000000000000000000

    enum ActionSet { Buy, Hold, Sell}
    ActionSet public _enum; // 第1个内容Buy的索引0

    function fi() internal{} // internal空白方程 
    function fe() external{} // external空白方程 

    // 引用类型的初始值：
    // 数组array：动态数组：[]，静态数组(定长)：所有成员设为其默认值的静态数组
    // 结构体struct：所有成员设为其默认值的结构体
    // 映射mapping：所有的元素都是其默认值的mapping
    // Reference Types
    uint[8] public _staticArray; // 所有成员设为其默认值的静态数组[0,0,0,0,0,0,0,0]
    uint[] public _dynamicArray; // `[]`
    mapping(uint => address) public _mapping; // 所有元素都为其默认值的mapping
    // 所有成员设为其默认值的结构体 0, 0
    struct Student{
        uint256 id;
        uint256 score; 
    }
    Student public student;

    // delete操作符
    bool public _bool2 = true;
    function d() external {
        delete _bool2; // delete让_bool2变为默认值false；
    }
}