# Chorono Vortex Project


Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat ignition deploy ./ignition/modules/Lock.js
```
linea testnet
npx hardhat ignition deploy ./ignition/modules/AirCraftNFT.js --network linea_sepolia --reset
npx hardhat verify --network linea_sepolia <DEPLOYED_CONTRACT_ADDRESS> <CONTRACT_ARGUMENTS>

linea main-net
npx hardhat ignition deploy ./ignition/modules/AirCraftNFT.js --network linea_mainnet --reset
npx hardhat verify --network linea_mainnet <DEPLOYED_CONTRACT_ADDRESS> <CONTRACT_ARGUMENTS>
