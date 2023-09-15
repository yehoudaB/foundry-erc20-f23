// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {OurToken} from "src/OurToken.sol";
import {Script} from "forge-std/Script.sol";

contract DeployOurToken is Script {
    uint256 initialSupply = 100 ether;

    function run() external returns (OurToken) {
        vm.startBroadcast();
        OurToken ourToken = new OurToken(initialSupply);
        vm.stopBroadcast();
        return ourToken;
    }
}
