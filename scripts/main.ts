import "@nomiclabs/hardhat-waffle";
import { ethers, waffle } from "hardhat";

import BalanceCheckerArtifact from "../artifacts/contracts/BalanceChecker.sol/BalanceChecker.json";
import GoldArtifact from "../artifacts/contracts/Gold.sol/Gold.json";
import SilverArtifact from "../artifacts/contracts/Silver.sol/Silver.json";
import PlatinumArtifact from "../artifacts/contracts/Platinum.sol/Platinum.json";

import { BalanceChecker } from "../typechain/BalanceChecker";
import { Gold } from "../typechain/Gold";
import { Silver } from "../typechain/Silver";
import { Platinum } from "../typechain/Platinum";

const { deployContract } = waffle;

async function main() {
  const signers = await ethers.getSigners();

  const user1 = await signers[0].getAddress();
  const user2 = await signers[1].getAddress();
  const user3 = await signers[2].getAddress();
  const user4 = await signers[3].getAddress();
  const user5 = await signers[4].getAddress();

  const gold = (await deployContract(signers[0], GoldArtifact, [
    user1,
    user2,
    user3,
  ])) as Gold;
  const silver = (await deployContract(signers[0], SilverArtifact, [
    user2,
    user3,
    user4,
  ])) as Silver;
  const platinum = (await deployContract(signers[0], PlatinumArtifact, [
    user3,
    user4,
    user5,
  ])) as Platinum;

  const balanceChecker = (await deployContract(
    signers[0],
    BalanceCheckerArtifact
  )) as BalanceChecker;

  const balancesRaw = await balanceChecker.balances(
    [user1, user2, user3, user4, user5],
    [gold.address, silver.address, platinum.address]
  );

  const balances = balancesRaw.map((balance) => +balance / 1e18);

  console.log("      | GLD | SLV | PLT");

  [0, 1, 2, 3, 4].forEach((i) => {
    console.log(
      `User${i + 1} | `,
      balances.slice(i * 3, i * 3 + 3).join("  |  ")
    );
  });
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
