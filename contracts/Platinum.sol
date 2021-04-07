// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Platinum is ERC20 {
    constructor(
        address user3,
        address user4,
        address user5
    ) ERC20("Platinum", "PLT") {
        _mint(user3, 7e18);
        _mint(user4, 8e18);
        _mint(user5, 9e18);
    }
}
