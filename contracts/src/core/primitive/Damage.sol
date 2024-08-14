// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

// For console.log
import "hardhat/console.sol";
import "../gm/DiceRoller.sol";
import "../pc/core/Class.sol";
import "../pc/core/Language.sol";
import "../pc/core/Stats.sol";


enum DamageType {   //https://2e.aonprd.com/Rules.aspx?ID=2308
    BLUDGEONING,
    PIERCING,
    SLASHING,
    ACID,
    COLD,

    ELECTRICITY,
    FIRE,
    SONIC,
    SPIRIT,
    MENTAL,

    POISON,
    BLEED,
    PRECISION,
    VITALITY, //Targets Undead
    VOID //Targets Living
}

function packDamageType(DamageType dT) pure returns(uint) {
    if(dT == DamageType.BLUDGEONING) return 1 & 0xFF;
    else if(dT == DamageType.PIERCING) return 2 & 0xFF;
    else if(dT == DamageType.SLASHING) return 3 & 0xFF;
    else if(dT == DamageType.ACID) return 4 & 0xFF;

    else if(dT == DamageType.COLD) return 5 & 0xFF;
    else if(dT == DamageType.ELECTRICITY) return 6 & 0xFF;
    else if(dT == DamageType.FIRE) return 7 & 0xFF;
    else if(dT == DamageType.SONIC) return 8 & 0xFF;
    else if(dT == DamageType.SPIRIT) return 9 & 0xFF;

    else if(dT == DamageType.MENTAL) return 10 & 0xFF;
    else if(dT == DamageType.POISON) return 11 & 0xFF;
    else if(dT == DamageType.BLEED) return 12 & 0xFF;
    else if(dT == DamageType.PRECISION) return 13 & 0xFF;
    else if(dT == DamageType.VITALITY) return 14 & 0xFF;
    else return 15 & 0xFF; //VOID

}

error InvalidDamageType();


function getDamageType(string memory d) pure returns(DamageType) {
    if(keccak256(bytes(d)) == keccak256(bytes("BLUDGEONING"))) return DamageType.BLUDGEONING;
    else if(keccak256(bytes(d)) == keccak256(bytes("PIERCING"))) return DamageType.PIERCING;
    else if(keccak256(bytes(d)) == keccak256(bytes("SLASHING"))) return DamageType.SLASHING;
    else if(keccak256(bytes(d)) == keccak256(bytes("ACID"))) return DamageType.ACID;
    else if(keccak256(bytes(d)) == keccak256(bytes("COLD"))) return DamageType.COLD;

    else if(keccak256(bytes(d)) == keccak256(bytes("ELECTRICITY"))) return DamageType.ELECTRICITY;
    else if(keccak256(bytes(d)) == keccak256(bytes("FIRE"))) return DamageType.FIRE;
    else if(keccak256(bytes(d)) == keccak256(bytes("SONIC"))) return DamageType.SONIC;
    else if(keccak256(bytes(d)) == keccak256(bytes("SPIRIT"))) return DamageType.SPIRIT;
    else if(keccak256(bytes(d)) == keccak256(bytes("MENTAL"))) return DamageType.MENTAL;

    else if(keccak256(bytes(d)) == keccak256(bytes("POISON"))) return DamageType.POISON;
    else if(keccak256(bytes(d)) == keccak256(bytes("BLEED"))) return DamageType.BLEED;
    else if(keccak256(bytes(d)) == keccak256(bytes("PRECISION"))) return DamageType.PRECISION;
    else if(keccak256(bytes(d)) == keccak256(bytes("VITALITY"))) return DamageType.VITALITY;
    else if(keccak256(bytes(d)) == keccak256(bytes("VOID"))) return DamageType.VOID;
    else revert InvalidDamageType();
}