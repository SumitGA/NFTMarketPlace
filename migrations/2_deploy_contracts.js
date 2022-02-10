const KryptoBird  = artifacts.required("KryptoBird");

module.exports = function(deployer) {
  deployer.deploy(KryptoBird);
};