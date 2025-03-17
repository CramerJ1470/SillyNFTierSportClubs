// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {Player} from "../src/contracts/Player.sol";

// import {AddConsumer, CreateSubscription, FundSubscription} from "./Interactions.s.sol";

contract DeployPlayerToken is Script {

    string[] public playersData;
    function run() external returns (string[] memory) {
        
     

        address account = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;

        vm.startBroadcast(account);
        Player player = new Player(
            "Johnny Shoeshine","JSS", 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, "Liverpool FC",10000,33, "Midfielder"
        );
        playersData.push(player.symbol());
        playersData.push(player.name());
        
      
        

        vm.stopBroadcast();
       
        
        // We already have a broadcast in here
        return playersData;
    }
}
