// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
contract constructorFun{
    address owner; // 定义变量
    // 构造函数
    constructor() {
        owner = msg.sender; // 部署合约时，将owner设置为部署者的地址
    }
    // 构造函数在不同的solidity版本中的语法并不一致，在Solidity 0.4.22之前，构造函数不使用 constructor 而是使用与合约名同名的函数作为构造函数而使用，
    // 由于这种旧写法容易使开发者在书写时发生疏漏（例如合约名叫 Parents，构造函数名写成 parents），使得构造函数变成普通函数，引发漏洞，所以0.4.22版本及之后，采用了全新的 constructor 写法。
    // 旧的写法示例：
    // pragma solidity =0.4.21;
    // contract Parents {
    //     // 与合约名Parents同名的函数就是构造函数
    //     function Parents () public {
    //     }
    // }

    // 修饰器：modifier：是solidity的特有语法，类似于面向对象中的decorator,声明函数拥有的特性，减少代码冗余，
    // modifier的主要使用场景是运行函数前的检查，例如地址，变量，余额等
    // 控制合约的权限，
    modifier onlyOwner {
        require(msg.sender == owner); // 调用这是否为owner地址
        _; // 如果是继续运行函数主体，如果不是报错并revert交易；
    }
    // 可以改变合约的主人,但是由于有onlyOwner修饰符，所以只有原先的owner可以调用，其余人调用会报错，这是最常见的控制智能合约权限的方法；
    function changeOwner(address _newOwner) external onlyOwner{
        owner = _newOwner;
    }
}