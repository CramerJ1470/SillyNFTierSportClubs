// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {LinkTransfer} from "../src/contracts/LinkTransfer.sol";

// import {AddConsumer, CreateSubscription, FundSubscription} from "./Interactions.s.sol";

contract DeployLinkTransfer is Script {
   

    function run() public returns (address linkTransferAddress) {
        address account =0x83E048fE9699C3d9a81ba9217Ccd064d148cE2A9;

        vm.startBroadcast(account);
        LinkTransfer linkTransfer = new LinkTransfer(
            0x779877A7B0D9E8603169DdbD7836e478b4624789
        );
        linkTransferAddress = address(linkTransfer);
        vm.stopBroadcast();

        // We already have a broadcast in here
        return linkTransferAddress;
    }
}
