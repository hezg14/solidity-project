// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
    // 调用其他合约
contract callOtherContract {
    // 状态变量_x;
    uint256 private _x = 0;
    // 接收eth的事件，记录amount和gas,
    event Log(uint amount, uint gas);

    // 返回合约内的ETH余额
    function getBalance() view public returns(uint) {
        return address(this).balance;
    }

    // 修改_x，并且继续往合约内转入ETH
    function setX(uint256 x) external payable {
        _x = x;
        // 转入ETH，则释放Log事件
        if(msg.value > 0) {
            emit Log(msg.value, gasleft());
        }
    }

    // 读取_x
    function getX() external view returns(uint x) {
        x = _x;
    }
}

contract CallContract {
    // 传入目标合约地址，生成目标合约的引用，调用目标函数
    // 复制callOtherContract合约的地址，填入callSetX函数的参数中，成功调用后，调用OtherContract合约中的getX验证x变为123
   function callSetX(address _Address, uint256 x) external{
        callOtherContract(_Address).setX(x);
    }

    // 直接在函数内传入合约的引用，将address类型改为目标合约名，可以调用目标合约的getX()函数
    function callGetX(callOtherContract _Address) external view returns(uint x){
        // 该函数参数OtherContract _Address底层类型仍然是address，生成的ABI中、调用callGetX时传入的参数都是address类型
        x = _Address.getX();
    }

    // 创建合约变量，通过合约变量来调用目标函数
    function callGetX2(address _Address) external view returns(uint x){
        // 给变量oc存储callOtherContract合约的引用
        callOtherContract oc = callOtherContract(_Address);
        // 可以直接调用目标合约内的getX()
        x = oc.getX();
    }

    // 调用合约并发送ETH,目标合约的函数时payable，可以调用它来给目标合约转账：_Name(_Address).f{value: _Value}(),_Name是合约名，_Address是合约地址，f为目标函数名，_Value是转的ETH数额(以wei为单位)
    function setXTransferETH(address otherContract, uint256 x) payable external{
        // 通过调用callOtherContract函数的setX来给目标合约转账，(首先setX函数内有payable)
        callOtherContract(otherContract).setX{value: msg.value}(x);
    }
}