// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Gold is ERC20 {
    constructor(
        address user1,
        address user2,
        address user3
    ) ERC20("Gold", "GOLD") {
        _mint(user1, 1e18);
        _mint(user2, 2e18);
        _mint(user3, 3e18);
    }
}
