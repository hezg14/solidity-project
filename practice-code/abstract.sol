// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
// solidity中的抽象合约（abstract）和接口（interface），他们都可以写模版并且减少代码冗余
abstract contract InsertionSort {
    // 抽象合约：一个智能合约内至少有一个未实现的函数，也就是某个函数缺少主体{}中的内容，则必须将该合约标注为abstract，不然会报错，未实现的函数也需要加virtual，以便子合约可以重写
    function inserttionSort(uint[] memory a) public pure virtual returns(uint[] memory);
    // 还未具体定义如何实现插入排序的函数，可以将此合约标记为abstract，让别人来写上
}

// 抽象合约示例：
abstract contract Base {
    string public name = "Base";
    function getAlias() public pure virtual returns (string memory);
}

contract BaseImpl is Base {
    function getAlias() public pure override returns (string memory) {
        return "BaseImpl";
    }
}

// 接口：类似于抽象合约，但是不实现任何功能：
// 1、不能包含状态变量
// 2、不能包含构造函数
// 3、不能继承接口之外的其他合约
// 4、所有函数都必须是external且不能有函数体
// 5、继承接口的合约必须实现接口定义的所有功能

// 接口不能实现任何功能，但是接口是智能合约的骨架，定义了合约的功能以及如何触发他们，智能合约实现某种接口，其他Dapps和智能合约就可以知道如何与他交互，因为接口提供了两个重要的信息
// 1、合约里每个函数的bytes4选择器，以及函数签名(函数名)每个参数类型；
// 2、接口id
// 接口与合约等价可以相互转换,编译接口可以得到合约的ABI,利用abi-to-sol工具可以将ABI json文件转换为接口sol文件

// ERC721接口合约
// 接口和常规合约的区别在于每个函数都以;代替函数体{ }结尾。
// interface IERC721 is IERC165 {
//     event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
//     event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
//     event ApprovalForAll(address indexed owner, address indexed operator, bool approved);
    
//     function balanceOf(address owner) external view returns (uint256 balance);

//     function ownerOf(uint256 tokenId) external view returns (address owner);

//     function safeTransferFrom(address from, address to, uint256 tokenId) external;

//     function transferFrom(address from, address to, uint256 tokenId) external;

//     function approve(address to, uint256 tokenId) external;

//     function getApproved(uint256 tokenId) external view returns (address operator);

//     function setApprovalForAll(address operator, bool _approved) external;

//     function isApprovedForAll(address owner, address operator) external view returns (bool);

//     function safeTransferFrom( address from, address to, uint256 tokenId, bytes calldata data) external;
// }

// IERC721事件
// IERC721包含3个事件，其中Transfer和Approval事件在ERC20中也有。

// Transfer事件：在转账时被释放，记录代币的发出地址from，接收地址to和tokenid。
// Approval事件：在授权时释放，记录授权地址owner，被授权地址approved和tokenid。
// ApprovalForAll事件：在批量授权时释放，记录批量授权的发出地址owner，被授权地址operator和授权与否的approved。


// IERC721函数
// balanceOf：返回某地址的NFT持有量balance。
// ownerOf：返回某tokenId的主人owner。
// transferFrom：普通转账，参数为转出地址from，接收地址to和tokenId。
// safeTransferFrom：安全转账（如果接收方是合约地址，会要求实现ERC721Receiver接口）。参数为转出地址from，接收地址to和tokenId。
// approve：授权另一个地址使用你的NFT。参数为被授权地址approve和tokenId。
// getApproved：查询tokenId被批准给了哪个地址。
// setApprovalForAll：将自己持有的该系列NFT批量授权给某个地址operator。
// isApprovedForAll：查询某地址的NFT是否批量授权给了另一个operator地址。
// safeTransferFrom：安全转账的重载函数，参数里面包含了data。


// 什么时候使用接口：当知道一个合约实现了IERC721接口，我们不需要知道具体代码，就可以与他交互，
// 无聊猿(BAYC)属于ERC721代币，实现了IERC721接口的功能，我们只需要知道合约地址就可以用IERC721接口和他交互，比如用balanceOf()来查询某个地址的BAYC余额，用safeTransferFrom()来转账BAYC;
// contract interactBAYC {
//     // 利用BAYC地址创建接口合约变量(ETH主网)
//     IERC721 BAYC = IERC721(0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D);
//     // 通过接口调用BAYC的balanceOf()查询持仓量
//     function balanceOfBAYC(address owner) external view returns (uint256 balance){
//         return BAYC.balanceOf(owner);
//     }

//     // 通过接口调用BAYC的safeTransferFrom()安全转账
//     function safeTransferFromBAYC(address from, address to, uint256 tokenId) external{
//         BAYC.safeTransferFrom(from, to, tokenId);
//     }
// }

// 接口示例：
interface interBase {
    function getFirstName() external pure returns (string memory);
    function getLastName() external pure returns (string memory);
}

contract InterBaseImpl is interBase {
    function getFirstName() external pure override returns (string memory) {
        return "Amazing";
    }

    function getLastName() external pure override returns (string memory) {
        return "last-name";
    }
}