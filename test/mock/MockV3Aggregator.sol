// // SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

// contract MockV3Aggregator is AggregatorV3Interface {
//     uint256 public constant version = 4;

//     uint8 public decimals;
//     string[] public latestTeamStandings;
//     uint256 public latestTimestamp;
//     uint256 public latestRound;

//     mapping(uint256 => string[]) public getTeamStandings;
//     mapping(uint256 => uint256) public getTimestamp;

//     constructor(string[] memory _initialTeamStandings) {
//         updateTeamStandings(_initialTeamStandings);
//     }

//     function updateTeamStandings(string[] memory _newTeamStandings) public {
//         latestTeamStandings = _newTeamStandings;
//         latestTimestamp = block.timestamp;
//         latestRound++;
//         getTeamStandings[latestRound] = _newTeamStandings;
//         getTimestamp[latestRound] = block.timestamp;
//     }

//     function updateTeamData(
//         uint80 _roundId,
//         string[] memory _newTeamStandings,
//         uint256 _timestamp
//     ) public {
//         latestRound = _roundId;
//         latestTeamStandings = _newTeamStandings;
//         latestTimestamp = _timestamp;
//         getTeamStandings[latestRound] = _newTeamStandings;
//         getTimestamp[latestRound] = _timestamp;
//     }

//     // Adjusted to match the Chainlink AggregatorV3Interface function signature
//     function getRoundData(
//         uint80 _roundId
//     )
//         external
//         view
//         override
//         returns (
//             uint80 roundId,
//             int256 answer,
//             uint256 startedAt,
//             uint256 updatedAt,
//             uint80 answeredInRound
//         )
//     {
//         roundId = _roundId;
//         answer = 0; // Placeholder as your logic doesn't use int256 values
//         startedAt = getTimestamp[_roundId];
//         updatedAt = getTimestamp[_roundId];
//         answeredInRound = _roundId;
//     }

//     function latestStandingData()
//         external
//         view
//         returns (
//             uint80 roundId,
//             string[] memory teamStandings,
//             uint256 updatedAt
//         )
//     {
//         return (
//             uint80(latestRound),
//             getTeamStandings[latestRound],
//             getTimestamp[latestRound]
//         );
//     }

//     function description() external pure override returns (string memory) {
//         return "v0.6/test/mock/MockV3Aggregator.sol";
//     }
// }