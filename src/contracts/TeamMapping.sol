// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TeamMapping {
    mapping(bytes32 => string[]) public playersTeam;

    function addPlayerToTeam(string memory team, string memory player) public {
        bytes32 teamKey = keccak256(abi.encodePacked(team));
        playersTeam[teamKey].push(player);
    }

    function getPlayers(
        string memory team
    ) public view returns (string[] memory) {
        return playersTeam[keccak256(abi.encodePacked(team))];
    }
}
