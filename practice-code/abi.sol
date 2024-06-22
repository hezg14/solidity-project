// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract abiEncode {
    uint x = 10;
    address addr = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
    string name = "test";
    uint[2] array = [5,6];
    // ABI编码规则，利用ABI对采纳数进行编码，作用和智能合约做交互，将每个参数填充为32字节的数据，并拼接在一起，
    // abi.encode：如果与合约交互，就需要使用
    function encode() public view returns (bytes memory result) {
        result = abi.encode(x, addr, name, array); // 由于abi.encode()会将数据填充为32字节，所以中间会有很多0
    }
    // abi.encodePacked：将给定参数根据其所需的最低空间编码，类似于abi.encode,但是会把其中很多的0忽略，算一些数据的hash,由于abi.encodePacked对编码进行了压缩，长度比abi.encode短很多。
    function encodePacked() public view returns (bytes memory result) {
        result = abi.encodePacked(x, addr, name, array);
    }
    // abi.encodewithSignature与abi.encode类似，只不过需要第一个参数为函数签名，示例如下：
    function encodeWithSignature() public view returns (bytes memory result) {
        // 在abi.encode编码结果前加上了4字节的函数选择器
        result = abi.encodeWithSignature("foo(uint256, address, string, uint256[2", x, addr, name, array);
    }
    // abi.encodeWithSignature功能类似，只不过第一个参数为函数选择器，为函数签名Keccak哈希的前4个字节。
    function encodeWithSelector() public view returns (bytes memory result) {
        result = abi.encodeWithSelector(bytes4(keccak256("foo(uint256, address, string, uint256[2")), x, addr, name, array);
    }

    // abi.decode 用来解码abi.encode生成的二进制编码，将它还原为原本的参数
    function decode(bytes memory data) public pure returns(uint dx, address daddr, string memory dname, uint[2] memory darray) {
        (dx, daddr, dname, darray) = abi.decode(data, (uint, address, string, uint[2]));
    }

    // ABI的使用场景：1、配合call来实现对合约的底层调用，2、ethers.js中常用ABI实现合约的导入和函数调用、3、对不开源合约进行反编译后，某些函数无法查到函数签名，可通过ABI进行调用
    // 在以太坊中数据必须编码成字节码才能和智能合约交互；
    // bytes4 selector = contract.getValue.selector;
    // bytes memory data = abi.encodeWithSelector(selector, _x);
    // (bool success, bytes memory returnedData) = address(contract).staticcall(data);
    // require(success);

    // return abi.decode(returnedData, (uint256));
}