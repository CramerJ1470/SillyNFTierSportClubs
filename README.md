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
  - [Create .env file](#env-file)
  - [Install Forge](#install-forge)
  - [Env Setup](#env-setup)
  - [Setup Anvil](#setup-anvil)
  - [Setup Chainlink](#chainlink-setup)
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
>
> | <b><u>Stack</u></b> | <b><u>Usage</u></b> |
> | :------------------ | :------------------ |
> | **`Solidity`**      | Smart contract      |
> | **`React JS`**      | Frontend            |
> | **`Ethers JS`**     | Blockchain access   |
> | **`Forge`**         | Testing/Interaction |

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

> ## Setyp .env file

1. Never Ever use an .env file to store your private Keys and passwords....
2. Watch this!
   <a href="https://updraft.cyfrin.io/courses/foundry/foundry-simple-storage/never-use-a-env-file?lesson_format=written" target="_blank">Cyfrin Updraft Encrypting your keys in Forge</a>

3. you will need these Constants in storage:

- SEPOLIA_PRIVATE_KEY
- SEPOLIA_PRIVATE_KEY_CAST
- SEPOLIA_RPC_URL
- ANVIL_RPC_URL=http://127.0.0.1:8545
- ANVIL_PRIVATE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
- MAINNET_RPC_URL
- ZKSYNC_RPC_URL
- LINK_TOKEN_ADDRESS
- SPORT_TOKEN_ADDRESS
- SPORT_TOKEN_SALE_ADDRESS
- SEPOLIA_ADDRESS // your Sepolia wallet
- X_RAPIDAPI_KEY // your free tier rapidapi key to get standings data

###

> ## Chainlink Setup

### Configure your wallet

You will test on Sepolia, so you must have an Ethereum web3 wallet with enough testnet ETH and LINK tokens. Testnet ETH is the native gas fee token on Sepolia. You will use testnet ETH tokens to pay for gas whenever you make a transaction on Sepolia. On the other hand, you will use LINK tokens to pay the Chainlink Functions Decentralized Oracles Network (DON) for processing your request.

1. <a href="https://docs.chain.link/quickstarts/deploy-your-first-contract#install-and-fund-your-metamask-wallet" target="_blank">Install the MetaMask wallet </a> or other Ethereum web3 wallet.

2. Set the network for your wallet to the Sepolia testnet. If you need to add Sepolia to your wallet, you can find the chain ID and the LINK token contract address on the <a href="https://docs.chain.link/resources/link-token-contracts#sepolia-testnet" target="_blank">LINK Token Contracts page.</a>

3. Request testnet LINK and ETH from <a href="https://faucets.chain.link/sepolia" target="_blank">faucets.chain.link/sepolia.</a>

### Deploy a Functions consumer contract on Sepolia

1. Open the GettingStartedFunctionsConsumer.sol contract in Remix.

<a href="https://remix.ethereum.org/#url=https://docs.chain.link/samples/ChainlinkFunctions/GettingStartedFunctionsConsumer.sol&autoCompile=true" target="_blank">Open in Remix</a>

<a href="https://docs.chain.link/getting-started/conceptual-overview#what-is-remix" target="_blank">What is Remix?</a>

2. Compile the contract.

3. Open MetaMask and select the Sepolia network.

4. In Remix under the Deploy & Run Transactions tab, select Injected Provider - MetaMask in the Environment list. Remix will use the MetaMask wallet to communicate with Sepolia.

<p align="center" width="100%">
  <img src="https://docs.chain.link/images/chainlink-functions/getting-started/injected-provider.jpg" alt="site1"/>
</p>

5. Click the Deploy button to deploy the contract. MetaMask prompts you to confirm the transaction. Check the transaction details to make sure you are deploying the contract to Sepolia.

<p align="center" width="100%">
  <img src="https://docs.chain.link/images/chainlink-functions/getting-started/deploy.jpg" alt="site2"/>
</p>

6. After you confirm the transaction, the contract address appears in the Deployed Contracts list. Copy the contract address and save it for later. You will use this address with a Functions Subscription.

<p align="center" width="100%">
  <img src="https://docs.chain.link/images/chainlink-functions/getting-started/deployed-contracts.jpg" alt="site3"/>
</p>

### Create a subscription

You use a Chainlink Functions subscription to pay for, manage, and track Functions requests.

1. Go to <a href="https://functions.chain.link/" target="_blank">functions.chain.link./a>

2. Click Connect wallet:

<p align="center" width="60%">
  <img src="https://docs.chain.link/images/chainlink-functions/tutorials/subscription/frontend-landing.jpg" alt="site4"/>
</p>

3. Read and accept the Chainlink Foundation Terms of Service. Then click MetaMask.

<p align="center" width="100%">
  <img src="https://docs.chain.link/images/chainlink-functions/tutorials/subscription/accept-CL-foundation-tos.jpg" alt="site5"/>
</p>

4. Make sure your wallet is connected to the Sepolia testnet. If not, click the network name in the top right corner of the page and select Sepolia.

<p align="center" width="100%">
  <img src="https://docs.chain.link/images/chainlink-functions/tutorials/subscription/wallet-connected-ethereum-sepolia.webp"alt="site5"/>
</p>

5. <p align="center" width="100%">
     <img src="https://docs.chain.link/images/chainlink-functions/tutorials/subscription/frontend-landing-wallet-connected.jpg" alt="site5"/>
   </p>

6. Provide an email address and an optional subscription name:
  <p align="center" width="100%">
  <img src="https://docs.chain.link/images/chainlink-functions/tutorials/subscription/create-subscription.jpg" alt="site5"/>
</p>

## Rest of the steps

<a href="https://docs.chain.link/chainlink-functions/getting-started" target="_blank">Follow these remaining steps</a>

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
