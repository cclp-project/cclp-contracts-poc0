pragma solidity ^0.4.18;

import "./EIP621.sol";


contract ControlledSupplyToken is EIP621 {

    address public supplyController;
  
    modifier onlySupplyController {
        require(msg.sender == supplyController);
        _;
    }

    function ControlledSupplyToken(
        uint256 _initialAmount,
        string _tokenName,
        uint8 _decimalUnits,
        string _tokenSymbol,
        address _supplyController
    ) EIP621(
        _initialAmount,
        _tokenName,
        _decimalUnits,
        _tokenSymbol
    ) public
    {
        require(_supplyController != 0);
        supplyController = _supplyController; 
    }

    function changeSupplyController(address _newSupplyController) public onlySupplyController {
        supplyController = _newSupplyController;
    }


    function increaseSupply(uint value, address to) public onlySupplyController {
        totalSupply = totalSupply.add(value);
        balances[to] = balances[to].add(value);

        emit Transfer(0, to, value);
    }

    function decreaseSupply(uint value, address from) public onlySupplyController {
        balances[from] = balances[from].sub(value);
        totalSupply = totalSupply.sub(value);

        emit Transfer(from, 0, value);
    }

}
