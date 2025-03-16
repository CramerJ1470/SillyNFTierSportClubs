// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import {Test, console2} from "forge-std/Test.sol";
import {SportToken} from "../src/contracts/SportToken.sol";

contract SportTokenTest is Test, SportToken {
    function testTokenInitialValues() public view {
        assert(name(), "SillyNFTier Sport Token", "token name did not match");
        assert(symbol(), "SST", "token symbol did not match");
        assert(decimals(), 18, "token decimals did not match");
        assert(totalSupply(), 1000000, "token supply should be zero");
    }
}
