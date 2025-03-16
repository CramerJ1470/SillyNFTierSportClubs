## SIllyNFTier Sport Token Platform

<p align="center" width="100%">
  <img src="./assets/Premier-League-PNG.png" alt="site"/>
</p>

> ## Table of contents

- [Overview](#overview)
- [Core Features Implemented](#core-features-implemented)
- [Technologies](#technologies)
- [Repo Setup](#repo-setup)
- [Requirements](#requirements)
- [Setup the Project](#setup-the-project)
  - [Install Forge](#install-forge)
  - [Env Setup](#env-setup)
  - [Setup Anvil](#setup-anvil)
- [Setup the Frontend](#setup-the-frontend)
  - [Install Dependencies](#install-dependencies)
- [Testing the Smartcontract](#testing-the-smartcontract)
- [SillyNFTier Sport Token Contract Address](#Nft-factory-contract-address-Sepolia testnet)
- [Contributors](#contributors)
- [Contributing to the project](#contributing-to-the-project)

#

> ## Overview

<p align="justify">
 SillyNFTier Sport Token aims to help individuals learn and utilize smart contracts for use with the sports industry by providing a cutting-edge Blockchain platform where users can trade future contracts of players, invest in clubs, and engage in predictive match outcomes. We strive to create an innovative, fair, and transparent ecosystem that benefits sports enthusiasts, clubs, ,players and investors worldwide.
</p>
#

> ## Core Features Implemented

- Tokenization of Sports Clubs: SillyNFTier facilitates the tokenization of sports clubs and playersvallowing users to invest in and own fractionalized shares of various clubs and players. The ClubsFactory contract enables the creation of unique ERC-20 tokens representing ownership in specific sports clubs and players.

- Club Token Marketplace: The platform incorporates a marketplace for buying and selling club tokens. Users can purchase club tokens using the native SillyNFTier Sport Token (SST), enabling them to participate in sports club ownership and trade these assets.

- Chainlink Oracle Integration: The system integrates Chainlink oracles using Chainlink Automations and Chainlink Functions to obtain external data necessary for various functionalities. This integration enables fetching data from external sources like APIs (e.g., Sportradar), updating token values, and determining price fluctuations based on real-time information.

- ICO Allocation: The SiilyNFTier Sport Token contract includes an Initial Coin Offering (ICO) allocation feature, granting a specific amount of tokens to ICO participants (100 SST). This process is managed to prevent multiple claims from the same address.

- Ownership and Transfer of Tokens: Users can transfer ownership of club tokens, SillyNFTier Sport Tokens, or clubs/player tokens representing positions between addresses. This feature enables trading, staking, or using tokens within the SillyNFTier Sport Token platform.

- Admin Functions and Controls: The system includes functionalities limited to admin roles, such as adding new clubs, setting club prices, and managing the platform's core operations. These controls ensure platform integrity and governance.

`Test Coverage`
- Unit testing ensures that all the codes meet the quality standards and the functions return the expected output.
- Test coverage shows us the extent of how much of our codes are covered by tests. We ideally aim for 100% coverage.

`Natspec commenting`
- This documentation provides information about the codebase and their implementation for both technical and non technical people. 


</p>

#

#
> ## Technologies
| <b><u>Stack</u></b> | <b><u>Usage</u></b> |
| :------------------ | :------------------ |
| **`Solidity`**      | Smart contract      |
| **`React JS`**      | Frontend            |
| **`Ethers JS`**     | Blockchain access   |
| **`Forge`**         | Testing/Interaction |

#

> ## Install Forge

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

<!-- ```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
``` -->

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```

> ## Setup the Frontend
- First run the frontend on your local server to ensure it's fully functional before building for production.

#
> ### Install Dependencies
- Setup and install dependencies
 
```shell
$ npm install 

$ cd client 

$ npm install

$ cd..    

$ cd server

$ npm install

$ cd..

$ npm run start
```


#

> ## Contributors

This Project was created by these awesome dedicated members

 <a href="https://github.com/CramerJ1470" target="_blank">**John Cramer SillyNFTier**</a>
<br />

#

#
> ## Contributing to the project

If you find something worth contributing, please fork the repo, make a pull request and add valid and well-reasoned explanations about your changes or comments.

Before adding a pull request, please note:

- This is an open source project.
- Your contributions should be inviting and clear.
- Any additions should be relevant.
- New features should be easy to contribute to.

All **`suggestions`** are welcome!
#
