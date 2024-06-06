//SPDX-License-Identifier:MIT 

pragma solidity ^0.8.24;


import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {Script} from "../lib/forge-std/src/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";


contract DeployMoodNft is Script{

    function run() external returns(MoodNft){
        string memory smileSvg = vm.readFile("./img/smile.svg");
        string memory goofySvg = vm.readFile("./img/goofy.svg");

        vm.startBroadcast();
        MoodNft moodNft = new MoodNft(svgToImageUri(smileSvg), svgToImageUri(goofySvg));
        vm.stopBroadcast();
        return moodNft;
    }

    function svgToImageUri(string memory svg) public pure returns(string memory){
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );
        return string(abi.encodePacked(baseURL,svgBase64Encoded));
    }
}