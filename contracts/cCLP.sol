pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/token/ERC20/DetailedERC20.sol";

import "./ControlledSupplyToken.sol";
import "./RestrictedTransferToken.sol";

contract cCLP is StandardToken, ControlledSupplyToken, RestrictedTransferToken, DetailedERC20 {

    function cCLP(address _supplyController, AllowanceRegistryInterface _registry)
        ControlledSupplyToken(_supplyController) 
        RestrictedTransferToken(_registry)
        DetailedERC20('Compensacion de Liquidez Protegida', 'cCLP', 0)
        public    
    {
    }
}
