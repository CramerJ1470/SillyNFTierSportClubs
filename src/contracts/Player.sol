// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Player is ERC20 {
    address private _playerOwner;
    uint256 _playerId;
    uint256 _playerNumber;
    string public _playerPosition;
    string public _playerTeam;

    constructor(
        string memory playerName,
        string memory playerTokenName,
        address owner,
        string memory playerTeam,
        uint256 playerId,
        uint256 playerNumber,
        string memory playerPosition
    ) ERC20(playerName, playerTokenName) {
        uint256 _mintAmount = 1000000;

        // ...

        _playerOwner = owner;
        _playerTeam = playerTeam;
        _playerId = playerId;
        _playerNumber = playerNumber;
        _playerPosition = playerPosition;

        // Mint the token to msg.sender (the deployer).
        _mint(msg.sender, _mintAmount);
    }

    modifier onlyOwner() {
        require(
            msg.sender == _playerOwner,
            "Only the owner can call this function"
        );
        _;
    }
}
