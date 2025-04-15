// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Club2 is ERC20, Ownable {
    struct ClubInfo {
        string logo;
        uint256 stadiumSize;
        uint256 avgSeatPrice;
        string clubCity;
        string clubCoach;
    }

    ClubInfo public clubDetails;
    uint256 public clubStanding; // Position in the league (1st, 2nd, etc.)
    uint256 public clubPrice; // Market value of the club
    address public clubOwner; // Owner of the club

    constructor(
        string memory _name,
        string memory _symbol,
        string memory _logo,
        uint256 _stadiumSize,
        uint256 _avgSeatPrice,
        string memory _clubCity,
        string memory _clubCoach,
        uint256 _clubStanding
    ) ERC20(_name, _symbol) Ownable(msg.sender) {
        // ✅ Fix: Pass msg.sender to Ownable
        clubDetails = ClubInfo(
            _logo,
            _stadiumSize,
            _avgSeatPrice,
            _clubCity,
            _clubCoach
        );
        clubStanding = _clubStanding;
        clubPrice = calculatePrice(_stadiumSize, _avgSeatPrice, _clubStanding);
        clubOwner = msg.sender; // ✅ Set the contract deployer as the club owner
        _mint(msg.sender, 1_000_000 * 10 ** decimals()); // Mint 1M tokens
    }

    function calculatePrice(
        uint256 _stadiumSize,
        uint256 _avgSeatPrice,
        uint256 _clubStanding
    ) internal pure returns (uint256) {
        uint256 matchesPerSeason = 38; // Premier League season has 38 matches
        uint256 floorNum;

        if (_clubStanding > 0) {
            floorNum = 10 - (_clubStanding / 5);
        } else {
            floorNum = 10 - ((_clubStanding - 1) / 5);
        }

        return
            matchesPerSeason * _avgSeatPrice * _stadiumSize * floorNum * 10e6; //price per SportToken
    }

    function updateLogo(string memory _newLogo) external onlyOwner {
        clubDetails.logo = _newLogo;
    }

    function updateStadiumSize(uint256 _newStadiumSize) external onlyOwner {
        clubDetails.stadiumSize = _newStadiumSize;
        updateClubPrice(clubStanding);
    }

    function updateAvgSeatPrice(uint256 _newSeatPrice) external onlyOwner {
        clubDetails.avgSeatPrice = _newSeatPrice;
        updateClubPrice(clubStanding);
    }

    function updateClubCoach(string memory _newCoach) external onlyOwner {
        clubDetails.clubCoach = _newCoach;
    }

    function updateClubCity(string memory _newCity) external onlyOwner {
        clubDetails.clubCity = _newCity;
    }

    function updateClubPrice(uint256 _newStanding) internal onlyOwner {
        clubPrice = calculatePrice(
            clubDetails.stadiumSize,
            clubDetails.avgSeatPrice,
            _newStanding
        );
    }

    function updateClubStanding(uint256 _newStanding) external onlyOwner {
        clubStanding = _newStanding;
        updateClubPrice(clubStanding);
    }

    function transferClubOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "New owner cannot be zero address");
        clubOwner = newOwner;
        transferOwnership(newOwner); // Updates OpenZeppelin's Ownable owner
    }
}
