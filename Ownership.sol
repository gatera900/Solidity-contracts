// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Ownership {
    address public owner;

    
    constructor() {
        owner = msg.sender;
    }

  
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    
    function changeOwner(address newOwner) public onlyOwner {
        owner = newOwner;
    }
}
