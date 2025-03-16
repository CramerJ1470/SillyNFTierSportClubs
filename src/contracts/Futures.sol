// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Futures {
    IERC20 tokenA;
    IERC20 tokenB;

    struct Position {
        uint256 amountOfTokenA;
        uint256 amountOfTokenB;
        uint256 priceInAmountOfToken;
        bool isOpen;
    }

    Position[] public positions;
    mapping(uint256 => address) public positionOwners;

    event PostionOpened(uint256 indexed postionIndex, address postionOwner);
    event PositionClosed(uint256 indexed postionIndex, address postionCloser);
    event PositionModified(uint256 indexed positionIndex);
    event PositionDeleted(uint256 indexed positionIndex);

    constructor(IERC20 _tokenA, IERC20 _tokenB) {
        require(
            address(_tokenA) != address(0) && address(_tokenB) != address(0),
            "Cannot set address 0 for tokens"
        );
        tokenA = _tokenA;
        tokenB = _tokenB;
    }

    function openPosition(Position memory position) public {
        require(
            position.amountOfTokenA == 0 || position.amountOfTokenB == 0,
            "Cannot determinated long or short postion"
        );

        uint256 amount = position.amountOfTokenA > 0
            ? position.amountOfTokenA
            : position.amountOfTokenB;
        require(amount > 0, "Cannot open postion with 0 amount");
        require(position.priceInAmountOfToken > 0, "Price cannot be 0");

        IERC20 token = position.amountOfTokenA > 0 ? tokenA : tokenB;

        token.transferFrom(msg.sender, address(this), amount);

        position.isOpen = true;
        positions.push(position);
        positionOwners[positions.length - 1] = msg.sender;

        emit PostionOpened(positions.length - 1, msg.sender);
    }

    function closePosition(uint256 positionIndex, uint256 tokenAmount) public {
        Position storage position = positions[positionIndex];
        require(position.isOpen, "Position is closed");

        uint256 amount = position.amountOfTokenA > 0
            ? position.amountOfTokenA
            : position.amountOfTokenB;
        (IERC20 buyingToken, IERC20 sellingToken) = position.amountOfTokenA > 0
            ? (tokenB, tokenA)
            : (tokenA, tokenB);

        require(
            tokenAmount >= position.priceInAmountOfToken,
            "Not enought founds to close the position"
        );

        buyingToken.transfer(msg.sender, amount);
        sellingToken.transferFrom(
            msg.sender,
            positionOwners[positionIndex],
            position.priceInAmountOfToken
        );

        position.isOpen = false;
        emit PositionClosed(positionIndex, msg.sender);
    }

    function deletePosition(uint256 positionIndex) public {
        require(
            positionOwners[positionIndex] == msg.sender,
            "Not an owner of the position"
        );

        Position memory position = positions[positionIndex];
        uint256 amount = position.amountOfTokenA > 0
            ? position.amountOfTokenA
            : position.amountOfTokenB;
        IERC20 token = position.amountOfTokenA > 0 ? tokenA : tokenB;
        token.transfer(msg.sender, amount);

        uint256 lastIndex = positions.length - 1;
        positions[positionIndex] = positions[lastIndex];
        positions.pop();

        positionOwners[positionIndex] = positionOwners[lastIndex];
        delete positionOwners[lastIndex];

        emit PositionDeleted(positionIndex);
    }

    function modifyPosition(
        uint256 positionIndex,
        Position memory position
    ) public {
        require(
            positionOwners[positionIndex] == msg.sender,
            "Not an owner of the position"
        );

        uint256 amount = position.amountOfTokenA > 0
            ? position.amountOfTokenA
            : position.amountOfTokenB;
        require(amount > 0, "Cannot open postion with 0 amount");
        require(position.priceInAmountOfToken > 0, "Price cannot be 0");
        position.isOpen = true;
        positions[positionIndex] = position;

        emit PositionModified(positionIndex);
    }

    function getPostionPrice(
        uint256 positionIndex
    ) public view returns (uint256) {
        Position memory position = positions[positionIndex];
        uint256 amount = position.amountOfTokenA > 0
            ? position.amountOfTokenA
            : position.amountOfTokenB;
        return position.priceInAmountOfToken / amount;
    }
}
