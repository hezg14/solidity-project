// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract createFun {
    // 创建新合约的两种办法：
    // 1、new一个新的合约，并传入新合约构造函数所需的参数，示例如下：
    // Contract x = new Contract{value: _value} (params);
    // 其中Contract是要创建的合约名，x是合约对象（地址），如果构造函数是payable，可以创建时转入_value数量的ETH，params是新合约构造函数的参数
}

// Pair合约包含三个状态变量：factory、token0、token1
contract Pair {
    address public factory; // 工厂合约地址
    address public token0; // 代币1
    address public token1; // 代币2

    constructor() payable {
        factory = msg.sender;
    }

    // called once by the factory at time of deployment
    function initialize(address _token0, address _token1) external {
        require(msg.sender == factory, "UniswapV2: FORBIDDEN");
        token0 = _token0;
        token1 = _token1;
    }
}

// 工厂合约，有两个状态变量getPair是两个代币地址到币对地址的map，方便根据代币地址找到币对地址，allPairs是币对地址的数组，存储所有的代币地址
// PairFactory合约只有一个createPair函数，根据输入的代币地址tokenA和tokenB来创建新的Pair合约
contract PairFactory{
    mapping(address => mapping(address => address)) public getPair; // 通过两个代币地址查Pair地址
    address[] public allPairs; // 保存所有Pair地址

    function createPair(address tokenA, address tokenB) external returns (address pairAddr) {
        // 创建新合约
        Pair pair = new Pair(); 
        // 调用新合约的initialize方法
        pair.initialize(tokenA, tokenB);
        // 更新地址map
        pairAddr = address(pair);
        allPairs.push(pairAddr);
        getPair[tokenA][tokenB] = pairAddr;
        getPair[tokenB][tokenA] = pairAddr;
    }

    // Pair pair = new Pair();
}


//由于用create1创建的合约地址会变，因为创建地址不会变，但是nonce会随时间而改变，所以用CREATE创建的合约地址不好预测
// CREATE2的目的是为了让合约地址独立于未来的事件，无论发生什么变化，都可以把合约部署到事先计算好的地址上；
// CREATE2由4部分组成：新地址 = hash("0xFF",创建者地址, salt, bytecode)，创建者使用 CREATE2 和提供的 salt 部署给定的合约bytecode，它将存储在 新地址 中。
// 用法：Contract x = new Contract{salt: _salt, value: _value}(params)

contract Pair2 {
    address public factory; // 工厂合约地址
    address public token0; // 代币1
    address public token1; // 代币2

    constructor() payable {
        // 将factory赋值为工厂地址
        factory = msg.sender;
    }
    // 在Pair2合约被创建时被工厂合约调用一次，将token0、token1更新为币对中两种代币的地址；
    function initialize(address _token0, address _token1) external {
        require(msg.sender == factory, 'UniswapV2: FORBIDDEN');
        token0 = _token0;
        token1 = _token1;
    }
}

// 使用场景：交易所为新用户预留创建钱包合约地址，Router中可以通过tokenA,tokenB计算出pair2的地址，不需要再执行一次Factory.getPair(tokenA, tokenB)的跨合约调用；