// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./SportToken.sol";
import "./Player.sol";

contract Club is ERC20 {
    string public logo; //https address of team logo
    uint256 public stadiumsize; //stadium capacity
    uint256 public seatPrice; //average stadium seat price
    string public clubCity; //city of stadium
    string public clubManager; //current manager

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
    uint256 constant maxClubTokens = 10 ** 6;
    mapping(string => address) public clubs; //input=> clubName:clubAddress
    mapping(address => address) public playerClubs; // input=> playerAddress: clubAddress
    mapping(string => uint256) public clubPrices; //input=> clubName:clubPrice in SportToken
    mapping(string => address) public players; //input=> playerName:plyerAddress
    mapping(string => address) private playerOwners; //input=> playerName: playerTokenOwner
    mapping(string => uint256) public playerIds; //input=> playerName: playerId
    mapping(string => uint256) public playerNumbers; //input=> playerName: playerJerseyNumber
    mapping(string => string) public playerPosition; //input=> playerName: playerPosition
    mapping(string => string) public playersTeam; //input=> playerName: clubName
    mapping(bytes32 => string[]) public teamsPlayerList; //input=> clubName:array of playersNames
    string[] public clubsList;
    uint256 public clubsLength;

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
        clubsList.push(name);
        clubsLength = clubsList.length;
    }

    function buyClubToken(
        string memory clubName,
        uint256 amountOfToken,
        uint256 price
    ) public {
        require(clubs[clubName] != address(0), "Club not exist");
        clubPrices[clubName] = price;
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
        clubPrices[clubName] = price;
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
