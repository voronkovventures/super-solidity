// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract PancakeCreateAndLiq {
    mapping(address => bool) public meowList;

    function createAndLiq(
        address daoAddress,
        address tokenForPair,
        uint256 daoAmount,
        uint256 tokenAmount
    ) public payable returns (bool success) {
        require(msg.sender == daoAddress);

        address pancakeRouter = 0x05fF2B0DB69458A0750badebc4f9e13aDd608C7F;

        if (!meowList[daoAddress]) {
            (bool bDaoApprove, ) =
                daoAddress.delegatecall(
                    abi.encodeWithSignature("approve(address,uint256)", pancakeRouter, type(uint256).max)
                );

            require(bDaoApprove);

            (bool bTokenApprove, ) =
                tokenForPair.delegatecall(
                    abi.encodeWithSignature("approve(address,uint256)", pancakeRouter, type(uint256).max)
                );

            require(bTokenApprove);

            meowList[daoAddress] = true;
        }

        (bool bAddLiquidity, ) =
            pancakeRouter.delegatecall(
                abi.encodeWithSignature(
                    "addLiquidity(address,address,uint256,uint256,uint256,uint256,address,uint256)",
                    daoAddress,
                    tokenForPair,
                    daoAmount,
                    tokenAmount,
                    (daoAmount * 9) / 10,
                    (tokenAmount * 9) / 10,
                    daoAddress,
                    block.timestamp + 10 days
                )
            );

        require(bAddLiquidity);

        return true;
    }
}
