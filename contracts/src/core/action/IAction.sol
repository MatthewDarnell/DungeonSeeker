// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

import "../entity/IEntity.sol";

interface IAction {
    function name() external view returns (string memory);
    //function cost() external view returns(uint);
    function execute(uint seed, IEntity actor, uint actorItemId, IEntity target, uint actionId) external;    
}