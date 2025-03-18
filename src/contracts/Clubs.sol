// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./SportToken.sol";
import "./Player.sol";

contract Club is ERC20 {
    string public logo; //https address of team logo
    uint256 public stadiumSize; //stadium capacity
    uint256 public avgSeatPrice; //average stadium seat price
    string public clubCity; //city of stadium
    string public clubCoach; //current manager
    uint256 public clubStanding; //current standing
    uint256 public clubPrice; //currentClubPrice;

    constructor(
        string memory name,
        string memory symbol,
        uint256 amount,
        string memory _logo,
        uint256 _stadiumSize,
        uint256 _avgSeatPrice,
        string memory _clubCity,
        string memory _clubCoach,
        uint256 _clubStanding
    ) ERC20(name, symbol) {
        _mint(msg.sender, amount);

        logo = _logo;
        stadiumSize = _stadiumSize;
        avgSeatPrice = _avgSeatPrice;
        clubCity = _clubCity;
        clubCoach = _clubCoach;
        clubStanding = _clubStanding;
    }
    
}

contract ClubsFactory is Ownable {
    mapping(string => address) public clubs; //input=> clubName:clubAddress
    mapping(address => address) public playerClubs; // input=> playerAddress: clubAddress
    mapping(string => uint256) public clubPrices; //input=> clubName:clubPrice in SportToken
    mapping(string => address) public players; //input=> playerName:plyerAddress
    mapping(string => address) private playerOwners; //input=> playerName: playerTokenOwner
    mapping(string => string[]) public teamsPlayerList; //input=> clubName:array of playersNames
    string[] public clubsList;
    uint256 public clubsLength;
    
    SportToken sportToken;

    constructor(address initialOwner, address _sportToken)
        Ownable(initialOwner)
    {
        sportToken = SportToken(_sportToken);
    }

    function addClub(
        string memory name,
        string memory symbol,
        uint256 amount,
        string memory logo,
        uint256 stadiumSize,
        uint256 avgSeatPrice,
        string memory clubCity,
        string memory clubCoach,
        uint256 clubStanding
    ) public onlyOwner {
        require(clubs[name] == address(0), "Club exists");
        
        clubs[name] = address(
            new Club(
                name,
                symbol,
                amount,
                logo,
                stadiumSize,
                avgSeatPrice,
                clubCity,
                clubCoach,
                clubStanding
            )
        );
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
        teamsPlayerList[clubName].push(playerName);
    }

    function getPlayersOnTeam(string memory _clubName)  public view returns (string[] memory) {
          return teamsPlayerList[_clubName];
    }

        function getTeamsInLeague() public view returns (string[] memory) {
           return clubsList;
    }
}