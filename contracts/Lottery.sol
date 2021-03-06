//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.10;

contract Lottery {
    address public owner;

    address[] public players;

    constructor() {
        owner = msg.sender;
    }

    function participate() external payable {
        require(msg.value == 0.1 ether, "error");
        players.push(msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function random() private view returns (uint256) {
        return
            uint256(
                keccak256(
                    abi.encodePacked(block.difficulty, block.timestamp, players)
                )
            );
    }

    function pickWinner() public payable onlyOwner {
        uint256 index = random() % players.length;
        address winner = players[index];
        payable(winner).transfer(address(this).balance);
        players = new address[](0);
    }
}
