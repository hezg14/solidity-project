// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
contract mappingFun{
    // solidity的哈希表，映射类型(mapping),在映射中，可以通过key来查询对应的value，如可以通过id查询真人的信息
    // 映射的格式如下：mapping(_keyType => _valueType),示例：
    mapping(uint => address) public idToAddress; // id映射到地址
    mapping(address => address) public swapPair; // 币对应的映射，地址到地址

    // 映射的规则1：映射的key只能选择solidity默认的类型，如：uint、address等，不能用自定义的结构体，value可以使用自定义类型，错误的例子如下：
    struct Student{
        uint256 id;
        uint256 score;
    }
    // Only elementary types, user defined value types, contract types or enums are allowed as mapping keys.
    // mapping(Student => uint) public testValue;
    // 映射的规则2：映射的存储位置必须是storage，因此可以用于合约的状态变量，函数中的storage变量，和library函数的参数，不能用于public函数的参数或返回结果中，因为mapping记录的是一种关系
    // 映射的规则3：如果映射声明public，那么solidity会自动创建一个getter函数，可以通过key来查询对应的value；
    // 映射的规则4：给映射新增的键值对的语法为_Var[_Key] = _Value;其中_Var是映射变量名，_Key和_Value对应新增的键值对，如下：
    function writeMap(uint _Key, address _Value) public {
        idToAddress[_Key] = _Value;
    }

    // 映射的原理：
    // 1、映射不存储任何键的信息， 也没有length的信息；
    // 2、映射使用keccak256(key)当成offset存取value、
    // 3、因为Etherum会定义所有未使用的空间为0，所以未赋值的value和key初始值都是各自类型的默认值，如uint的默认值是0;
}