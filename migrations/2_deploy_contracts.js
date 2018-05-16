const AllowanceRegistry = artifacts.require('AllowanceRegistry');
const cCLP = artifacts.require('cCLP');

const cCLPRegistryOwner_RINKEBY="0x4503d2cb92be591f4f4e650a953f7da10cb2ffe7"; //multisig key
const cCLPSupplyController_RINKEBY="0x515f4508f0b287b3b953f120b472a9d346e6e616"; //multisig key

const ajungeKey='0x9C803151d0fD38f8C9FCEe7D5d02498dF6067E5A';


module.exports = function (deployer) {
  deployer.deploy(AllowanceRegistry)
  .then(() => {
    return AllowanceRegistry.deployed();
  })
  .then((instance) => {
    let registryOwner=ajungeKey;
    if (network == "rinkeby") {
      registryOwner=cCLPRegistryOwner_RINKEBY
    }
    return instance.transferOwnership(registryOwner);
  })
  .then(() => {
    let supplyController=ajungeKey;
    if (network == "rinkeby") {
      supplyController=cCLPSupplyController_RINKEBY
    }
    return deployer.deploy(
      cCLP, 
      supplyController,
      AllowanceRegistry.address
    );
  })
  .then(() => {
    return cCLP.deployed();
  })
  .then((instance) => {
    let tokenOwner=ajungeKey;
    if (network == "rinkeby") {
      tokenOwner=cCLPSupplyController_RINKEBY
    }
    return instance.transferOwnership(tokenOwner);
  })
  
}
