//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "./JamToken.sol";
import "./StellarToken.sol";

contract TokenFarm {

    string public name = "Stellar Token Farm";
    address public owner;
    JamToken public jamToken;
    StellarToken public stellarToken;

    address[] public stakers;
    mapping(address => uint) public stakingBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;

    constructor(StellarToken _stellarToken, JamToken _jamToken){
        stellarToken = _stellarToken;
        jamToken = _jamToken;
        owner = msg.sender;
    }

    //Tokens stake
    function stakeTokens(uint _amount) public {
        require(_amount >0, "Amount must be greater than 0");
        jamToken.transferFrom(msg.sender, address(this), _amount);
        stakingBalance[msg.sender] += _amount;
        if(!hasStaked[msg.sender]){
            stakers.push(msg.sender);
        }
        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;
    } 

    //Deleting staking tokens
    function unstakeTokens() public {
        uint balance = stakingBalance[msg.sender];
        require(balance > 0, "Balance straking is 0");
        jamToken.transfer(msg.sender, balance);
        stakingBalance[msg.sender] = 0;
        isStaking[msg.sender] = false;
    }

    //Issuance tokens
    function issueTokens() public {

        require(msg.sender == owner, "You are not owner");

        for(uint i=0; i<stakers.length; i++){
            address recipient = stakers[i];
            uint balance = stakingBalance[recipient];
            if(balance > 0){
                stellarToken.transfer(recipient, balance);
            }
        }
    }

}