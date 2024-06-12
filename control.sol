// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
contract controlFun{
    // if-else
    function ifElseTest(uint256 _number) public pure returns (bool) {
        if (_number == 0) {
            return (true);
        } else {
            return (false);
        }
    }

    // for循环
    function forLoopTest() public pure returns (uint256) {
        uint sum = 0;
        for (uint i = 0; i < 10; i++) {
            sum += i;
        }
        return (sum);
    }

    // while循环
    function whileTest() public pure  returns (uint256) {
        uint sum = 0;
        uint i = 0;
        while (i < 10) {
            sum += i;
            i++;
        }
        return  (sum);
    }

    // do-while循环
    function doWhileTest() public pure returns (uint256) {
        uint sum = 0;
        uint i = 0;
        do{
            sum += i;
            i++;
        } while (i < 10);
        return (sum);
    }

    // 三目运算符：
    function ternaryTest(uint256 x, uint256 y) public pure returns (uint256) {
        return x >= y ? x : y;
    }
    // continue和break和js中的也类似

    // solidity中的插入排序(冒泡排序)
    function insertionSortWrong(uint[] memory arr) public pure returns (uint[] memory) {
        for (uint i = 1; i < arr.length;i++){
            uint temp = arr[i];
            // uint j=i-1; // solidity中常用的变量类型是uint，正整数，如果取到负数会报underflow错误，变量j有可能取到-1，所以会引起错误；
            uint j = i;
            while( (j >= 1) && (temp < arr[j - 1])){
                arr[j] = arr[j - 1];
                j--;
            }
            arr[j] = temp;
        }
        return(arr); // 0:uint256[]: 1,2,3,5,6
    }
}