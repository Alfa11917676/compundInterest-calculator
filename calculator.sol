pragma solidity ^0.8.0;
import "hardhat/console.sol";
contract calculate {

   uint public ct;
   uint public dt;
   mapping (address => uint) public deposited;
   mapping (address => uint) public rewardStored; 
   mapping (address => uint) public lastClaim;

   modifier hasStaked(address _user) {
       if (deposited[_user]>0) {
           uint rewards = getReward(_user);
           rewardStored[_user] += rewards;
       }
       _;
   }

   function getT () public view returns (uint) {
       
          uint val = (ct-dt)/ 1 days;
           console.log(val);
           val = val / 365;
           console.log(val);
           return val;
       
   }

   function getReward(address _user) public view returns (uint) {
        uint t = getT();
        uint amount;
        for (uint i;i<t;i++) {
            uint depositedAmont = deposited[_user];
            amount += depositedAmont * 1 * 30; 
            console.log('In for loop',amount);
        }
        amount = amount / 100;
        console.log('/100',amount);
        amount = amount / 365;
        console.log('/365', amount);

        uint totalDays = (block.timestamp - lastClaim[_user])/ 1 days;
        console.log('totalDays',totalDays);
        uint finalAmount = rewardStored[_user]+amount * totalDays;
        return finalAmount;
   }

   function deposit (uint _amount, uint _setLastClaim) external hasStaked(msg.sender) {
       deposited[msg.sender] = _amount;
       lastClaim[msg.sender] = _setLastClaim;
   }
 
   function setCT (uint _time) external {
       ct = _time;
   }

   function setDT (uint _time) external {
       dt = _time;
   }

}
