const { expect } = require('chai');
const { ethers } = require('hardhat');

describe("Staking test", async () => {
  let staking, rewardToken, deployer, stakingAmount

  beforeEach(async () => {
    const accounts = await ethers.getSigners();
    deployer = accounts[0];
    await deployments.fixture(["all"]);
    staking = await ethers.getContract("Staking");
    rewardToken = await ethers.getContract("RewardToken");
    stakingAmount = ethers.parseEther("100000");
  })

  it("Allow user to stake", async () => {
    await rewardToken.approve(await staking.getAddress(), stakingAmount);
    await staking.stake(stakingAmount);
    const startingEarned = await staking.earned(deployer.address);
    console.log(`Earned ${startingEarned}`);
  })
})