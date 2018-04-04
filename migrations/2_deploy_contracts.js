const AllowanceRegistry = artifacts.require('AllowanceRegistry');
const RestrictedTransferToken = artifacts.require('RestrictedTransferToken');
const cCLP = artifacts.require('cCLP');

const REGISTRY_OWNER="0x9C803151d0fD38f8C9FCEe7D5d02498dF6067E5A"; //ajunge key

const SUPPLY_CONTROLLER="0x9C803151d0fD38f8C9FCEe7D5d02498dF6067E5A"; //ajunge key
const TOKEN_OWNER="0x9C803151d0fD38f8C9FCEe7D5d02498dF6067E5A"; //ajunge key

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
