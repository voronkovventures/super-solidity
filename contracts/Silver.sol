// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Silver is ERC20 {
    constructor(
        address user2,
        address user3,
        address user4
    ) ERC20("Silver", "SLV") {
        _mint(user2, 4e18);
        _mint(user3, 5e18);
        _mint(user4, 6e18);
    }
}
