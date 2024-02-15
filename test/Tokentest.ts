import {
  time,
  loadFixture,
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("SignorToken Test", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deployTokenContract() {
    const tokenName = "Signortoken";
    const tokenSymbol = "SOT";
    // Contracts are deployed using the first signer/account by default
    const [owner, otherAccount] = await ethers.getSigners();

    const TokenContract = await ethers.getContractFactory("SignorToken");
    const tokenContract = await TokenContract.deploy(tokenName, tokenSymbol);

    return { tokenContract, tokenName, tokenSymbol, owner, otherAccount };
  }

  describe("Deployment", function () {
    it("Should set if deployed", async function () {
      const { tokenContract } = await loadFixture(deployTokenContract);

      expect(tokenContract).to.exist;
    });
  });
});
