// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import './abstracts/Controlable.sol';

contract Vault is Controlable {
  IERC20 public immutable token;

  mapping(address => bool) private supportedToken;
  mapping(address => uint) public balanceOf;
  uint public totalSupply;

  constructor(address _token) {
    token = IERC20(_token);
  }

  function stacking() external {}
}
