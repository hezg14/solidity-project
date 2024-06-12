// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
contract abnormal {
    // solidity 中的三种抛出异常的方法：error、require、assert
    // error是solidity-0.8.4版本之后新加的内容，方便高效(省gas)的向用户解释操作失败的原因，抛出异常的同时可以同时携带参数，帮助开发者更好地调试。
    // 可以在contract之外的定义异常：当用户不是代币的主人(owner)并尝试转账时，会抛出错误如下：
    error TransferNotOwner(); // 自定义的error

    // 携带参数的异常，告知用户尝试转账的账户地址
    // error TransferNotOwner(address sender);
    // 执行过程中error必须搭配revert命令使用
    function transferOwner1(uint256 tokenId, address newOwner) public {
        if(_owners[tokenId] != msg.sender){
            revert TransferNotOwner();
            // revert TransferNotOwner(msg.sender);
        }
        _owners[tokenId] = newOwner;
    }

    // require require命令是solidity 0.8版本之前抛出异常的常用方法，目前很多主流合约仍然还在使用它。
    // 它很好用，唯一的缺点就是gas随着描述异常的字符串长度增加,比error命令要高。使用方法：require(检查条件，"异常的描述")，当检查条件不成立的时候，就会抛出异常。
    // function transferOwner2(uint256 tokenId, address newOwner) public {
    //     require(_owners[tokenId] == msg.sender, "Transfer Not Owner");
    //     _owners[tokenId] = newOwner;
    // }

    // assert命令一般是程序员写程序时做debug使用，他不能解释抛出异常的原因(比require少个字符串)，用法简单，assert(检查条件)，当检查条件不成立的时候，就会抛出异常
    // function transferOwner3(uint256 tokenId, address newOwner) public {
    //     assert(_owners[tokenId] == msg.sender);
    //     _owners[tokenId] = newOwner;
    // }
}

// error方法gas消耗：24457 (加入参数后gas消耗：24660)
// require方法gas消耗：24755
// assert方法gas消耗：24473
// error方法gas最少，其次是assert，require方法消耗gas最多！因此，error既可以告知用户抛出异常的原因，又能省gas，推荐多用