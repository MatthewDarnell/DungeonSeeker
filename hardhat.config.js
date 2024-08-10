require("@nomicfoundation/hardhat-toolbox");

require('@openzeppelin/hardhat-upgrades');

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    compilers: [
      {
        version: "0.8.24",
        settings: {
          optimizer: {
            enabled: true,
            runs: 77,
          },
        },
      }
    ]
  },
  allowUnlimitedContractSize: true
};
