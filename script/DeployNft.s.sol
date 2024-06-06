//SPDX-License-Identifier:MIT

pragma solidity ^0.8.24;

import {Script} from "../lib/forge-std/src/Script.sol"; 
import {NFT} from "../src/NFT.sol"; 

contract DeployNft is Script{
    function run() external returns(NFT) {
        vm.startBroadcast();
        NFT nft = new NFT();
        vm.stopBroadcast(); 
        return nft;
    }
}