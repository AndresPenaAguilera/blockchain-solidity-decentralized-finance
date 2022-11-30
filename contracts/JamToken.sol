//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;
//(owner) -> 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
//(Receptor) -> 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
//(Operator) -> 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
contract JamToken{

    string public name ="JAM Token";
    string public symbol = "JAM";
    uint256 public totalSupply  = 1000000000000000000000000;
    uint8 public decimal = 18;

    //Event transfer token of a user
    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 _value
    );

    //Event Operator approbation token
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 value
    );

    //Data structure
    mapping(address=>uint256) public balanceOf;
    mapping(address=>mapping(address => uint)) public allowance;

    constructor(){
        balanceOf[msg.sender]= totalSupply;
    }

    //User token transfer
    function transfer(address _to, uint256 _value) public returns(bool success){
        require( balanceOf[msg.sender] >= _value);
        balanceOf[msg.sender] -=_value;
        balanceOf[_to] +=_value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    // Approve amont for Operator
    function approve(address _spender, uint256 _value)public returns(bool success){
        allowance[msg.sender][_spender] =_value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    //transmitter tokens transfer
     function transferFrom(address _from, address _to, uint256 _value) public returns(bool success){
        require( _value <= balanceOf[_from] );
        require( _value <= allowance[_from][msg.sender] );

        balanceOf[_from] -=_value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -=_value;

        emit Transfer(_from, _to, _value);
        return true;
    }


}

