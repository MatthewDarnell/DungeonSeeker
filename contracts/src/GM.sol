// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

// For console.log
import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

import "./core/CampaignState.sol";
import "./core/PlayerCharacter.sol";
import "./core/gm/SkillCheck.sol";
import "./core/Item.sol";


/*
rollSkillCheck(CampaignState state, uint seed, address playerAddress, 
string memory name, string memory stat, 
uint dieSize, uint critFail, uint fail,
 uint success, uint critSuccess

*/
contract GM {
    mapping(uint id => CampaignState) public campaigns;
    constructor() {
    }
    function createCampaign(uint campaignId, uint maxPartySize) public {
        campaigns[campaignId] = new CampaignState(campaignId, maxPartySize);
    }

    function getCampaign(uint campaignId) public view returns(CampaignState) {
        return campaigns[campaignId];
    }

    /*
        Functions for Setting Up The Game. Adding Inventory, Etc.
    */
   function addItemToPlayerInventory(uint campaignId, uint itemId, address playerAddress, string memory name, string memory itemType, uint stats) public {
        ItemType _type = ItemType.WEAPON;
        if(keccak256(bytes(itemType)) == keccak256(bytes("CONSUMABLE"))) _type = ItemType.CONSUMABLE;
        if(keccak256(bytes(itemType)) == keccak256(bytes("WORN"))) _type = ItemType.WORN;
        if(keccak256(bytes(itemType)) == keccak256(bytes("AMMUNITION"))) _type = ItemType.AMMUNITION;
        Item item = new Item(itemId, name, stats, _type);
        CampaignState campaign = campaigns[campaignId];
        PlayerCharacter pc = campaign.getPlayer(playerAddress);
        pc.addItemToInventory(item);
        //uint _itemId, string memory _name, uint _stats, ItemType _itemType
   }

    //Basic Roll for An Item using its built-in stat. (Attack Roll for Weapon, Roll for Healing Potion Amount, etc.)
    //(e.g. 1 Healing potion will roll 1d8)
    function itemRoll(  uint campaignId, uint seed, address playerAddress, 
                        uint itemId) public returns(uint) {
        CampaignState campaign = campaigns[campaignId];
        PlayerCharacter pc = campaign.getPlayer(playerAddress);
        require(pc.hasItemInInventory(itemId) == true, "Item Not In Inventory!");
        Item[] memory items = pc.getItemInInventory(itemId);
        Item item = items[0];
        uint roll = item.rollDiceWithModifier(seed);
        console.log("Item %s rolled: %d", item.name(), roll);
        return roll;
    }

    function skillCheck(uint campaignId, uint seed, address playerAddress, 
    string memory playerName, string memory stat, uint dieSize, uint success) public returns(uint) {
        CampaignState campaign = campaigns[campaignId];
        uint roll = rollSkillCheck(campaign,seed, playerAddress, playerName, stat, dieSize);
        console.log("GM Rolled Skill check %d", roll);
        if(roll >= success) console.log('Check Passed!');
        else console.log('Check Failed!');
        return roll;
    }

}