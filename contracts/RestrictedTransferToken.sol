pragma solidity ^0.4.18;

import "./ControlledSupplyToken.sol";
import "./AllowanceRegistryInterface.sol";
import "./Ownable.sol";


contract RestrictedTransferToken is ControlledSupplyToken, Ownable {

    address public allowedRegistry;
  
    modifier onlyToAllowed {
        AllowanceRegistryInterface registry = AllowanceRegistryInterface(allowedRegistry);
        require(registry.isAllowed(msg.sender));
        _;
    }

    function RestrictedTransferToken(
        uint256 _initialAmount,
        string _tokenName,
        uint8 _decimalUnits,
        string _tokenSymbol,
        address _supplyController,
        address _allowedRegistry
    ) ControlledSupplyToken(
        _initialAmount,
        _tokenName,
        _decimalUnits,
        _tokenSymbol,
        _supplyController
    ) Ownable ()
    public
    {
        require(_allowedRegistry != 0);
        allowedRegistry = _allowedRegistry; 
    }


    function transfer(address _to, uint256 _value) public onlyToAllowed returns (bool success) {
        require(balances[msg.sender] >= _value);
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public onlyToAllowed returns (bool success) {
        uint256 allowance = allowed[_from][msg.sender];
        require(balances[_from] >= _value && allowance >= _value);
        balances[_to] += _value;
        balances[_from] -= _value;
        if (allowance < MAX_UINT256) {
            allowed[_from][msg.sender] -= _value;
        }
        emit Transfer(_from, _to, _value);
        return true;
    }

    function changeRegistry(address _newRegistry) public onlyOwner{
        require(_newRegistry != 0);
        allowedRegistry = _newRegistry; 
    }

}
