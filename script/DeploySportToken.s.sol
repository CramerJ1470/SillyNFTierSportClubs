// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {SportToken} from "../src/contracts/SportToken.sol";

// import {AddConsumer, CreateSubscription, FundSubscription} from "./Interactions.s.sol";

contract DeploySportToken is Script {
    function run() external returns (string memory) {
      
        string memory symbol;
        address account = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;


        vm.startBroadcast(account);
        SportToken sportToken = new SportToken(
            "SillyNFTier Sport Token",
            "SST",
            1000000
        );
        symbol = sportToken.symbol();

        vm.stopBroadcast();

        // We already have a broadcast in here
        return symbol;
    }
}
