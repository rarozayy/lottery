//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.10;

contract Lottery {

    address payable public owner;
    address[] public players; 
    function participate() external payable {
        require(msg.value == 0.1 ether, "error");
        players.push(msg.sender);
    }
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
         _;
    }
    function random() private view returns (uint) {     
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players)));
    }
    
    function pickWinner() public payable onlyOwner {

        uint index = random() % players.length;
        address winner = players[index];
        payable(winner).transfer(address(this).balance);
        address[] memory players = new address[](0);
    }

    //function getPlayers()

}