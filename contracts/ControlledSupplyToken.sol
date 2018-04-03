pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/token/ERC20/BasicToken.sol";


contract ControlledSupplyToken is BasicToken {

    address public supplyController;
  
    modifier onlySupplyController {
        require(msg.sender == supplyController);
        _;
    }

    function ControlledSupplyToken(address _supplyController) 
        public
    {
        require(_supplyController != 0);
        supplyController = _supplyController; 
    }

    function changeSupplyController(address _newSupplyController) public onlySupplyController {
        supplyController = _newSupplyController;
    }

    function increaseSupply(uint value, address to) public onlySupplyController {
        totalSupply_ = totalSupply_.add(value);
        balances[to] = balances[to].add(value);

        emit Transfer(0, to, value);
    }

    function decreaseSupply(uint value, address from) public onlySupplyController {
        balances[from] = balances[from].sub(value);
        totalSupply_ = totalSupply_.sub(value);

        emit Transfer(from, 0, value);
    }

}
