// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

// For console.log
import "hardhat/console.sol";

contract DiceRoller {
    uint32 public nonce;
    uint8 public lastRoll;

    constructor() {
        nonce = 0;
        lastRoll = 0;
    }

    function randomRoll(uint32 seed, uint8 dieSize) public {
        //console.log("Generating Random Roll!");
        //console.log("Passed Seed is %o, Nonce is %o, and Die Size is %o", seed, nonce, dieSize);
        // TODO: Enforce GM Address to Call Function
        nonce++;
        uint _height = block.number;
        uint32 _timestamp = uint32(block.timestamp & uint32(0xffffffff));
        //console.log("Timestamp = %o", _timestamp);
        bytes32 _hash = blockhash(_height);        
        
        bytes memory preImage = new bytes(160);

        assembly {
            mstore(add(preImage, 32), seed) 
            mstore(add(preImage, 64), sload(nonce.slot))
            mstore(add(preImage, 96), _timestamp)
            mstore(add(preImage, 128), _hash)
            }
        
        // bytes memory preImage = toBytes(seed), toBytes(height);
        uint8 _rand = uint8((uint256(keccak256(preImage)) % dieSize)) + 1;
        //console.log("Returning Generated Random Value: %o", _rand);
        lastRoll = _rand;
    }

    function getLastRoll() public view returns (uint8 roll) {
        return lastRoll;
    }

}