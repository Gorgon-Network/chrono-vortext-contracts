require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
const { PRIVATE_KEY, INFURA_API_KEY,  LINEASCAN_API_KEY } = process.env;


module.exports = {
  solidity: "0.8.27",
  networks: {
    linea_sepolia: {
      url: `https://linea-sepolia.infura.io/v3/${INFURA_API_KEY}`,
      accounts: [PRIVATE_KEY],
    },
    linea_mainnet: {
      url: `https://linea-mainnet.infura.io/v3/${INFURA_API_KEY}`,
      accounts: [PRIVATE_KEY],
    },
  },
  etherscan: {
    apiKey: {
      linea_sepolia: LINEASCAN_API_KEY,
      linea_mainnet: LINEASCAN_API_KEY
    },
    customChains: [
      {
        network: "linea_sepolia",
        chainId: 59141,
        urls: {
          apiURL: "https://api-sepolia.lineascan.build/api",
          browserURL: "https://sepolia.lineascan.build/address"
        }
      },
      {
        network: "linea_mainnet",
        chainId: 59144,
        urls: {
          apiURL: "https://api.lineascan.build/api",
          browserURL: "https://lineascan.build/"
        }
      }
    ]
  }
};