// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract StakingRegistry is OwnableUpgradeable {
  struct UserStakingDetails {
    uint256 stakedAmount;
    uint256 pendingAmountToUnstake;
    uint256 unstakeOpeningTimestampSeconds;
  }

  event UnstakeRequested(address user, UserStakingDetails stakingDetails);
  event UnstakeCompleted(address user, UserStakingDetails stakingDetails);

  uint256 private _lockPeriodForUnstakingInSeconds;
  IERC20 private _stakingToken;
  address private _authorisedStakeSlasher;
  mapping(address => UserStakingDetails) private _stakingDetailsForUsers;

  constructor(
    address stakingTokenAddress,
    address authorisedStakeSlasher,
    uint256 lockPeriodForUnstakingInSeconds
  ) {
    _stakingToken = IERC20(stakingTokenAddress);
    _authorisedStakeSlasher = authorisedStakeSlasher;
    _lockPeriodForUnstakingInSeconds = lockPeriodForUnstakingInSeconds;
  }

  // Before calling this function tx sender should allow spending
  // the staking amount by this contract
  function stake(uint256 stakingAmount) external {
    _stakingToken.transferFrom(msg.sender, address(this), stakingAmount);
    _stakingDetailsForUsers[msg.sender].stakedAmount += stakingAmount;
  }

  function requestUnstake(uint256 amountToUnstake) external {
    UserStakingDetails storage userStakingDetails = _stakingDetailsForUsers[msg.sender];
    require(amountToUnstake > 0, "Amount to unstake must be a positive number");
    require(
      userStakingDetails.stakedAmount >= amountToUnstake,
      "Can not request to unstake more than staked"
    );

    userStakingDetails.pendingAmountToUnstake = amountToUnstake;
    userStakingDetails.unstakeOpeningTimestampSeconds =
      block.timestamp +
      _lockPeriodForUnstakingInSeconds;

    emit UnstakeRequested(msg.sender, userStakingDetails);
  }

  function completeUnstake() external {
    UserStakingDetails storage userStakingDetails = _stakingDetailsForUsers[msg.sender];
    uint256 amountToUnstake = userStakingDetails.pendingAmountToUnstake;

    require(
      block.timestamp > userStakingDetails.unstakeOpeningTimestampSeconds,
      "Unstaking is not opened yet"
    );
    require(amountToUnstake > 0, "User hasn't requested unstake before");
    require(
      amountToUnstake <= userStakingDetails.stakedAmount,
      "Can not unstake more than staked"
    );

    userStakingDetails.stakedAmount -= amountToUnstake;
    _stakingToken.transfer(msg.sender, amountToUnstake);
    userStakingDetails.pendingAmountToUnstake = 0;

    emit UnstakeCompleted(msg.sender, userStakingDetails);
  }

  function getUserStakingDetails(address addr) public view returns (UserStakingDetails memory) {
    return _stakingDetailsForUsers[addr];
  }

  function getStakedBalance(address addr) public view returns (uint256) {
    return _stakingDetailsForUsers[addr].stakedAmount;
  }

  function slashStake(address slashedAddress, uint256 slashedAmount) public {
    UserStakingDetails storage userStakingDetails = _stakingDetailsForUsers[slashedAddress];

    require(msg.sender == _authorisedStakeSlasher, "Tx sender is not authorised to slash stakes");
    require(
      userStakingDetails.stakedAmount >= slashedAmount,
      "Staking balance is lower than the requested slashed amount"
    );

    userStakingDetails.stakedAmount -= slashedAmount;
    _stakingToken.transfer(msg.sender, slashedAmount);
  }
}
