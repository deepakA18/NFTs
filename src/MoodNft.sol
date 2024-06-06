//SPDX-License-Identifier:MIT

pragma solidity ^0.8.24;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {

    //errors

    error MoodNft__CantFlipNftIfNotOwner();

    uint256 private s_tokenCounter;
    string private s_smileSvgUri;
    string private s_goofySvgUri;

    enum Mood {
        SMILE,
        GOOFY
    }

    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(
        string memory smileSvgUri,
        string memory goofySvgUri
    ) ERC721("Mood NFT", "MN") {
        s_tokenCounter = 0;
        s_smileSvgUri = smileSvgUri;
        s_goofySvgUri = goofySvgUri;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.SMILE;
        s_tokenCounter++;
    }

    function filpMood(uint256 tokenId) public {
        if(getApproved(tokenId) != msg.sender && ownerOf(tokenId) != msg.sender){
            revert MoodNft__CantFlipNftIfNotOwner();
        }
        if(s_tokenIdToMood[tokenId] == Mood.SMILE)
        {
            s_tokenIdToMood[tokenId] = Mood.GOOFY;
        }
        else{
             s_tokenIdToMood[tokenId] = Mood.SMILE;
        }
    } 

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory imageURI;
        if (s_tokenIdToMood[tokenId] == Mood.SMILE) {
            imageURI = s_smileSvgUri;
        } else {
            imageURI = s_goofySvgUri;
        }

        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name":"',
                            name(),
                            '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
                            '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
                            imageURI,
                            '"}'
                        )
                    )
                )
            )
        );
    }
}
