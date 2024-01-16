import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomicfoundation/hardhat-foundry";

const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.23",
    settings: {
      evmVersion: "paris",
      optimizer: { enabled: true, runs: 1000000 },
    },
  },
};

export default config;
