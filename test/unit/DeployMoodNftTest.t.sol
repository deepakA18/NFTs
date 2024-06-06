//SPDX-License-Identifier:MIT

pragma solidity ^0.8.24;

import {Test,console} from "../../lib/forge-std/src/Test.sol";
import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";

contract  DeployMoodNftTest is Test{

    DeployMoodNft public deployer;

    function setUp() public {
        deployer = new DeployMoodNft();
    }

    function testConvertSvgToUri() public view{
        string memory expectedUri = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB3aWR0aD0iNTAwIiBoZWlnaHQ9IjUwMCI+DQo8dGV4dB4PSIwIiB5PSIxNSIgZmlsbD0iYmxhY2siPkhpISBZb3VyIGJyb3dzZXIgZGVjb2RlZCB0aGlzPC90ZXh0Pg0KPC9zdmc+";

        string memory svg = '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="500" height="500"><text x="0" y="15" fill="black">Hi! Your browser decoded this</text></svg>';

        string memory actualUri = deployer.svgToImageUri(svg);
        console.log(actualUri);
        assert(keccak256(abi.encodePacked(actualUri)) == keccak256(abi.encodePacked(expectedUri)));
    }

}