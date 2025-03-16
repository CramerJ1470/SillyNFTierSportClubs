// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./SportToken.sol";
import "./Player.sol";

contract Club is ERC20 {
    string public logo;
    uint256 public stadiumsize;
    uint256 public seatPrice;
    string public clubCity;
    string public clubManager;

    constructor(
        string memory name,
        string memory symbol,
        uint256 amount
    ) ERC20(name, symbol) {
        _mint(msg.sender, amount);
    }

    function addInfo(
        string memory _logo, // specify the data type as a string and assign it to `_logo` (note: leading underscore is conventional for variables)
        uint256 _stadiumsize,
        uint256 _seatPrice,
        string memory _clubCity,
        string memory _clubManager // same here
    ) public {
        logo = _logo;
        stadiumsize = _stadiumsize;
        seatPrice = _seatPrice;
        clubCity = _clubCity;
        clubManager = _clubManager;
    }
}

contract ClubsFactory is Ownable {
    uint256 constant maxClubTokens = 10 ** 24;
    mapping(string => address) public clubs;
    mapping(address => address) public playerClubs;
    mapping(string => uint256) public prices;
    mapping(string => address) public players;
    mapping(string => string) public logos;
    mapping(string => uint256) public stadiumsizes;
    mapping(string => uint256) public avgSeatPrices;
    mapping(string => string) public clubCities;
    mapping(string => string) public clubManagers;
    mapping(string => address) private playerOwners;
    mapping(string => uint256) public playerIds;
    mapping(string => uint256) public playerNumbers;
    mapping(string => string) public playerPosition;
    mapping(string => string) public playersTeam;
    mapping(bytes32 => string[]) public teamsPlayerList;

    SportToken sportToken;

    constructor(
        address initialOwner,
        address _sportToken
    ) Ownable(initialOwner) {
        sportToken = SportToken(_sportToken);
    }

    function addClub(
        string memory name,
        string memory symbol
    ) public onlyOwner {
        require(clubs[name] == address(0), "Club exists");
        clubs[name] = address(new Club(name, symbol, maxClubTokens));
    }

    function buyClubToken(
        string memory clubName,
        uint256 amountOfToken,
        uint256 price
    ) public {
        require(clubs[clubName] != address(0), "Club not exist");
        prices[clubName] = price;
        sportToken.transferFrom(
            msg.sender,
            address(this),
            price * amountOfToken
        );
        Club(clubs[clubName]).transfer(msg.sender, amountOfToken);
    }

    function sellClubToken(
        string memory clubName,
        uint256 amountOfToken,
        uint256 price
    ) public {
        require(clubs[clubName] != address(0), "Club not exist");
        prices[clubName] = price;
        Club(clubs[clubName]).transferFrom(
            msg.sender,
            address(this),
            amountOfToken
        );
        sportToken.transfer(msg.sender, amountOfToken / price);
    }

    function addPlayer(
        string memory playerName,
        string memory playerTokenName,
        address ownerAddress,
        string memory clubName,
        uint256 _playerId,
        uint256 _playerNumber,
        string memory _playerPosition
    ) public {
        require(players[playerName] == address(0), "Player exists");
        players[playerName] = address(
            new Player(
                playerName,
                playerTokenName,
                ownerAddress,
                clubName,
                _playerId,
                _playerNumber,
                _playerPosition
            )
        );
        playerClubs[players[playerName]] = clubs[clubName];
        playerOwners[playerName] = ownerAddress;
        playerIds[playerName] = _playerId;
        playerNumbers[playerName] = _playerNumber;
        playerPosition[playerName] = _playerPosition;
        playersTeam[playerName] = clubName;
        bytes32 teamKey = keccak256(abi.encodePacked(clubName));
        teamsPlayerList[teamKey].push(playerName);
    }
}
