// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
contract Inheritance {
    // solidity中的继承：简单继承、多重继承、修饰器(modifier)继承、构造函数(constructor)继承
    // 将合约看做对象的话，solidity也是属于面向对象的编程
    // 规则：
    // virtual：父合约中的函数，如果希望在子合约中重写就需要加virtual关键字
    // override：子合约重写了父合约中的函数，需要加override关键字
    // 注意：用override修饰public变量，会重写与变量同名的getter函数，例如：
    // mapping (address => uint256) public override balanceOf;
}

contract grandFather {
    event Log(string msg);

    function hip() public virtual {
        emit Log("grandFather-hip");
    }
    function pop() public virtual {
        emit Log("grandFather-pop");
    }
    function push() public virtual {
        emit Log("grandFather-push");
    }
}


// 简单继承：继承父类的合约：语法：contract 子类 is 父类
contract father is grandFather {
    // 继承父类的hip和pop,输出改为子类
    function hip() public virtual override {
        emit Log("father-hip");
    }
    function pop() public virtual override {
        emit Log("father-pop");
    }

    function fatherTest() public virtual {
        emit Log("father-test");
    }
}


// 多重继承：继承按照辈分从高到底的顺序，如要继承：祖父类，父类的合约，写法如下：contract 子类 is 祖父类, 父类
contract son is grandFather, father {
    // 继承hip、pop
    function hip() public virtual override(grandFather, father) {
        emit Log("son-hip");
    }
    function pop() public virtual override(grandFather, father) {
        emit Log("son-pop");
    }

    // 子合约有两种方式调用父合约的函数，直接调用和利用关键字super
    // 1、直接调用：子合约直接调用，调用方法：父类合约.函数名(),如：father.fatherTest();
    function callParent() public {
        // 调用父类的方法
        father.fatherTest();
    }

    // 2、super关键字调用：solidity继承关系从右到左是：contract son is grandFather, father,最近的父合约位于最右侧(father),所有super.pop(),将调用father.pop();
    function callParentSuper() public {
        super.pop(); // 调用的是father里的pop()函数
    }
}

// 修饰器的集成：modifier同样可以用于继承，用法与函数继承类似，在相应的地方加virtual和override关键字
contract modifierFun {
    modifier exactDividedBy2And3(uint _a) virtual {
         require(_a % 2 == 0 && _a % 3 == 0);
        _;
    }
}

contract Identifier is modifierFun {

    //计算一个数分别被2除和被3除的值，但是传入的参数必须是2和3的倍数
    function getExactDividedBy2And3(uint _dividend) public exactDividedBy2And3(_dividend) pure returns(uint, uint) {
        return getExactDividedBy2And3WithoutModifier(_dividend);
    }

    //计算一个数分别被2除和被3除的值
    function getExactDividedBy2And3WithoutModifier(uint _dividend) public pure returns(uint, uint){
        uint div2 = _dividend / 2;
        uint div3 = _dividend / 3;
        return (div2, div3);
    }
    // // Identifier合约可以直接在代码中使用父合约中的exactDividedBy2And3修饰器，也可以利用override关键字重写修饰器：
    // modifier exactDividedBy2And3(uint _a) override {
    //     _;
    //     require(_a % 2 == 0 && _a % 3 == 0);
    // }
}


// 构造函数的继承：子合约有两种方式继承父合约
abstract contract A {
    uint public a;
     constructor(uint _a) {
        a = _a;
     }
}

// 1、继承时声明父构造函数的参数，如：
contract B is A(1) {
    int _b = 1;
}

// 2、在子合约的构造函数中声明构造函数的参数，如：
contract C is A {
    constructor(uint _c) A(_c * _c) {}
}

// 钻石继承(菱形继承)：一个派生类同时有两个或者两个以上的基类
// 在多重+菱形继承链条上使用super关键字时，需要注意的是使用super会调用继承链条上的每一个合约的相关函数，而不是只调用最近的父合约。


/* 继承树：
  God
 /  \
Adam Eve
 \  /
people
*/
//Adam和Eve两个合约继承God合约，最后让创建合约people继承自Adam和Eve，每个合约都有foo和bar两个函数。 
// 调用合约people中的super.bar(),会依次调用Eve、Adam,最后调用God合约，整个过程God合约只会被调用一次
contract God {
    event Log(string message);

    function foo() public virtual {
        emit Log("God.foo called");
    }

    function bar() public virtual {
        emit Log("God.bar called");
    }
}

contract Adam is God {
    function foo() public virtual override {
        emit Log("Adam.foo called");
    }

    function bar() public virtual override {
        emit Log("Adam.bar called");
        super.bar();
    }
}

contract Eve is God {
    function foo() public virtual override {
        emit Log("Eve.foo called");
        super.foo();
    }

    function bar() public virtual override {
        emit Log("Eve.bar called");
        super.bar();
    }
}

contract people is Adam, Eve {
    function foo() public override(Adam, Eve) {
        super.foo();
    }

    function bar() public override(Adam, Eve) {
        super.bar();
    }
}
