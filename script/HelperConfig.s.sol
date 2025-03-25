// // SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

// // 1. Deploy mocks when we are on a local anvil chain
// // 2. Keep track of contract address across different chains
// // 3. Sepolia ETH/USD
// // Mainnet ETH/USD
// pragma solidity ^0.8.18;

// import {Script} from "forge-std/Script.sol";
// import {MockV3Aggregator} from "../test/mock/MockV3Aggregator.sol";

// contract HelperConfig is Script {
//     // If we are on a local anvil, we deploy mocks
//     // Otherwise, grab the existing address from the live network
//     NetworkConfig public activeNetworkConfig;
//     string[] INITIAL_STANDINGS = [
//         "Liverpool FC",
//         "Arsenal FC",
//         "Nottingham Forest FC",
//         "Chelsea FC",
//         "Manchester City FC",
//         "Newcastle United FC",
//         "Brighton & Hove Albion FC",
//         "Fulham FC",
//         "Aston Villa FC",
//         "Bournemouth FC",
//         "Brentford FC",
//         "Crystal Palace FC",
//         "Manchester United FC",
//         "Tottenham Hotspur FC",
//         "Everton FC",
//         "West Ham United FC",
//         "Wolverhampton Wanderers FC",
//         "Ipswich Town FC",
//         "Leicester City FC",
//         "Southampton FC"
//     ];

//     struct NetworkConfig {
//         address priceFeed; //ETH/USD price feed address
//     }

//     constructor() {
//         if (block.chainid == 11155111) {
//             activeNetworkConfig = getSepoliaEthConfig();
//         } else if (block.chainid == 1) {
//             activeNetworkConfig = getEthMainnetConfig();
//         } else activeNetworkConfig = getOrCreateAnvilEthConfig();
//     }

//     function getSepoliaEthConfig() public pure returns (NetworkConfig memory) {
//         //price feed address
//         NetworkConfig memory sepoliaConfig = NetworkConfig({
//             priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
//         });
//         return sepoliaConfig;
//     }

//     function getEthMainnetConfig() public pure returns (NetworkConfig memory) {
//         //price feed address
//         NetworkConfig memory ethMainnetConfig = NetworkConfig({
//             priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
//         });
//         return ethMainnetConfig;
//     }

//     function getOrCreateAnvilEthConfig() public returns (NetworkConfig memory) {
//         if (activeNetworkConfig.priceFeed != address(0)) {
//             return activeNetworkConfig;
//         }
//         //price fee address

//         // 1. deploy the mocks
//         // 2. return the mocks address
//         vm.startBroadcast();
//         MockV3Aggregator mockPriceFeed = new MockV3Aggregator(
//             INITIAL_STANDINGS
//         );
//         vm.stopBroadcast();

//         NetworkConfig memory anvilConfig = NetworkConfig({
//             priceFeed: address(mockPriceFeed)
//         });
//         return anvilConfig;
//     }
// }
