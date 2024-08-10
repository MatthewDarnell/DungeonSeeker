// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

// For console.log
import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import "./pc/core/Class.sol";
import "./pc/core/Language.sol";
import "./pc/core/Stats.sol";
import "./Item.sol";

struct CharacterSheet {
        uint speed;
        //TO ADD:
        // Feats, Inventory, Alignment (?), Cantrips, Prepared Spells, Spell Slots, etc.
        uint level;
        Class class;
        Language[] languagesSpoken;
        
    }

contract PlayerCharacter {
    using EnumerableSet for EnumerableSet.UintSet;
    uint public id;
    address public gm;
    address public owner;
    string public name;
    string public race; //TODO: make these Enums
    string public background;
    uint public experiencePoints;
    //                                  [acrobatics, arcana, athletics, ...]
    uint public stats; //Packed 256 bit int:   [1 2 3 4 5 6 7 8 9]
    EnumerableSet.UintSet private equipmentSet;
    mapping(uint => Item[]) public equipment;

    CharacterSheet public characterSheet;

    constructor(address _owner, uint playerId, string memory _name, address _gm) {
        id = playerId;
        owner = _owner;
        name = _name;
        gm = _gm;   //Privileged Account
    }

    function getName() external view returns(string memory) {
        return name;
    }

    function addItemToInventory(Item item) public {
        equipmentSet.add(item.itemId());
        equipment[item.itemId()].push(item);
    }

    function hasItemInInventory(uint itemId) public view returns(bool) {
        return EnumerableSet.contains(equipmentSet, itemId);
    }

    function getInventory() public view returns(uint[] memory) {
        uint numItems = uint(EnumerableSet.length(equipmentSet));
        uint[] memory ids = new uint[](numItems);
        for(uint i = 0; i < numItems; i++) {
            ids[i] = uint(EnumerableSet.at(equipmentSet, i));
        }
        return ids;
    }

    function getItemInInventory(uint itemId) public view returns(Item[] memory) {
        return equipment[itemId];
    }

    function setStats(uint INT, uint WIS, uint DEX, uint STL, uint PER, uint ARC, uint NAT, uint SUR) public {
        //require(msg.sender == gm, "Only the GM can Set Player Stats!");
        uint _stats = packStats(INT, WIS, DEX, STL, PER, ARC, NAT, SUR);
        stats = _stats;
    }
}