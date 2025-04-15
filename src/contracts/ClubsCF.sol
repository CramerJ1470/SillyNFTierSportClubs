// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import "@openzeppelin/contracts/interfaces/draft-IERC6093.sol";
import "./StandingsConsumer.sol"; // Import Chainlink Functions Consumer
import {SportToken} from "./SportToken.sol";
import {Player} from "./Player.sol";
import {Club} from "./Club.sol";

contract ClubsFactory is Ownable {
    mapping(string => address) public clubs; //input=> clubName:clubAddress
    mapping(address => address) public playerClubs; // input=> playerAddress: clubAddress
    mapping(string => uint256) public clubPrices; //input=> clubName:clubPrice in SportToken
    mapping(string => address) public players; //input=> playerName:plyerAddress
    mapping(string => address) private playerOwners; //input=> playerName: playerTokenOwner
    mapping(string => string[]) public teamsPlayerList; //input=> clubName:array of playersNames
    string[] public clubsList;
    uint256 public clubsLength;
    string[] public standingsArray;
    uint64 subscriptionId;
    string public standings;

    string[] empty;

    // Chainlink Functions consumer contract address (settable)
    address public functionsConsumer;

    SportToken sportToken;
    GettingStartedFunctionsConsumer standingsConsumer;

    constructor(
        address initialOwner,
        address _sportToken,
        address _functionsConsumer
    ) Ownable(initialOwner) {
        sportToken = SportToken(_sportToken);
        standingsConsumer = GettingStartedFunctionsConsumer(_functionsConsumer);
    }

    // Set the address of the FunctionsConsumer contract after deployment
    function setFunctionsConsumer(
        address _functionsConsumer
    ) external onlyOwner {
        functionsConsumer = _functionsConsumer;
        standingsConsumer = GettingStartedFunctionsConsumer(_functionsConsumer);
    }

    function getStandings() public view returns (string[] memory) {
        string memory standingsString = string(abi.encodePacked(standings)); // Convert bytes32 to string
        return splitString(standingsString);
    }

    function splitString(
        string memory str
    ) public pure returns (string[] memory) {
        uint256 count = 1;
        bytes memory strBytes = bytes(str);

        // Count occurrences of commas to determine array size
        for (uint256 i = 0; i < strBytes.length; i++) {
            if (strBytes[i] == ",") {
                count++;
            }
        }

        // Initialize the array
        string[] memory result = new string[](count);
        uint256 index = 0;
        bytes memory word;

        for (uint256 i = 0; i < strBytes.length; i++) {
            if (strBytes[i] == ",") {
                result[index] = string(word);
                index++;
                word = ""; // Reset word
            } else {
                word = abi.encodePacked(word, strBytes[i]);
            }
        }
        result[index] = string(word); // Add last word
        return result;
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
        uint256 clubStanding,
        uint256 clubPrice
    ) public onlyOwner {
        require(clubs[name] == address(0), "Club exists");

        uint256 matchesPerSeason = 38; //Premier league
        uint256 floorNum;
        if (clubStanding > 0) {
            floorNum = 10 - (clubStanding / 5);
        } else {
            floorNum = 10 - (clubStanding - 1) / 5;
        }
        clubPrice =
            matchesPerSeason *
            avgSeatPrice *
            stadiumSize *
            floorNum *
            10e12;

        clubPrices[name] = clubPrice;

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
                clubStanding,
                clubPrice
            )
        );
        clubPrices[name] = clubPrice;
        clubsList.push(name);
    }

    function initialClubPrice(
        uint256 i_clubStanding,
        uint256 i_stadiumSize,
        uint256 i_avgSeatPrice
    ) internal pure returns (uint256) {
        uint256 matchesPerSeason = 38; //Premier league
        uint256 floorNum;
        if (i_clubStanding > 0) {
            floorNum = 10 - (i_clubStanding / 5);
        } else {
            floorNum = 10 - (i_clubStanding - 1) / 5;
        }
        uint256 i_clubPrice = matchesPerSeason *
            i_avgSeatPrice *
            i_stadiumSize *
            floorNum *
            10e12;
        return i_clubPrice;
    }

    function setClubPrice(
        string memory clubName,
        uint256 _clubStanding
    ) public returns (uint256) {
        uint64 matchesPerSeason = 38; //Premier league
        uint64 floorNum;

        Club club = Club(clubs[clubName]);
        if (_clubStanding > 0) {
            floorNum = 10 - uint64(_clubStanding / 5);
        } else {
            floorNum = 10 - uint64(_clubStanding - 1) / 5;
        }

        uint256 clubPrice = calculateClubPrice(
            matchesPerSeason,
            floorNum,
            club
        );
        clubPrices[clubName] = clubPrice;
        return clubPrice;
    }

    function calculateClubPrice(
        uint64 matchesPerSeason,
        uint64 floorNum,
        Club club
    ) public view returns (uint256) {
        uint256 clubPrice = matchesPerSeason *
            club.avgSeatPrice() *
            club.stadiumSize() *
            floorNum *
            10e12; // 10e12 is equivalent to 10^13

        return clubPrice;
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

    function getPlayersOnTeam(
        string memory _clubName
    ) public view returns (string[] memory) {
        return teamsPlayerList[_clubName];
    }

    function getTeamsInLeague() public view returns (string[] memory) {
        return clubsList;
    }
}
