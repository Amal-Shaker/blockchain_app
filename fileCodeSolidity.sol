// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 < 0.9.0;
contract basicDapp{
    uint balance;
    address private _owner;
        mapping(address => uint) private _owners;

    constructor(){
        balance = 0;
        _owner = msg.sender;

    }
     modifier isOwner() {
        require(msg.sender == _owner);
        _;
    }
    event TransferFunds(address from, address to, uint amount );

      function addOwner(address owner) 
        isOwner 
        public {
        _owners[owner] = 1;
    }

    function sendBalance(uint amount)public{
        balance += amount;
    }


     function withDrawBalance(uint amount)public{
         require(balance > amount , "Not Enough Balance");

        balance -= amount;
    }
     function getBalance()public view returns(uint){
        return balance;
    }

function getAccount()public view returns(address){
return _owner;
}

 
  modifier validOwner() {
        require(msg.sender == _owner || _owners[msg.sender] == 1);
        _;
    }


     function getBalanceEther()public view returns(uint){
         uint d = address(this).balance;
        return d; 
    }
   
    function transferTo(address payable to, uint amount) 
        validOwner
        public {
        require(address(this).balance >= amount);
        to.transfer(amount);
        emit TransferFunds(msg.sender, to, amount);
    }


}