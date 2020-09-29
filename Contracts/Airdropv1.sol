pragma solidity ^0.7.2;


abstract contract ERC20 {
    function transfer(address to, uint256 value) public virtual returns (bool);
    function decimals() public virtual view returns (uint);
    function balanceOf(address who) public virtual view returns (uint256);

}


contract Airdrop{
    address public admin;

    function randomNumber(uint i) public view returns (uint){
        return uint(blockhash(block.number-i))%100 + 1;
    }

    function drop(address token, address[] memory recipients) public{
        for(uint i = 0; i<recipients.length;i++){
            ERC20(token).transfer(recipients[i],randomNumber(i+1)*(10**ERC20(token).decimals()));
        }
    a}
    function withdraw(address token) public {
        require(msg.sender==admin);
        ERC20(token).transfer(admin,ERC20(token).balanceOf(address(this)));
    }

}
