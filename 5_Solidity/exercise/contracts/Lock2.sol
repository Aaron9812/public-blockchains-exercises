// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
import "hardhat/console.sol";

contract Lock2 {
    uint256 public unlockTime;
    address payable public owner;
    string public name;

    event Withdrawal(uint256 amount, uint256 when, string name);

    constructor(uint256 _unlockTime) payable {
        require(
            block.timestamp < _unlockTime,
            "Unlock time should be in the future"
        );
        console.log("ES GEHT LOSOOOOO");
        console.log("Deployer of worlds is %s", msg.sender);
        unlockTime = _unlockTime;
        owner = payable(msg.sender);
    }

    function withdraw() public {
        // Uncomment this line, and the import of "hardhat/console.sol", to print a log in your terminal
        // console.log("Unlock time is %o and block timestamp is %o", unlockTime, block.timestamp);

        require(block.timestamp >= unlockTime, "You can't withdraw yet");
        require(msg.sender == owner, "You aren't the owner");

        emit Withdrawal(address(this).balance, block.timestamp, name);

        owner.transfer(address(this).balance);
    }
}
