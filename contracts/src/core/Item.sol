// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

// For console.log
import "hardhat/console.sol";
import "../core/gm/DiceRoller.sol";
import "./pc/core/Class.sol";
import "./pc/core/Language.sol";
import "./pc/core/Stats.sol";

enum ItemType {
    WEAPON,
    ARMOR,
    CONSUMABLE,
    WORN,
    AMMUNITION
}


contract Item {
    string public name;
    //[WPN, ARMR, CON, WORN, AMMO]
    uint public stats; //Packed differently based on ItemType
                //WEAPON -> uint8 numDice, uint8 dieSize, uint8 sign, uint8 modifier. (e.g. 2 8 1 1 ... = 2d8+1)
                //                                                                    (     2 8 0 1 ... = 2d8-1)

    uint public itemId;
    ItemType public itemType;
    //TODO: May have an Action available as well, or a Bonus Action/Reaction

    constructor(uint _itemId, string memory _name, uint _stats, ItemType _itemType) {
        itemId = _itemId;
        name = _name;
        stats = _stats;
        itemType = _itemType;
    }

    function rollDiceWithModifier(uint seed) public returns (uint) {
        uint _stats = getRollableStats();
        uint numDice = (_stats >> 24) & 0xFF;
        uint dieSize = (_stats >> 16) & 0xFF;
        uint sign = (_stats >> 8) & 0xFF;
        uint bonus = _stats & 0xFF;
        DiceRoller roller = new DiceRoller();
        uint retVal = 0;
        console.log("Rolling For Item: %dd%d", numDice, dieSize, sign == 1 ? "+" : "-");
        console.log("%d", bonus);
        for(uint i = 0; i  < numDice; i++) {
            roller.randomRoll(uint32(seed), uint8(dieSize));
            retVal += roller.getLastRoll();
            console.log("d%d rolled %d!", dieSize, roller.getLastRoll());
        }
        if(bonus > 0) {
            console.log("Applying Bonus Modifier");
            if(sign == 1) retVal += bonus;
            else retVal -= bonus;
        }
        return retVal;
}

    function packItemStats(uint numDice, uint dieSize, uint sign, uint bonus) public view returns(uint) {
        uint _stats = 0;
        _stats = numDice & 0x00000000000000000000000000000000000000000000000000000000000000FF;
        _stats <<= 8;
        _stats |= dieSize & 0x00000000000000000000000000000000000000000000000000000000000000FF;
        _stats <<= 8;
        _stats |= sign & 0x00000000000000000000000000000000000000000000000000000000000000FF;
        _stats <<= 8;
        _stats |= bonus & 0x00000000000000000000000000000000000000000000000000000000000000FF;
        return stats;
        /*
        if(_itemType == ItemType.WEAPON) return stats << 28;
        if(_itemType == ItemType.ARMOR) return stats << 24;
        if(_itemType == ItemType.CONSUMABLE) return stats << 18;
        if(_itemType == ItemType.WORN) return stats << 14;
        else return stats << 10;    //Ammunition
        */
    }

    function getRollableStats() public view returns(uint) {
        /*
        if(itemType == ItemType.WEAPON) return (stats >> 10) & 0xFFFFFFFF;
        if(itemType == ItemType.ARMOR) return (stats >> 14) & 0xFFFFFFFF;
        if(itemType == ItemType.CONSUMABLE) return (stats >> 18) & 0xFFFFFFFF;
        if(itemType == ItemType.WORN) return (stats >> 24) & 0xFFFFFFFF;
        else return (stats >> 28) & 0xFFFFFFFF;
        */
       return stats;
    }

    function getItem() public view returns(Item) {
        return this;
    }

    function getItemType() public view returns(ItemType) {
        return itemType;
    }
}