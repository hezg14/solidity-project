// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
contract hashFun {
    // 好的hash函数的几个特性：
    // 1、单向性：从输入的消息到哈希的正向运算简单且唯一，逆向只能暴力枚举
    // 2、灵敏性：输入的消息改变一点对它的哈希改变很大
    // 3、高效性：输入的消息到哈希的运算高效
    // 4、均一性：每个哈希值被取到的概率基本相当
    // 5、抗碰撞性：弱碰撞：给定一个消息x，找另一个消息x使得hash(x) = hash(x')困难；强抗碰撞性：找到任意x和x',使得hash(x) = hash(x')困难


    // hash的应用：生成数据唯一标识，加密签名，安全加密
    // 常用的hash函数：Keccak256,用法如下：hashValue = Keccak256(data);


    // sha3和Keccak256，两者计算结果不同，
    // 因为NIST调整了填充算法，在以太坊开发的时候sha3还在标准化，所以Ethereum和Solidity智能合约中的SHA3是指Keccak256,而不是标准的NIST-SHA3,
    // 为了避免混淆，所以直接在合约代码中写成Keccak256是最清晰的。

    bytes32 _msg = keccak256(abi.encodePacked("0xAA"));

    // 生成数据的唯一标识
    function hash(uint _num, string memory _string, address _addr) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_num, _string, _addr));
    }

    // 弱对抗性
    // 弱抗碰撞性
    function weak(string memory string1)public view returns (bool){
        return keccak256(abi.encodePacked(string1)) == _msg;
    }
     
    // 强抗碰撞性
    function strong(string memory string1, string memory string2)public pure returns (bool){
        return keccak256(abi.encodePacked(string1)) == keccak256(abi.encodePacked(string2));
    }
}