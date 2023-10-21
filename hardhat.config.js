require("hardhat-deploy");
require("@nomiclabs/hardhat-waffle");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.20",
  namedAccounts: {
    deployer: {
      default: 0,
    },
  }
};
