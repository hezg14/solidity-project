// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
// 导入库函数
import "@openzeppelin/contracts/utils/Strings.sol";
contract libraryFun {
    // 库函数是一种特殊的合约，提升了solidity代码的复用性和减少gas，库函数一般都是一些好用的函数的合集；
    // 库函数与普通函合约存在以下不同点：
    // 1、不能存在状态变量、2、不能继承和被继承、3、不能接受以太币、4、不可以被销毁

    // string库是将uint256类型转为相应的string类型的代码库,主要包含两个函数，toString()将uint256转为string，toHexString()将uint256转换为16进制，再转换为string

    // 如何使用库函数
    // 1、利用using for指令，示例如下：
    using Strings for uint256;
    function getString1(uint256 _number) public pure returns(string memory){
        // 库函数会自动添加为uint256型变量的成员
        return _number.toString(); // 转为字符串输出
    }

    // 2、直接通过库合约名称调用库函数
    function getString2(uint256 _number) public pure returns (string memory) {
        return Strings.toHexString(_number); // 转为16进制的字符串输出
    }
    // 常用的库合约：1、String,将uint256转为String，2、Address:判断某个地址是否为合约地址、3、Create2：更安全的使用Create2 EVM opcode、4、Arrays：与数组有关的库函数
}

