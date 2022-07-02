//SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;
import "./Allowance.sol";

contract SharedWallet is Allowance {
       
   event MoneySent(address indexed beneficiary, uint _amount);
   event MoneyReceived(address indexed _from, uint _amount);

    function withdrawMoney(address payable _to, uint _amount) public OwnerOrAllowed(_amount) {
        require(_amount <= address(this).balance, "Not enough money in Smart Contract");
        if (!isOwner()){
        reduceAllowance(msg.sender, _amount);
        }
        _to.transfer(_amount);
        emit MoneySent(_to, _amount);
    }
    function renounceOwnership () public override onlyOwner {
        revert("Can not renounce ownership here");
    }

    receive() external payable {
        emit MoneyReceived(msg.sender, msg.value);

    }
}