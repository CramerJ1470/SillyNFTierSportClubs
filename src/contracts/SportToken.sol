// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SportToken is ERC20 {
    uint256 constant icoAmount = 100;
    mapping(address => bool) public icoRegister;

    constructor(
        string memory name,
        string memory symbol,
        uint256 amount
    ) ERC20(name, symbol) {
        uint256 mintAmount = amount * (10 ** decimals());
        _mint(msg.sender, mintAmount / 10);
        _mint(address(this), mintAmount - mintAmount / 10);
    }

    // function getICO() public {
    //     require(!icoRegister[msg.sender], "This address got the ICO");
    //     this.transfer(msg.sender, icoAmount);
    //     icoRegister[msg.sender] = true;
    // }
}
