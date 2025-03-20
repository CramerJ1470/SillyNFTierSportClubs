// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script,console} from "forge-std/Script.sol";
import {SportTokenSale} from "../src/contracts/SportTokenSale.sol";

contract DeploySportTokenSale is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("SEPOLIA_PRIVATE_KEY"); // Load private key from .env
        address sportTokenAddress = vm.envAddress("SPORT_TOKEN_ADDRESS"); // Load token address from .env
        
        vm.startBroadcast(deployerPrivateKey);

        // Deploy SportTokenSale contract
        SportTokenSale sportTokenSale = new SportTokenSale(sportTokenAddress);
        
        vm.stopBroadcast();

        console.log("SportTokenSale deployed at:", address(sportTokenSale));
    }
}