// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import './abstracts/Controlable.sol';

// The Vault contract allows for staking of tokens and calculates rewards.
contract Vault is Controlable {
  // Token to be staked in the contract.
  IERC20 public immutable token;

  // Total supply of tokens staked in the contract.
  uint public totalSupply;

  // The reward calculation function is defined by the formula: 0.002x^2 + 0.042x - 0.004.
  uint public constant THIRTY_DAYS = 30 days;
  uint public constant NINETY_DAYS = 90 days;
  uint public constant HUNDRED_EIGHTY_DAYS = 180 days;

  // Struct to keep track of each staker's information.
  struct Staking {
    uint balanceOf; // Amount of tokens staked.
    uint finishAt; // Timestamp when the staking period ends.
    uint _days; // Duration of the staking in days.
  }

  // Mapping to track supported tokens for staking.
  mapping(address => bool) private supportedToken;
  // Mapping of staker addresses to their staking information.
  mapping(address => Staking) public _staking;

  // Constructor to initialize the contract with the specified token.
  constructor(address _token) {
    token = IERC20(_token);
  }

  // Modifier to ensure that the claim function can only be called when staking period is over.
  modifier enableToClaim(address _account) {
    require(_account != address(0), 'Address 0 is not available');
    require(_min(_staking[_account].finishAt, block.timestamp) == block.timestamp, 'Time staking is not finish');
    require(_staking[_account].finishAt != 0, 'No funds staked');
    _;
  }

  // Modifier to ensure that a user can only stake if they are not already staking.
  modifier enableToStake(address _account, uint _amount) {
    require(_staking[_account].balanceOf == 0, 'User is already staking');
    require(_amount > 0, 'amount = 0');
    _;
  }

  // Function to allow users to stake tokens for one month.
  function stakingOneMonth(uint _amount) external enableToStake(msg.sender, _amount) {
    staking(_amount, THIRTY_DAYS);
  }

  // Function to allow users to stake tokens for three months.
  function stakingThreeMonth(uint _amount) external enableToStake(msg.sender, _amount) {
    staking(_amount, NINETY_DAYS);
  }

  // Function to allow users to stake tokens for six months.
  function stakingSixMonth(uint _amount) external enableToStake(msg.sender, _amount) {
    staking(_amount, HUNDRED_EIGHTY_DAYS);
  }

  // Internal function to handle the logic of staking tokens.
  function staking(uint _amount, uint _days) internal {
    token.transferFrom(msg.sender, address(this), _amount);
    _staking[msg.sender].balanceOf += _amount;
    _staking[msg.sender].finishAt = block.timestamp + _days;
    _staking[msg.sender]._days = _days;
    totalSupply += _amount;
  }

  // Function to allow users to claim their rewards after the staking period ends.
  function claimReward() external enableToClaim(msg.sender) {
    uint claim = calculateEarning(msg.sender);
    token.transferFrom(address(this), msg.sender, claim);
    _staking[msg.sender].balanceOf = 0;
    _staking[msg.sender].finishAt = 0;
    _staking[msg.sender]._days = 0;
    totalSupply -= claim;
  }

  // Helper function to convert seconds to months.
  function secToMonth(uint _amount) private pure returns (uint) {
    return _amount / 60 / 60 / 24 / 30;
  }

  // Function to calculate the earnings of a staker based on the reward function and the amount of time and tokens staked.
  function calculateEarning(address _account) private view returns (uint) {
    uint monthStacked = secToMonth(_staking[_account]._days);
    uint balanceStacked = _staking[_account].balanceOf;

    uint reward = balanceStacked * (((2 * monthStacked * monthStacked) + (42 * monthStacked) - 4) / 1000);
    return reward + balanceStacked;
  }

  // Helper function to return the minimum of two values.
  function _min(uint x, uint y) private pure returns (uint) {
    return x <= y ? x : y;
  }

  // Function to calculate the remaining duration of the staking period for a user.
  function durationLeft() public view returns (uint) {
    return _staking[msg.sender].finishAt - block.timestamp;
  }
}
