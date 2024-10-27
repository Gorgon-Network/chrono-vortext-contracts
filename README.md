# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a Hardhat Ignition module that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat ignition deploy ./ignition/modules/Lock.js
```
test net
npx hardhat ignition deploy ./ignition/modules/AirCraftNFT.js --network linea_sepolia --reset
npx hardhat verify --network linea_sepolia <DEPLOYED_CONTRACT_ADDRESS> <CONTRACT_ARGUMENTS>

main-net
npx hardhat ignition deploy ./ignition/modules/AirCraftNFT.js --network linea_mainnet --reset
npx hardhat verify --network linea_mainnet <DEPLOYED_CONTRACT_ADDRESS> <CONTRACT_ARGUMENTS>
