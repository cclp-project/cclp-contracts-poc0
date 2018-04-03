pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/ownership/Ownable.sol";
import "zeppelin-solidity/contracts/token/ERC20/StandardToken.sol";

import "./AllowanceRegistryInterface.sol";


contract RestrictedTransferToken is StandardToken, Ownable {

    AllowanceRegistryInterface public registry;
  
    modifier onlyToAllowed(address recipient) {
        require(registry.isAllowed(recipient));
        _;
    }

    function RestrictedTransferToken(AllowanceRegistryInterface _registry) public {
        require(address(_registry) != 0);
        registry = _registry; 
    }

    function transfer(address _to, uint256 _value)
        public 
        onlyToAllowed(_to) 
        returns (bool success) 
    {
        return super.transfer(_to, _value);
    }

    function transferFrom(address _from, address _to, uint256 _value)
        public 
        onlyToAllowed(_to)
        returns (bool success) 
    {
        return super.transferFrom(_from, _to, _value);
    }

    function changeRegistry(AllowanceRegistryInterface _newRegistry) public onlyOwner {
        require(address(_newRegistry) != 0);
        registry = _newRegistry; 
    }

}
