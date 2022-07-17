// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// NFT contract & helper functions
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

import "hardhat/console.sol";

contract CardArena is ERC721 {
    struct CharacterAttributes {
        uint characterIndex;
        string name;
        string imageURI;
        uint hp;
        uint maxHp;
        uint attackDamage;
    }

    // unique identifier for each token
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // An array that holds all the different starter characters
    CharacterAttributes[] defaultCharacters;
    mapping(uint256 => CharacterAttributes) public nftHolderAttributes; // from the character's token id to the holder's nft attributes
    mapping(address => uint256) public nftHolders; // store the owner of each nft

    constructor(
        string[] memory characterNames,
        string[] memory characterImageURIs,
        uint[] memory characterHp,
        uint[] memory characterAttackDmg
    ) ERC721("StarSailors", "SSAILORS") { // Public identifier symbols for the nft tokens
        // Loop through all the characters and save their attribute values in the contract
        for(uint i = 0; i < characterNames.length; i += 1) {
        defaultCharacters.push(CharacterAttributes({
            characterIndex: i,
            name: characterNames[i],
            imageURI: characterImageURIs[i],
            hp: characterHp[i],
            maxHp: characterHp[i],
            attackDamage: characterAttackDmg[i]
        }));

        CharacterAttributes memory c = defaultCharacters[i];
        console.log("Done initializing %s w/ HP %s, img %s", c.name, c.hp, c.imageURI);
        }

        _tokenIds.increment();
    }

    // User gets NFT based on the character index/tokenID they send through
    function mintCharacterNFT(uint _characterIndex) external {
        uint256 newItemId = _tokenIds.current(); // get the current tokenId which starts at 1
        _safeMint(msg.sender, newItemId); // Assign the tokenId to the caller's wallet address

        nftHolderAttributes[newItemId] = CharacterAttributes({
            characterIndex: _characterIndex,
            name: defaultCharacters[_characterIndex].name,
            imageURI: defaultCharacters[_characterIndex].imageURI,
            hp: defaultCharacters[_characterIndex].hp,
            maxHp: defaultCharacters[_characterIndex].maxHp,
            attackDamage: defaultCharacters[_characterIndex].attackDamage
        });
        
        console.log("Minted NFT w/ tokenId %s and characterIndex %s", newItemId, _characterIndex);
        nftHolders[msg.sender] = newItemId; // see the owner (address) of each NFT (tokenId)
        _tokenIds.increment();
    }
}