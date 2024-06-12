// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
contract Events {
    // 定义一个_balances的映射变量，记录每个地址的持币数量
    mapping(address => uint256) public _balances;
    // 事件:
    // 响应：可以通过RPC接口订阅和监听事件，并在前端做出响应，
    // 经济：event是比较经济的存储数据的方式，每个大概消耗2000gas,相比之下在链上存储一个新的变量至少要20000gas。
    // 事件关键字：event，以event开头，接着是时间名称，括号内写好事件需要记录的变量类型和变量名,ERC20代币的Transfer事件如下：
    event Transfer(address indexed from, address indexed to, uint256 value);
    // 记录了三个变量，from、to、value,分别表示:转账地址，接收地址，转账数目，其中from、to都带了indexed关键字，会保存在以太坊虚拟机日志的topics中，方便之后检索；

    // 在函数中释放事件：0x5B38Da6a701c568545dcfcB03FcB875f56beddc4、0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2、100
    function _transfer(address from, address to, uint256 amount) external {
        _balances[from] = 10000000; //给转账地址一些初始代币
        _balances[from] -= amount; // 转账地址减去转账的数量
        _balances[to] += amount; // 收账地址加上转来的数量

        // 释放事件
        emit Transfer(from, to, amount);
    }

    // 以太坊虚拟机（EVM）用日志Log来存储Solidity事件，每条日志记录都包含主题topics和数据data两部分。
    // 日志的第一部分：主题(Topics)，用于描述事件，长度不超过4，第一个元素是时间的签名(哈希)，Transfer的签名是：keccak256("Transfer(addrses,address,uint256)");
    // 除去时间签名，主题还包含至多3个indexed参数，也就是from、to,indexed标记的参数可以理解为检索时间的索引"键"，方便后期搜索，
    // 每个indexed参数的大小固定位256比特，如果参数太大了(如字符串)，就会自动计算哈希存储到主题内；

    // 日志的第二部分：数据(Data),事件中不带indexed的参数会被存储在data中，理解为事件的值。data中的变量不能被直接检索，但是可以存储任意大小的数据，
    // data常用来存储复杂的数据结构，如：数组和字符串等，另外data中存储的变量在gas的消耗上要低于主题(Topics)；
}