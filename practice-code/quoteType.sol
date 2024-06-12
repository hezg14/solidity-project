// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
contract quoteType{
    // solidity中的引用类型：array、struct
    // 固定长度的数组
    uint[8] array1;
    bytes1[5] array2;
    address[100] array3;
    // 可变长度的array,声明时不指定长度
    uint[] array4;
    bytes1[] array5;
    address[] array6;
    bytes array7;
    // bytes比较特殊，是数组，但是不用加[]。另外，不能用byte[]声明单字节数组，可以使用bytes或bytes1[]，在gas上，bytes比bytes1[]便宜。
    // 因为bytes1[]在memory中要增加31个字节进行填充，会产生额外的gas。但是在storage中，由于内存紧密打包，不存在字节填充。

    // 在solidity中创建数组的规则：对于memory修饰的动态数组，可以使用new 操作符来创建，必须声明长度，并且声明后长度不能变，示例如下
    function f() public pure {
        // uint[] memory array8 = new uint[5];
        // bytes memory array9 = new bytes(9);
        g([uint(1), 2, 3]);
    }
    function g(uint[3] memory) public pure {
        // 创建的动态数组需要一个元素一个元素的赋值，示例如下：
        uint[] memory x = new uint[](2);
        x[0] = 1;
        x[1] = 2;
    }

    // 数组成员：length,memory数组的长度在创建后是固定的，push，数组后面添加一个元素，pop移除数组的最后一个元素
    function arrayHandle() public returns (uint[] memory) {
        uint[2] memory a = [uint(1), 2];
        array4 = a; // array4是可变数组，在上面已经声明
        array4.push(3);
        return array4;
    }


    // 结构体：struct,solidity支持通过构造结构体的形式定义新的类型，创建结构体的方法：
    struct Student{
        uint256 id;
        uint256 score;
    }
    Student student; // 初始一个student结构体

    // 给结构体赋值的方法：方法一
    function initStudent1() external {
        Student storage _student = student; // 分配
        _student.id = 1;
        _student.score = 100;
    }

    // 结构体赋值方法二：直接引用状态变量的struct
    function initStudent2() external {
        student.id = 2;
        student.score = 90;
    }
}