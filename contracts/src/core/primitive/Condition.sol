// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

// For console.log
import "hardhat/console.sol";
import "../gm/DiceRoller.sol";
import "../pc/core/Class.sol";
import "../pc/core/Language.sol";
import "../pc/core/Stats.sol";

enum Condition { //https://2e.aonprd.com/Conditions.aspx
    FRIENDLY,
    HELPFUL,
    HOSTILE,
    INDIFFERENT,
    UNFRIENDLY,

    DOOMED,
    DYING,
    UNCONSCIOUS,
    WOUNDED,

    HIDDEN,
    OBSERVED,
    UNDETECTED,
    UNNOTICED,
    CLUMSY,
    DRAINED,
    ENFEEBLED,
    STUPEFIED,

    BLINDED,
    CONCEALED,
    DAZZLED,
    DEAFENED,
    INVISIBLE
}
error InvalidCondition();


function getCondition(string memory c) pure returns(Condition) {
    if(keccak256(bytes(c)) == keccak256(bytes("FRIENDLY"))) return Condition.FRIENDLY;
    else if(keccak256(bytes(c)) == keccak256(bytes("HELPFUL"))) return Condition.HELPFUL;
    else if(keccak256(bytes(c)) == keccak256(bytes("HOSTILE"))) return Condition.HOSTILE;
    else if(keccak256(bytes(c)) == keccak256(bytes("INDIFFERENT"))) return Condition.INDIFFERENT;
    else if(keccak256(bytes(c)) == keccak256(bytes("UNFRIENDLY"))) return Condition.UNFRIENDLY;
    else if(keccak256(bytes(c)) == keccak256(bytes("DOOMED"))) return Condition.DOOMED;
    else if(keccak256(bytes(c)) == keccak256(bytes("DYING"))) return Condition.DYING;
    else if(keccak256(bytes(c)) == keccak256(bytes("UNCONSCIOUS"))) return Condition.UNCONSCIOUS;
    else if(keccak256(bytes(c)) == keccak256(bytes("WOUNDED"))) return Condition.WOUNDED;
    else if(keccak256(bytes(c)) == keccak256(bytes("HIDDEN"))) return Condition.HIDDEN;
    else if(keccak256(bytes(c)) == keccak256(bytes("OBSERVED"))) return Condition.OBSERVED;
    else if(keccak256(bytes(c)) == keccak256(bytes("UNDETECTED"))) return Condition.UNDETECTED;
    else if(keccak256(bytes(c)) == keccak256(bytes("UNNOTICED"))) return Condition.UNNOTICED;
    else if(keccak256(bytes(c)) == keccak256(bytes("CLUMSY"))) return Condition.CLUMSY;
    else if(keccak256(bytes(c)) == keccak256(bytes("DRAINED"))) return Condition.DRAINED;
    else if(keccak256(bytes(c)) == keccak256(bytes("ENFEEBLED"))) return Condition.ENFEEBLED;
    else if(keccak256(bytes(c)) == keccak256(bytes("STUPEFIED"))) return Condition.STUPEFIED;
    else if(keccak256(bytes(c)) == keccak256(bytes("BLINDED"))) return Condition.BLINDED;
    else if(keccak256(bytes(c)) == keccak256(bytes("CONCEALED"))) return Condition.CONCEALED;
    else if(keccak256(bytes(c)) == keccak256(bytes("DAZZLED"))) return Condition.DAZZLED;
    else if(keccak256(bytes(c)) == keccak256(bytes("DEAFENED"))) return Condition.DEAFENED;
    else if(keccak256(bytes(c)) == keccak256(bytes("INVISIBLE"))) return Condition.INVISIBLE;
    else revert InvalidCondition();
}


function packCondition(Condition c) pure returns(uint) {
    if(c == Condition.FRIENDLY) return 1 & 0xFF;
    else if(c == Condition.HELPFUL) return 2 & 0xFF;
    else if(c == Condition.HOSTILE) return 3 & 0xFF;
    else if(c == Condition.INDIFFERENT) return 4 & 0xFF;
    else if(c == Condition.UNFRIENDLY) return 5 & 0xFF;

    else if(c == Condition.DOOMED) return 6 & 0xFF;
    else if(c == Condition.DYING) return 7 & 0xFF;
    else if(c == Condition.UNCONSCIOUS) return 8 & 0xFF;
    else if(c == Condition.WOUNDED) return 9 & 0xFF;

    else if(c == Condition.HIDDEN) return 10 & 0xFF;
    else if(c == Condition.OBSERVED) return 11 & 0xFF;
    else if(c == Condition.UNDETECTED) return 12 & 0xFF;
    else if(c == Condition.UNNOTICED) return 14 & 0xFF;
    else if(c == Condition.CLUMSY) return 15 & 0xFF;
    else if(c == Condition.DRAINED) return 16 & 0xFF;
    else if(c == Condition.ENFEEBLED) return 17 & 0xFF;
    else if(c == Condition.STUPEFIED) return 18 & 0xFF;

    else if(c == Condition.BLINDED) return 19 & 0xFF;
    else if(c == Condition.CONCEALED) return 20 & 0xFF;
    else if(c == Condition.DAZZLED) return 21 & 0xFF;
    else if(c == Condition.DEAFENED) return 22 & 0xFF;
    else return 23 & 0xFF; //INVISIBLE
}