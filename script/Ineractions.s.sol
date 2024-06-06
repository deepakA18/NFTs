//SPDX-License-Identifier:MIT

pragma solidity ^0.8.24;

import {Script} from "../lib/forge-std/src/Script.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";
import {NFT} from "../src/NFT.sol";

contract MintNft is Script{
     string public constant BLUE_BERA = "ipfs://QmSYqwf3DpBDzehJesERtSLmWQYcVZv1tmhHyAmXaiowYN/?filename=0-BLUE.json";

     function run() external {
        address mostRecentDeployment = DevOpsTools.get_most_recent_deployment("NFT", block.chainid);

        mintNftOnContract(mostRecentDeployment);
     }

     function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
            NFT(contractAddress).mint(BLUE_BERA);
        vm.stopBroadcast();
     }
}