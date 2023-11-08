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

  struct Staking {
    uint balanceOf;
    uint finishAt;
    uint _days;
  }

  mapping(address => bool) private supportedToken;
  mapping(address => Staking) public _staking;

  constructor(address _token) {
    token = IERC20(_token);
  }

  modifier TimeIsUp(address _account) {
    require(_account != address(0), 'Address 0 is not available');
    if (_min(_staking[_account].finishAt, block.timestamp) == block.timestamp && _staking[_account].finishAt != 0) {
      _staking[_account].balanceOf = 0;
      _staking[_account].finishAt = 0;
      _staking[_account]._days = 0;
    }

    _;
  }

  modifier enableToStake(address _account, uint _amount) {
    require(_staking[_account].balanceOf == 0, 'User is already staking');
    require(_amount > 0, 'amount = 0');
    _;
  }

  function stakingOneMonth(uint _amount) external enableToStake(msg.sender, _amount) {
    staking(_amount, THIRTY_DAYS);
  }

  function stakingThreeMonth(uint _amount) external enableToStake(msg.sender, _amount) {
    staking(_amount, NINETY_DAYS);
  }

  function stakingSixMonth(uint _amount) external enableToStake(msg.sender, _amount) {
    staking(_amount, HUNDRED_EIGHTY_DAYS);
  }

  function staking(uint _amount, uint _days) internal {
    token.transferFrom(msg.sender, address(this), _amount);
    _staking[msg.sender].balanceOf += _amount;
    _staking[msg.sender].finishAt = block.timestamp + _days;
    _staking[msg.sender]._days = _days;
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
