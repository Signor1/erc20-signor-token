import { ethers } from "hardhat";

async function main() {
  const tokenName = "Signortoken";
  const tokenSymbol = "SOT";

  const tokenContract = await ethers.deployContract("SignorToken", [
    tokenName,
    tokenSymbol,
  ]);

  await tokenContract.waitForDeployment();

  console.log(`ERC20 Signortoken deployed to ${tokenContract.target}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
