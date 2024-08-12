// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

// For console.log
import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import "../pc/core/Class.sol";
import "../pc/core/Language.sol";
import "../pc/core/Stats.sol";
import "../Item.sol";
import "./IAction.sol";


contract Strike is IAction {
    string actionName;
    uint id;
    constructor(string memory _name) {
        actionName = _name;
    }
    function name() external view override returns(string memory) {
        return actionName;
    }
    
    function execute(uint seed, IEntity actor, uint actorItemId, IEntity target, uint actionId) external {
        require(actor.hasItemInInventory(actorItemId), "Cannot Strike with Unknown Item!");
        id = 0;
        id = actor.id() & 0xFF;
        id <<= 8;
        id |= target.id() & 0xFF;
        id <<= 8;
        id |= actionId & 0xFF;
        id <<= 8;
        id |= actorItemId;
        Item[] memory itemsToUseForStrike = actor.getItemInInventory(actorItemId);
        Item itemToUseForStrike = itemsToUseForStrike[0];
        uint acToBeat = getStat("AC", target.stats());
        uint strModifier = getStat("STR", itemToUseForStrike.stats());
        console.log("%s is Striking %s With %s!", actor.name(), target.name(), itemToUseForStrike.name());
        console.log("AC To Beat=%d", acToBeat);
        uint damage = itemToUseForStrike.rollDiceWithModifier(seed);
        console.log("Damage = %d!", damage);
    }


}