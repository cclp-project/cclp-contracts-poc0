pragma solidity ^0.4.18;

import "./AllowanceRegistryInterface.sol";

contract AllowanceRegistry is AllowanceRegistryInterface {
    
    address public owner;
    mapping (address => bool) public registrars;
    mapping (address => bool) public allowed;

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    modifier onlyRegistrar {
        require(registrars[msg.sender]);
        _;
    }

    function AllowanceRegistry(
        address _owner
    ) public
    {
        require(_owner != 0);
        owner = _owner; 
    }

    function changeOwner(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }

    function setRegistrar(address _registar, bool _value) public onlyOwner {
        registrars[_registar] =_value;
    }

    function allowUser(address _user) public onlyRegistrar {
        allowed[_user] = true;
    }

    function denyUser(address _user) public onlyRegistrar {
        allowed[_user] = false;
    }


    function isAllowed(address _user) public returns(bool _isAllowed){
        return allowed[_user];
    }


}
