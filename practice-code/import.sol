// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

// 导入库函数
// 1、通过网址引用
// import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol';

// 2、通过npm导入
import "@openzeppelin/contracts/utils/Address.sol";

// 3、导入特定的合约
import { grandFather } from "./inheritance.sol";

// 使用导入的函数
contract testImportFun {
    // 导入成Address库
    using Address for address;
    // 声明
    grandFather testGrandFather = new grandFather();
    function test() external {
        testGrandFather.push();
    }
}