// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import './abstracts/Controlable.sol';

contract Vault is Controlable {
  IERC20 public immutable token;

  uint public totalSupply;
  uint public rewardRate;
  uint public rewardPerTokenStaked;
  uint public constant THIRTY_DAYS = 30 days;
  uint public constant NINETY_DAYS = 90 days;
  uint public constant HUNDRED_EIGHTY_DAYS = 180 days;

  mapping(address => bool) private supportedToken;
  mapping(address => uint) public balanceOf;
  mapping(address => uint) public timestamp;

  constructor(address _token) {
    token = IERC20(_token);
  }

  modifier TimeIsUp(address _account) {}

  function staking(uint _amount) external {
    require(_amount > 0, 'amount = 0');
    token.transferFrom(msg.sender, address(this), _amount);
    balanceOf[msg.sender] += _amount;
    totalSupply += _amount;
  }

  function claimReward() external {}

  function _min(uint x, uint y) private pure returns (uint) {
    return x <= y ? x : y;
  }

  function durationLeft() public view returns (uint) {}

  function updateRewardRate(uint _rewardRate) external onlyOwner {
    rewardRate = _rewardRate;
  }

  function getRewardRate() public view returns (uint) {
    return rewardRate;
  }

  function updateRewardPerTokenStaked(uint _rewardPerToken) external onlyOwner {
    rewardPerTokenStaked = _rewardPerToken;
  }

  function getRewardPerToken() public view returns (uint) {
    return rewardPerTokenStaked;
  }
}
