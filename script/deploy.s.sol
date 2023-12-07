// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {soulBondToken} from "../src/erc1155soulbond.sol";

    contract DeployNft is Script {
        soulBondToken _soulbond;

    function run() public {
        uint256 key = vm.envUint("private_key");
        vm.startBroadcast(key);
        // Deploy RollBitPepe contract
        _soulbond = new soulBondToken(0xf79D3EaCd50993471bA3f5D9E3534aE274cAe9dC, "testuriwhichisabyte32lengthdata");
        vm.stopBroadcast();
        console2.log(address(_soulbond));
    }

}