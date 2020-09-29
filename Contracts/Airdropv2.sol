pragma solidity ^0.7.2;


abstract contract ERC20 {
    function transfer(address to, uint256 value) public virtual returns (bool);
    function decimals() public virtual view returns (uint);
    function balanceOf(address who) public virtual view returns (uint256);

}


contract Airdrop{


    function balance() public view returns (uint){
        return(address(this).balance);
    }
    receive() external payable {

    }

    constructor() public{
     admin = msg.sender;
    }
    address payable public admin;

    function randomNumber(uint i) public view returns (uint){
        return uint(blockhash(block.number-i))%100 + 1;
    }



    function dropToken(address token, address[] memory recipients, uint[] memory shares) public{

        uint totalShares = 0;

        for(uint i = 0; i<recipients.length;i++){
            uint random = randomNumber(i+1);
            shares[i] = random;
            totalShares+= random;
        }
        for(uint i = 0; i<recipients.length;i++){
            uint dropAmount = (ERC20(token).balanceOf(address(this))*shares[i])/totalShares;
            totalShares-= shares[i];
            ERC20(token).transfer(recipients[i],dropAmount);
        }
    }

    function dropETH(address payable[] memory recipients, uint[] memory shares) public{
        uint totalShares;

        for(uint i = 0; i<recipients.length;i++){
            uint random = randomNumber(i+1);
            shares[i] = random;
            totalShares+= random;
        }
        for(uint i = 0; i<recipients.length;i++){
            uint dropAmount = (address(this).balance*shares[i])/totalShares;
            totalShares-= shares[i];
            recipients[i].transfer(dropAmount);
        }


    }
    function withdraw(address token) public {
        require(msg.sender==admin);
        ERC20(token).transfer(admin,ERC20(token).balanceOf(address(this)));
        admin.transfer(address(this).balance);
    }

}
