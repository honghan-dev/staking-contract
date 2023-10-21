# Staking Contract with Hardhat Testing
This is a simple staking contract implemented in Solidity. Users can stake tokens, withdraw them, and claim rewards. Rewards are calculated based on a predefined annual reward rate.

## Smart Contract
The Staking.sol smart contract provides the following functionality:

### Stake: Users can lock tokens into the contract for a period of time.
Withdraw: Users can withdraw their staked tokens.
Claim Reward: Users can claim rewards based on their staked balance.
Stake and Earn: A convenience function to stake and immediately earn rewards.
Contract Deployments
Before you can run the tests, you need to deploy the smart contract to a local Ethereum network using Hardhat or a testnet/mainnet.

### Contract Interactions
Stake: Users can stake tokens by calling the stake function. They need to approve the contract to spend their tokens before staking.

Withdraw: Users can withdraw staked tokens using the withdraw function. They can only withdraw tokens they have previously staked.

Claim Reward: Users can claim their earned rewards with the claimReward function.

Stake and Earn: This function allows users to stake tokens and immediately earn rewards.
