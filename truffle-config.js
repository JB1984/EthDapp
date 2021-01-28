require('babel-register');
require('babel-polyfill');

const HDWalletProvider = require('truffle-hdwallet-provider-privkey');
const privateKey = "2a988a1ed7cf8777e77e0c35280e3a55a878a1b771fccfb5c21a11113f168809";
const endpointUrl = "https://kovan.infura.io/v3/11f160d7aa1e4100bb24603aecb77ac2";

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*" // Match any network id
    },
    kovan: {
      provider: function() {
        return new HDWalletProvider(
          //private keys array
          [privateKey],
          //url to ethereum node
          endpointUrl
        )
      },
      gas: 5000000,
      gasPrice: 25000000000,
      network_id: 42
    }
  },
  contracts_directory: './src/contracts/',
  contracts_build_directory: './src/abis/',
  compilers: {
    solc: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  }
}
