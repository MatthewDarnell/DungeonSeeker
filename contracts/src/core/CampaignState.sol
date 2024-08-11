// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

// For console.log
import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

import "./PlayerCharacter.sol";


contract CampaignState {
    using EnumerableSet for EnumerableSet.AddressSet;
    address public gm;
    uint public campaignId; //TODO: Pack as many of the uints as possible
    uint public maxPartySize;
    bool public _isInInitiative;
    EnumerableSet.AddressSet private partyAddressSet;
    mapping(address => PlayerCharacter) public party;


    constructor(uint _campaignId, uint _maxPartySize) {
        gm = msg.sender;
        campaignId = _campaignId;
        maxPartySize = _maxPartySize;
        _isInInitiative = false;
    }

    function isInInitiative() public view returns(bool) {
        return _isInInitiative;
    }

    function startEncounter() public {
        _isInInitiative = true;
    }

    function endEncounter() public {
        _isInInitiative = false;
    }

    //It is up to the gm to enforce party unique names!!!
    function addPlayer(address playerAddress, string memory name) public {
        uint partySize = uint(EnumerableSet.length(partyAddressSet));
        //Access Control Here
        require(partySize < maxPartySize, "Party Full!");
        partyAddressSet.add(playerAddress);
        //console.log("Adding Player %o", name);
        party[playerAddress] = new PlayerCharacter(playerAddress, partySize + 1, name, gm);
    }

    function setPartyPlayerStats(   address playerAddress, string memory name, uint INT, uint WIS, 
                                    uint DEX, uint STL, uint PER, uint ARC, uint NAT, uint SUR) public {
        //TODO: Check owner, gm
        console.log("Checking Player %o", name);
        require(keccak256(abi.encodePacked(party[playerAddress].getName())) == keccak256(abi.encodePacked(name)), "Invalid Player Character!");
        party[playerAddress].setStats(INT, WIS, DEX, STL, PER, ARC, NAT, SUR);
    }

    function getPlayerStats(address playerAddress, string memory name) public view returns(uint) {
        require(keccak256(abi.encodePacked(party[playerAddress].getName())) == keccak256(abi.encodePacked(name)), "Invalid Player Character!");
        return party[playerAddress].stats();
    }

    function getPlayer(address playerAddress) public view returns(PlayerCharacter) {
        return party[playerAddress];
    }

    function getPartySize() public view returns (uint) {
        return uint(EnumerableSet.length(partyAddressSet));
    }

}