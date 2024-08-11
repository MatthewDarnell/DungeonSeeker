// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

enum Stats {
    INT,
    WIS,
    DEX,
    STL,
    PER,
    ARC,
    NAT,
    SUR
}

function isValidStat(string memory _stat) pure returns(bool) {
    if (keccak256(bytes(_stat)) != keccak256(bytes("INT"))) return false;
    if (keccak256(bytes(_stat)) != keccak256(bytes("WIS"))) return false;
    if (keccak256(bytes(_stat)) != keccak256(bytes("DEX"))) return false;
    if (keccak256(bytes(_stat)) != keccak256(bytes("STL"))) return false;
    if (keccak256(bytes(_stat)) != keccak256(bytes("PER"))) return false;
    if (keccak256(bytes(_stat)) != keccak256(bytes("ARC"))) return false;
    if (keccak256(bytes(_stat)) != keccak256(bytes("NAT"))) return false;
    if (keccak256(bytes(_stat)) != keccak256(bytes("SUR"))) return false;
    return true;
}

function getStatEnum(string memory _stat) pure returns(Stats) {
    require(isValidStat(_stat) == true, "Invalid Stat!");
    if (keccak256(bytes(_stat)) == keccak256(bytes("INT"))) return Stats.INT;
    if (keccak256(bytes(_stat)) == keccak256(bytes("WIS"))) return Stats.WIS;
    if (keccak256(bytes(_stat)) == keccak256(bytes("DEX"))) return Stats.DEX;
    if (keccak256(bytes(_stat)) == keccak256(bytes("STL"))) return Stats.STL;
    if (keccak256(bytes(_stat)) == keccak256(bytes("PER"))) return Stats.PER;
    if (keccak256(bytes(_stat)) == keccak256(bytes("ARC"))) return Stats.ARC;
    if (keccak256(bytes(_stat)) == keccak256(bytes("NAT"))) return Stats.NAT;
    return Stats.SUR;
}
function getStat(string memory _stat, uint stats) pure returns(uint) {
    if (keccak256(bytes(_stat)) == keccak256(bytes("INT"))) return (stats >> 7) & 0xFF;
    if (keccak256(bytes(_stat)) == keccak256(bytes("WIS"))) return (stats >> 6) & 0xFF;
    if (keccak256(bytes(_stat)) == keccak256(bytes("DEX"))) return (stats >> 5) & 0xFF;
    if (keccak256(bytes(_stat)) == keccak256(bytes("STL"))) return (stats >> 4) & 0xFF;
    if (keccak256(bytes(_stat)) == keccak256(bytes("PER"))) return (stats >> 3) & 0xFF;
    if (keccak256(bytes(_stat)) == keccak256(bytes("ARC"))) return (stats >> 2) & 0xFF;
    if (keccak256(bytes(_stat)) == keccak256(bytes("NAT"))) return (stats >> 1) & 0xFF;
    return stats & 0xFF;
}

function packStats(uint INT, uint WIS, uint DEX, uint STL, uint PER, uint ARC, uint NAT, uint SUR) pure returns(uint) {
    uint retVal = 0;
    retVal = (INT & 0xFF);
    retVal <<= 8;
    retVal |= (WIS & 0xFF);
    retVal <<= 8;
    retVal |= (DEX & 0xFF);
    retVal <<= 8;
    retVal |= (STL & 0xFF);
    retVal <<= 8;
    retVal |= (PER & 0xFF);
    retVal <<= 8;
    retVal |= (ARC & 0xFF);
    retVal <<= 8;
    retVal |= (NAT & 0xFF);
    retVal <<= 8;
    retVal |= (SUR & 0xFF);
    return retVal;
}