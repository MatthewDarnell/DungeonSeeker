// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

import "../Item.sol";

interface IEntity {
    function stats() external view returns(uint);
    function name() external view returns (string memory);
    //function cost() external view returns(uint);
    function hasItemInInventory(uint itemId) external view returns(bool);
    function id() external view returns(uint);    
    function getItemInInventory(uint itemId) external view returns(Item[] memory);
}