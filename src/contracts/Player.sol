// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Player is ERC20 {
  
    address public owner;
    string public team;
    uint256 public playerId;
    uint256 public playerNumber;
    string public playerPosition;

    constructor(
        string memory name,
        string memory symbol,
        address _owner,
        string memory _team,
        uint256 _playerId,
        uint256 _playerNumber,
        string memory _playerPosition
    ) ERC20(name, symbol) {
        _mint(msg.sender, 10e6);
       
        owner = _owner;
        team = _team;
        playerId = _playerId;
        playerNumber = _playerNumber;
        playerPosition = _playerPosition;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Need to be Owner to change perfomr this.");
        _;
    }

    function changeTeamJerseyNumberPosition(string memory _newTeam, uint256 _jerseyNumber, string memory _playerPosition) public onlyOwner{
        team = _newTeam;
        playerNumber = _jerseyNumber;
        playerPosition = _playerPosition;
    }
