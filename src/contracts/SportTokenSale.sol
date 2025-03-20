// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {SportToken} from "./SportToken.sol";

interface IERC20 {
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);

    function balanceOf(address account) external view returns (uint256);
}

contract SportTokenSale {
    address public owner;
    SportToken public sportToken;
    uint256 public constant tokenPrice = 0.005 ether; // 0.005 Sepolia ETH
    uint256 public constant tokensPerPurchase = 100; // 100 SportTokens
    uint256 public constant icoAmount = 100; // ICO allocation per user

    mapping(address => bool) public icoRegister;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    event TokensPurchased(address indexed buyer, uint256 amount);
    event FundsWithdrawn(address indexed owner, uint256 amount);
    event ICOClaimed(address indexed user, uint256 amount);

    constructor(address _sportToken) {
        owner = msg.sender;
        sportToken = SportToken(_sportToken);
    }

    // Purchase 100 SportTokens for 0.005 Sepolia ETH
    function buyTokens() external payable {
        require(msg.value == tokenPrice, "Incorrect ETH amount sent");
        require(
            sportToken.balanceOf(address(this)) >= tokensPerPurchase,
            "Not enough SportTokens in contract"
        );

        sportToken.transfer(msg.sender, tokensPerPurchase);
        emit TokensPurchased(msg.sender, tokensPerPurchase);
    }

    // Withdraw ETH from contract (Only Owner)
    function withdrawFunds() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds to withdraw");

        (bool success, ) = payable(owner).call{value: balance}("");
        require(success, "Withdrawal failed");

        emit FundsWithdrawn(owner, balance);
    }

    // Claim free ICO tokens (One-time claim)
    function getICO() public {
        require(
            !icoRegister[msg.sender],
            "This address already claimed the ICO"
        );
        require(
            sportToken.balanceOf(address(this)) >= icoAmount,
            "Not enough SportTokens in contract"
        );

        sportToken.transfer(msg.sender, icoAmount);
        icoRegister[msg.sender] = true;

        emit ICOClaimed(msg.sender, icoAmount);
    }

    // Allow contract to receive ETH
    receive() external payable {}
}
