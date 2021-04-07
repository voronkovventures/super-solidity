// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

interface Dac {
    function getAllTeammates() external view returns (address[] memory);

    function balanceOf(address account) external view returns (uint256);

    function totalSupply() external view returns (uint256);
}

contract Dividends {
    function distributeTokens(
        address dacAddress,
        address[] memory tokens,
        uint256[] memory amounts
    ) external returns (bool success) {
        require(msg.sender == dacAddress);
        require(tokens.length == amounts.length);

        Dac dac = Dac(dacAddress);

        address[] memory users = dac.getAllTeammates();

        for (uint256 i = 0; i < tokens.length; i++) {
            for (uint256 j = 0; j < users.length; j++) {
                if (tokens[i] != dacAddress) {
                    (bool b, ) =
                        tokens[i].delegatecall(
                            abi.encodeWithSignature(
                                "transfer(address,uint256)",
                                users[j],
                                (amounts[i] * dac.balanceOf(users[j])) / (dac.totalSupply() - dac.balanceOf(dacAddress))
                            )
                        );
                    require(b);
                }
            }
        }

        return true;
    }

    function distributeCoins(address dacAddress) external payable returns (bool success) {
        require(msg.sender == dacAddress);

        Dac dac = Dac(dacAddress);

        address[] memory users = dac.getAllTeammates();

        for (uint256 i = 0; i < users.length; i++) {
            payable(users[i]).transfer(
                (msg.value * dac.balanceOf(users[i])) / (dac.totalSupply() - dac.balanceOf(dacAddress))
            );
        }

        return true;
    }
}
