// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

interface IERC20 {
    function balanceOf(address) external view returns (uint256);
}

contract BalanceChecker {
    receive() external payable {
        revert();
    }

    fallback() external payable {
        revert();
    }

    function balances(address[] memory users, address[] memory tokens) external view returns (uint256[] memory) {
        uint256[] memory addrBalances = new uint256[](tokens.length * users.length);

        for (uint256 i = 0; i < users.length; i++) {
            for (uint256 j; j < tokens.length; j++) {
                uint256 addrIdx = j + tokens.length * i;
                if (tokens[j] != address(0x0)) {
                    addrBalances[addrIdx] = IERC20(tokens[j]).balanceOf(users[i]);
                } else {
                    addrBalances[addrIdx] = users[i].balance;
                }
            }
        }

        return addrBalances;
    }
}
