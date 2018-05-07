const AllowanceRegistry = artifacts.require('AllowanceRegistry');
const cCLP = artifacts.require('cCLP');

const REGISTRY_OWNER="0x4503d2cb92be591f4f4e650a953f7da10cb2ffe7"; //multisig key

const SUPPLY_CONTROLLER="0x515f4508f0b287b3b953f120b472a9d346e6e616"; //ajunge key
const TOKEN_OWNER="0x515f4508f0b287b3b953f120b472a9d346e6e616"; //ajunge key

module.exports = function (deployer) {
  deployer.deploy(AllowanceRegistry)
  .then(() => {
    return AllowanceRegistry.deployed();
  })
  .then((instance) => {
    return instance.transferOwnership(REGISTRY_OWNER);
  })
  .then(() => {
    return deployer.deploy(
      cCLP, 
      SUPPLY_CONTROLLER,
      AllowanceRegistry.address
    );
  })
  .then(() => {
    return cCLP.deployed();
  })
  .then((instance) => {
    return instance.transferOwnership(TOKEN_OWNER);
  })
  
}
