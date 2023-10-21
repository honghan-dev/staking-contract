const { ethers } = require("hardhat");

module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  const rewardToken = await ethers.getContract("RewardToken");
  const rewardTokenAddress = await rewardToken.getAddress();
  const stakingDeployment = await deploy("Staking", {
    from: deployer,
    args: [rewardTokenAddress, rewardTokenAddress],
    log: true,
  });
}

module.exports.tags = ["all", "staking"];