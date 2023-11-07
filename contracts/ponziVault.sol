// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import './abstracts/Controlable.sol';

contract Vault is Controlable {
  IERC20 public immutable token;

  uint public totalSupply;
  uint public finishAt;
  uint public rewardRate;
  uint public rewardPerTokenStaked;
  uint public constant THIRTY_DAYS = 30 days;
  uint public constant NINETY_DAYS = 90 days;
  uint public constant HUNDRED_EIGHTY_DAYS = 180 days;

  mapping(address => bool) private supportedToken;
  mapping(address => uint) public balanceOf;

  constructor(address _token) {
    token = IERC20(_token);
  }

  function staking(uint _amount) external {}

  function claimReward() external {}

  function _min(uint x, uint y) private pure returns (uint) {
    return x <= y ? x : y;
  }

  function durationLeft() public view returns (uint) {}

  function updateRewardRate(uint _rewardRate) external onlyOwner {
    rewardRate = _rewardRate;
  }

  function getRewardRate() public view returns (uint) {}

  function updateRewardPerTokenStaked(uint _RewardPerToken) external onlyOwner {}

  function getRewardPerToken() public view returns (uint) {}
}
