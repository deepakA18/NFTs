//SPDX-License-Identifier:MIT

pragma solidity ^0.8.24;

import {Test} from "../../lib/forge-std/src/Test.sol"; 
import {DeployNft} from "../../script/DeployNft.s.sol";
import {NFT} from "../../src/NFT.sol"; 

contract NftTest is Test{

    DeployNft public deployer;
    NFT public nft;
    address public USER = makeAddr("user");
    string public constant BLUE_BERA = "ipfs://QmSYqwf3DpBDzehJesERtSLmWQYcVZv1tmhHyAmXaiowYN/?filename=0-BLUE.json";


    function setUp() public {
        deployer = new DeployNft();
        nft = deployer.run();
    }

    function testName() public view{
        string memory expectedName = 'Bera';
        string memory actualName = nft.name();

        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));

    }

    function testCanMintandHaveBalance() public {
        vm.prank(USER);
        nft.mint(BLUE_BERA);

        assert(nft.balanceOf(USER)  == 1);
        assert(keccak256(abi.encodePacked(BLUE_BERA))== keccak256(abi.encodePacked(nft.tokenURI(0))));

    }
}
