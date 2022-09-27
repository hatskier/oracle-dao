import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { expect } from "chai";
import { ethers } from "hardhat";
import { RedstoneToken, StakingRegistry } from "../typechain-types";

describe("Staking registry", () => {
  let token: RedstoneToken,
    staking: StakingRegistry,
    signers: SignerWithAddress[],
    authorisedStakeSlasher: SignerWithAddress;

  const deployContracts = async (
    lockPeriodForUnstakingInSeconds: number = 100000
  ) => {
    signers = await ethers.getSigners();
    authorisedStakeSlasher = signers[3];

    // Deploy token contract
    const TokenContractFactory = await ethers.getContractFactory(
      "RedstoneToken"
    );
    token = await TokenContractFactory.deploy(1000);
    await token.deployed();

    // Deploy staking contract
    const StakingRegistryFactory = await ethers.getContractFactory(
      "StakingRegistry"
    );
    staking = await StakingRegistryFactory.deploy(
      token.address,
      await authorisedStakeSlasher.getAddress(),
      lockPeriodForUnstakingInSeconds
    );
    await staking.deployed();
  };

  const stakeTokens = async (stakingAmount: number) => {
    const approveTx = await token.approve(staking.address, stakingAmount);
    await approveTx.wait();

    const stakingTx = await staking.stake(stakingAmount);
    await stakingTx.wait();
  };

  it("Should properly stake tokens", async () => {
    await deployContracts();
    await stakeTokens(100);
    const stakedBalance = await staking.getStakedBalance(signers[0].address);
    expect(stakedBalance.toNumber()).to.eql(100);
    const contractBalance = await token.balanceOf(staking.address);
    expect(contractBalance.toNumber()).to.eql(100);
  });

  it("Should properly unstake", async () => {
    const lockPeriodForUnstakingInSeconds = 0;
    await deployContracts(lockPeriodForUnstakingInSeconds);
    await stakeTokens(100);

    // Request unstake
    const reqTx = await staking.requestUnstake(30);
    await reqTx.wait();
    const stakingDetails = await staking.getUserStakingDetails(
      signers[0].address
    );
    expect(stakingDetails.pendingAmountToUnstake.toNumber()).to.eql(30);

    // Complete unstake
    const unstakeTx = await staking.completeUnstake();
    await unstakeTx.wait();
    const stakedBalance = await staking.getStakedBalance(signers[0].address);
    expect(stakedBalance.toNumber()).to.eql(70);
    const contractBalance = await token.balanceOf(staking.address);
    expect(contractBalance.toNumber()).to.eql(70);
    const userBalance = await token.balanceOf(signers[0].address);
    expect(userBalance.toNumber()).to.eql(930);
  });

  it("Should not request unstake for more than staked", async () => {
    await deployContracts();
    await stakeTokens(100);

    await expect(staking.requestUnstake(101)).to.be.revertedWith(
      "Can not request to unstake more than staked"
    );
  });

  it("Should not unstake if not requested", async () => {
    const lockPeriodForUnstakingInSeconds = 0;
    await deployContracts(lockPeriodForUnstakingInSeconds);
    await stakeTokens(100);

    await expect(staking.completeUnstake()).to.be.revertedWith(
      "User hasn't requested unstake before"
    );
  });

  it("Should not unstake if not enough time passed", async () => {
    const lockPeriodForUnstakingInSeconds = 10000;
    await deployContracts(lockPeriodForUnstakingInSeconds);
    await stakeTokens(100);

    const reqTx = await staking.requestUnstake(30);
    await reqTx.wait();

    await expect(staking.completeUnstake()).to.be.revertedWith(
      "Unstaking is not opened yet"
    );
  });

  it("Should properly slash stake", async () => {
    await deployContracts();
    await stakeTokens(100);

    const tx = await staking
      .connect(authorisedStakeSlasher)
      .slashStake(signers[0].address, 99);
    await tx.wait();

    const userStakedBalance = await staking.getStakedBalance(
      signers[0].address
    );
    const slasherBalance = await token.balanceOf(
      authorisedStakeSlasher.address
    );
    expect(userStakedBalance.toNumber()).to.eql(1);
    expect(slasherBalance.toNumber()).to.eql(99);
  });

  it("Should not slash stake by unauthorised address", async () => {
    await deployContracts();
    await stakeTokens(100);

    await expect(
      staking.connect(signers[1]).slashStake(signers[0].address, 99)
    ).to.be.revertedWith("Tx sender is not authorised to slash stakes");
  });
});
