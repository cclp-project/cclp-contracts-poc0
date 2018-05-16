pragma solidity 0.4.23;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "./cCLP.sol";


contract FeeSupplyController is Ownable {

    address public supplyController;
    cCLP public cCLPInstance;
    address public beneficiaryAddress;
  
    modifier onlySupplyController {
        require(msg.sender == supplyController);
        _;
    }

    modifier onlyBeneficiary {
        require(msg.sender == beneficiaryAddress);
        _;
    }

    constructor(address _supplyController, cCLP _cCLPInstance, address _beneficiaryAddress) 
        public
    {
        require(_supplyController != 0);
        supplyController = _supplyController; 
        
        require(address(_cCLPInstance) != 0);
        cCLPInstance = _cCLPInstance; 
        
        require(address(_beneficiaryAddress) != 0);
        beneficiaryAddress = _beneficiaryAddress; 
    }

    function changeSupplyController(address _newSupplyController) public onlySupplyController {
        supplyController = _newSupplyController;
    }

    function changeBeneficiary(address _newBeneficiaryAddress) public onlyBeneficiary {
        beneficiaryAddress = _newBeneficiaryAddress;
    }

    function increaseSupply(uint value, address to, uint fee) public onlySupplyController {
        cCLPInstance.increaseSupply(value-fee,to);
        cCLPInstance.increaseSupply(fee,beneficiaryAddress);
    }

    function decreaseSupply(uint value, address from, uint fee) public onlySupplyController {
        cCLPInstance.decreaseSupply(value,from);
        cCLPInstance.increaseSupply(fee,beneficiaryAddress);

    }

}
