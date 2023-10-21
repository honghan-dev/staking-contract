// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Staking {
    // The ERC-20 token that will be staked
    IERC20 public s_stakingToken;
	IERC20 public s_rewardToken;
    // Reward rate (per second)
    uint256 public constant REWARD_RATE = 100;
    // Total supply of staked tokens
    uint256 public s_totalSupply;
    // Reward per token stored
    uint256 public s_rewardPerTokenStored;
    // Last time the contract was updated
    uint256 public s_lastUpdateTime;
	// Reward Token

    // Mapping to track rewards per token paid to users
    mapping(address => uint256) public s_userRewardPerTokenPaid;
    // Mapping to track rewards for users
    mapping(address => uint256) public s_rewards;
    // Mapping to track staked balances of users
    mapping(address => uint256) public s_balances;

    constructor(address stakingToken, address rewardToken) {
        // Initialize the staking contract with a specific ERC-20 token
        s_stakingToken = IERC20(stakingToken);
		s_rewardToken = IERC20(rewardToken);
    }

    // Modifier to update user rewards
    modifier updateReward(address account) {
        s_rewardPerTokenStored = rewardPerToken();
        s_lastUpdateTime = block.timestamp;
        s_rewards[account] = earned(account);
		s_userRewardPerTokenPaid[account] = s_rewardPerTokenStored;
        _;
    }

	modifier moreThanZero(uint256 amount) {
		require(amount > 0, "Amount can't be zero");
		_;
	}

    // Calculate rewards earned by a user
    function earned(address account) public view returns (uint256) {
        uint256 currentBalance = s_balances[account];
        uint256 amountPaid = s_userRewardPerTokenPaid[account];
        uint256 currentRewardPerToken = rewardPerToken();
        uint256 pastRewards = s_rewards[account];
        uint256 rewardEarned = ((currentBalance * (currentRewardPerToken - amountPaid)) / 1e18) + pastRewards;
        return rewardEarned;
    }

    // Calculate the reward per token
    function rewardPerToken() public view returns (uint256) {
        if (s_totalSupply == 0) {
            return s_rewardPerTokenStored;
        }
        return
            s_rewardPerTokenStored +
            (((block.timestamp - s_lastUpdateTime) * REWARD_RATE * 1e18) / s_totalSupply);
    }

    // Stake tokens into the contract
    function stake(uint256 amount) external updateReward(msg.sender) moreThanZero(amount) {
        s_balances[msg.sender] += amount;
        s_totalSupply += amount;

        // Transfer tokens from the user to the contract
        bool success = s_stakingToken.transferFrom(msg.sender, address(this), amount);
        require(success, "Stake failed");
    }

    // Withdraw staked tokens from the contract
    function withdraw(uint256 amount) external updateReward(msg.sender) moreThanZero(amount) moreThanZero(amount) {
        s_balances[msg.sender] -= amount;
        s_totalSupply -= amount;

        // Transfer tokens from the contract to the user
        bool success = s_stakingToken.transfer(msg.sender, amount);
        require(success, "Withdrawal failed");
    }

    // Function to claim earned rewards (not implemented yet)
    function claimReward() external updateReward(msg.sender) {
		uint256 reward = s_rewards[msg.sender];
		bool success = s_rewardToken.transfer(msg.sender, reward);
		require(success, 'Transfer failed');
    }
}
