// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract LinkTransfer {
    address public LINK_TOKEN;
    address private owner;
      uint256 public constant AMOUNT = 2000000000000000000; // 2 LINK (LINK uses 18 decimals)

    constructor(address _linkToken) {
        LINK_TOKEN = _linkToken;
      
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    // ✅ Approve the contract to spend LINK on sender's behalf
    function approveLink(address contractAddress) public returns (bool) {
        require(contractAddress != address(0), "Invalid spender");
        require(AMOUNT > 0, "Amount must be greater than zero");

        IERC20 link = IERC20(LINK_TOKEN);
        bool success = link.approve(contractAddress, AMOUNT);
        require(success, "LINK approval failed");

        return success;
    }

    // ✅ Transfer LINK from sender to the contract itself
    function withdrawLinkToOwner() external onlyOwner returns (bool)  {
        IERC20 link = IERC20(LINK_TOKEN);
      // Transfer LINK from sender to the contract itself
        bool success = link.transfer(owner, AMOUNT);
        require(success, "LINK transfer failed");

        return success;
    }

      function transferLinkToContract(address sender, address contractAddress) external returns (bool) {
        require(sender != address(0), "Invalid sender");
        require(AMOUNT > 0, "Amount must be greater than zero");

        IERC20 link = IERC20(LINK_TOKEN);

        // Transfer LINK from sender to the contract itself
        bool success = link.transferFrom(msg.sender, contractAddress, AMOUNT);
        require(success, "LINK transfer failed");

        return success;
    }

    // ✅ Check the contract's LINK balance
    function checkContractBalance() external view returns (uint256) {
        IERC20 link = IERC20(LINK_TOKEN);
        return link.balanceOf(address(this));
    }
}