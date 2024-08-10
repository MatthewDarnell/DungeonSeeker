// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

// For console.log
import "hardhat/console.sol";
import "./DiceRoller.sol";
import "../CampaignState.sol";
import "../PlayerCharacter.sol";
import "../pc/core/Stats.sol";

                                                                            // TODO: pack these values
function rollSkillCheck(CampaignState state, uint seed, address playerAddress, 
                        string memory name, string memory stat, 
                        uint dieSize) returns (uint) {
    DiceRoller roller = new DiceRoller();
    roller.randomRoll(uint32(seed), uint8(dieSize));
    uint roll = roller.getLastRoll();
    uint stats = state.getPlayerStats(playerAddress, name);
    uint statModifier = getStat(stat, stats);
    uint retVal = roll + statModifier;
    console.log("Player %o Rolled a %o Check with a d%o", name, stat, dieSize);
    console.log("(%o + %o => %o)", roll, statModifier, retVal);
    return retVal;
}