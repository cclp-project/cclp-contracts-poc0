pragma solidity 0.4.21;

import "zeppelin-solidity/contracts/ownership/Ownable.sol";

import "./AllowanceRegistryInterface.sol";


contract AllowanceRegistry is AllowanceRegistryInterface, Ownable {
    
    mapping (address => bool) public registrars;
    mapping (address => bool) public allowed;

    modifier onlyRegistrar {
        require(registrars[msg.sender]);
        _;
    }
    
    function AllowanceRegistry() public 
    {}

    function setRegistrar(address _registar, bool _value) public onlyOwner {
        registrars[_registar] =_value;
    }

    function allowUser(address _user) public onlyRegistrar {
        allowed[_user] = true;
        emit Allow(msg.sender, _user, now);
    }

    function denyUser(address _user) public onlyRegistrar {
        allowed[_user] = false;
        emit Deny(msg.sender, _user, now);
    }


    function isAllowed(address _user) public view returns(bool _isAllowed){
        return allowed[_user];
    }

    event Allow(address indexed _registar, address indexed _user, uint256 _timestamp); 
    event Deny (address indexed _registar, address indexed _user, uint256 _timestamp); 


}
