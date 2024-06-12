// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
contract storeScopeData{
    // solidity中的数据存储位置分为三类：storage、memory、calldata,不同的位置存储的gas成本不同，
    // storage, memory和calldata三个关键字的出现的原因是为了节省链上有限的存储空间和降低gas；
    // storage类型的数据存在链上，类似计算机的硬盘，消耗的gas多，
    // memory和calldata类型的临时存在内存里，消耗gas少，
    // storage：合约里的状态变量默认都是storage，存储在链上;
    // memory：函数的参数和临时变量一般存在memory中，存储在内存中，不上链；
    // calldata：存储和memory类似，存储在内存中不上链，与memory不同点在于calldata变量不能修改，一般用于函数的参数；示例如下
    function fCallData(uint[] calldata _x) public pure returns(uint[] calldata) {
        // 参数为calldata的数组，不能被修改
        // _x[0] = 1; // 这样修改会报错:Calldata arrays are read-only
        return(_x);
    }

    // 数据位置和赋值规则
    uint[] x = [1,2,3]; // 数组变量(属于状态变量)
    function fStorage() public {
        // 声明一个storage的变量xStorage,指向x,修改xStorage也会影响x;
        uint[] storage xStorage = x; // 变量赋值给storage，会创建独立的副本，修改其中一个不会影响另一个。
        xStorage[0] = 100;
    }

    // storage赋值给memory，也会创建独立的副本，修改其中一个不会影响另一个，反之亦然
    function fMemory() public view {
        // 声明一个memoory的变量xMemory，复制x,修改xMemory不会影响x
        uint[] memory xMemory = x;
        xMemory[0] = 100;
        xMemory[1] = 200;
        uint[] memory xMemory2 = x; // memory赋值给memory，会创建引用，改变新变量会影响原变量。
        xMemory2[0] = 300;
    }

    // 变量的作用域分为三种：状态变量(state variable)、局部变量(local variable)、全局变量(global variable)
    // 状态变量：数据存储在链上的变量，所有合约内函数都可以访问 ，gas消耗高。状态变量在合约内、函数外声明，可以在函数内修改状态变量的值(类似于js中的全局变量)
    // 局部变量：仅在函数执行过程中有效的变量，函数退出后，变量无效，局部变量存储在内存中，不上链，gas低，示例：
    function bar() external pure returns(uint) {
        uint xx = 1;
        uint yy = 3;
        uint zz = xx + yy;
        return(zz);
    }

    // 全局变量：全局工作范围内的变量，都是solidity预留的关键字，可以在函数中不声明直接使用，示例如下:
    function global() external view returns(address, uint, bytes memory) {
        address sender = msg.sender; // 请求发起地址
        uint blockNum = block.number; // 当前区块高度
        bytes memory data = msg.data; // 请求的数据
        return(sender, blockNum, data);
        // 常用的全局变量
        // blockhash(uint blockNumber): (bytes32);  // 给定区块的哈希值 – 只适用于256最近区块, 不包含当前区块。
        // block.coinbase: (address payable); //当前区块矿工的地址
        // block.gaslimit: (uint); // 当前区块的gaslimit
        // block.number: (uint);  // 当前区块的number
        // block.timestamp: (uint); // 当前区块的时间戳，为unix纪元以来的秒
        // gasleft(): (uint256); // 剩余 gas
        // msg.data: (bytes calldata); // 完整call data
        // msg.sender: (address payable); // 消息发送者 (当前 caller)
        // msg.sig: (bytes4) // calldata的前四个字节 (function identifier)
        // msg.value: (uint);  // 当前交易发送的wei值
    }

}