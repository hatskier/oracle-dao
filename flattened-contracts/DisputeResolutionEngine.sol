// Sources flattened with hardhat v2.11.2 https://hardhat.org

// File @openzeppelin/contracts/token/ERC20/IERC20.sol@v4.7.3

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.6.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}


// File @openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol@v4.7.3

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.7.0) (utils/Address.sol)

pragma solidity ^0.8.1;

/**
 * @dev Collection of functions related to the address type
 */
library AddressUpgradeable {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     *
     * [IMPORTANT]
     * ====
     * You shouldn't rely on `isContract` to protect against flash loan attacks!
     *
     * Preventing calls from contracts is highly discouraged. It breaks composability, breaks support for smart wallets
     * like Gnosis Safe, and does not provide security since it can be circumvented by calling from a contract
     * constructor.
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize/address.code.length, which returns 0
        // for contracts in construction, since the code is only stored at the end
        // of the constructor execution.

        return account.code.length > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain `call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");

        (bool success, bytes memory returndata) = target.call{value: value}(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        (bool success, bytes memory returndata) = target.staticcall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Tool to verifies that a low level call was successful, and revert if it wasn't, either by bubbling the
     * revert reason using the provided one.
     *
     * _Available since v4.3._
     */
    function verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly
                /// @solidity memory-safe-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}


// File @openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol@v4.7.3

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.7.0) (proxy/utils/Initializable.sol)

pragma solidity ^0.8.2;

/**
 * @dev This is a base contract to aid in writing upgradeable contracts, or any kind of contract that will be deployed
 * behind a proxy. Since proxied contracts do not make use of a constructor, it's common to move constructor logic to an
 * external initializer function, usually called `initialize`. It then becomes necessary to protect this initializer
 * function so it can only be called once. The {initializer} modifier provided by this contract will have this effect.
 *
 * The initialization functions use a version number. Once a version number is used, it is consumed and cannot be
 * reused. This mechanism prevents re-execution of each "step" but allows the creation of new initialization steps in
 * case an upgrade adds a module that needs to be initialized.
 *
 * For example:
 *
 * [.hljs-theme-light.nopadding]
 * ```
 * contract MyToken is ERC20Upgradeable {
 *     function initialize() initializer public {
 *         __ERC20_init("MyToken", "MTK");
 *     }
 * }
 * contract MyTokenV2 is MyToken, ERC20PermitUpgradeable {
 *     function initializeV2() reinitializer(2) public {
 *         __ERC20Permit_init("MyToken");
 *     }
 * }
 * ```
 *
 * TIP: To avoid leaving the proxy in an uninitialized state, the initializer function should be called as early as
 * possible by providing the encoded function call as the `_data` argument to {ERC1967Proxy-constructor}.
 *
 * CAUTION: When used with inheritance, manual care must be taken to not invoke a parent initializer twice, or to ensure
 * that all initializers are idempotent. This is not verified automatically as constructors are by Solidity.
 *
 * [CAUTION]
 * ====
 * Avoid leaving a contract uninitialized.
 *
 * An uninitialized contract can be taken over by an attacker. This applies to both a proxy and its implementation
 * contract, which may impact the proxy. To prevent the implementation contract from being used, you should invoke
 * the {_disableInitializers} function in the constructor to automatically lock it when it is deployed:
 *
 * [.hljs-theme-light.nopadding]
 * ```
 * /// @custom:oz-upgrades-unsafe-allow constructor
 * constructor() {
 *     _disableInitializers();
 * }
 * ```
 * ====
 */
abstract contract Initializable {
    /**
     * @dev Indicates that the contract has been initialized.
     * @custom:oz-retyped-from bool
     */
    uint8 private _initialized;

    /**
     * @dev Indicates that the contract is in the process of being initialized.
     */
    bool private _initializing;

    /**
     * @dev Triggered when the contract has been initialized or reinitialized.
     */
    event Initialized(uint8 version);

    /**
     * @dev A modifier that defines a protected initializer function that can be invoked at most once. In its scope,
     * `onlyInitializing` functions can be used to initialize parent contracts. Equivalent to `reinitializer(1)`.
     */
    modifier initializer() {
        bool isTopLevelCall = !_initializing;
        require(
            (isTopLevelCall && _initialized < 1) || (!AddressUpgradeable.isContract(address(this)) && _initialized == 1),
            "Initializable: contract is already initialized"
        );
        _initialized = 1;
        if (isTopLevelCall) {
            _initializing = true;
        }
        _;
        if (isTopLevelCall) {
            _initializing = false;
            emit Initialized(1);
        }
    }

    /**
     * @dev A modifier that defines a protected reinitializer function that can be invoked at most once, and only if the
     * contract hasn't been initialized to a greater version before. In its scope, `onlyInitializing` functions can be
     * used to initialize parent contracts.
     *
     * `initializer` is equivalent to `reinitializer(1)`, so a reinitializer may be used after the original
     * initialization step. This is essential to configure modules that are added through upgrades and that require
     * initialization.
     *
     * Note that versions can jump in increments greater than 1; this implies that if multiple reinitializers coexist in
     * a contract, executing them in the right order is up to the developer or operator.
     */
    modifier reinitializer(uint8 version) {
        require(!_initializing && _initialized < version, "Initializable: contract is already initialized");
        _initialized = version;
        _initializing = true;
        _;
        _initializing = false;
        emit Initialized(version);
    }

    /**
     * @dev Modifier to protect an initialization function so that it can only be invoked by functions with the
     * {initializer} and {reinitializer} modifiers, directly or indirectly.
     */
    modifier onlyInitializing() {
        require(_initializing, "Initializable: contract is not initializing");
        _;
    }

    /**
     * @dev Locks the contract, preventing any future reinitialization. This cannot be part of an initializer call.
     * Calling this in the constructor of a contract will prevent that contract from being initialized or reinitialized
     * to any version. It is recommended to use this to lock implementation contracts that are designed to be called
     * through proxies.
     */
    function _disableInitializers() internal virtual {
        require(!_initializing, "Initializable: contract is initializing");
        if (_initialized < type(uint8).max) {
            _initialized = type(uint8).max;
            emit Initialized(type(uint8).max);
        }
    }
}


// File @openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol@v4.7.3

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (utils/Context.sol)

pragma solidity ^0.8.0;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract ContextUpgradeable is Initializable {
    function __Context_init() internal onlyInitializing {
    }

    function __Context_init_unchained() internal onlyInitializing {
    }
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }

    /**
     * @dev This empty reserved space is put in place to allow future versions to add new
     * variables without shifting down storage in the inheritance chain.
     * See https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps
     */
    uint256[50] private __gap;
}


// File @openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol@v4.7.3

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.7.0) (access/Ownable.sol)

pragma solidity ^0.8.0;


/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract OwnableUpgradeable is Initializable, ContextUpgradeable {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    function __Ownable_init() internal onlyInitializing {
        __Ownable_init_unchained();
    }

    function __Ownable_init_unchained() internal onlyInitializing {
        _transferOwnership(_msgSender());
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if the sender is not the owner.
     */
    function _checkOwner() internal view virtual {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }

    /**
     * @dev This empty reserved space is put in place to allow future versions to add new
     * variables without shifting down storage in the inheritance chain.
     * See https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps
     */
    uint256[49] private __gap;
}


// File contracts/StakingRegistry.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;


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


// File contracts/DisputeResolutionEngine.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;



contract DisputeResolutionEngine is OwnableUpgradeable {
  uint256 constant MIN_LOCK_AMOUNT_FOR_DISPUTE_CREATION = 10_000 * 10**18;
  uint256 constant MIN_LOCK_AMOUNT_FOR_VOTING = 5_000 * 10**18;
  uint256 constant PENALTY_AMOUNT = 2_000 * 10**18;
  uint256 constant COMMIT_PERIOD_SECONDS = 4 * 24 * 3600; // 4 days
  uint256 constant REVEAL_PERIOD_SECONDS = 3 * 24 * 3600; // 3 days

  // Note, that lock period for unstaking should be greater
  // than the maximum voting period. Otherwise a guilty provider is able
  // to unstake tokens before the dispute settlement
  uint256 constant LOCK_PERIOD_FOR_UNSTAKING_SECONDS = 30 * 24 * 3600; // 30 days

  enum DisputeVerdict {
    Unknown,
    Guilty,
    NotGuilty
  }

  struct Vote {
    uint256 lockedTokensAmount;
    bytes32 commitHash;
    bool revealedVote;
    bool votedForGuilty;
    bool claimedReward;
  }

  struct Dispute {
    address creatorAddress;
    address accusedAddress;
    uint256 creationTimestampSeconds;
    string arweaveUrlWithDisputeDetails;
    uint256 revealedForGuiltyAmount;
    uint256 revealedForNotGuiltyAmount;
    uint256 rewardPoolTokensAmount;
    DisputeVerdict verdict;
  }

  IERC20 private _DaoToken;
  Dispute[] private _disputes;
  mapping(uint256 => mapping(address => Vote)) private _votes; // disputeId => (address => Vote)
  StakingRegistry private _stakingRegistry;

  constructor(address DaoTokenAddress) {
    _stakingRegistry = new StakingRegistry(
      DaoTokenAddress,
      address(this),
      LOCK_PERIOD_FOR_UNSTAKING_SECONDS
    );
    _DaoToken = IERC20(DaoTokenAddress);
  }

  function createDispute(
    address accusedAddress,
    string calldata arweaveUrlWithDisputeDetails,
    uint256 lockedTokensAmount
  ) external {
    require(
      lockedTokensAmount >= MIN_LOCK_AMOUNT_FOR_DISPUTE_CREATION,
      "Insufficient locked tokens amount for dispute creation"
    );

    Dispute storage newDispute = _disputes.push();
    newDispute.creatorAddress = msg.sender;
    newDispute.accusedAddress = accusedAddress;
    newDispute.creationTimestampSeconds = block.timestamp;
    newDispute.arweaveUrlWithDisputeDetails = arweaveUrlWithDisputeDetails;
    newDispute.verdict = DisputeVerdict.Unknown;

    // The code below commented to save gas, because these fields
    // will be set to zero anyway. But we left the commented code
    // to improve the code readability :)
    // newDispute.revealedForGuiltyAmount = 0;
    // newDispute.revealedForNotGuiltyAmount = 0;
    // newDispute.rewardPoolTokensAmount = 0;

    // Dispute creator automatically votes for guilty and their vote is
    // automatically revealed. That's why we pass a zero commit hash here
    uint256 createdDisputeId = _disputes.length - 1;
    _lockTokensAndCreateVote(createdDisputeId, bytes32(0), lockedTokensAmount);
  }

  function commitVote(
    uint256 disputeId,
    uint256 lockedTokensAmount,
    bytes32 commitHash
  ) external {
    Dispute storage dispute = _disputes[disputeId];

    require(
      lockedTokensAmount >= MIN_LOCK_AMOUNT_FOR_VOTING,
      "Insufficient locked tokens amount for voting"
    );
    require(
      block.timestamp <
        dispute.creationTimestampSeconds + COMMIT_PERIOD_SECONDS,
      "Commit period ended"
    );

    _lockTokensAndCreateVote(disputeId, commitHash, lockedTokensAmount);
  }

  function revealVote(
    uint256 disputeId,
    bytes32 salt,
    bool votedForGuilty
  ) external {
    Dispute storage dispute = _disputes[disputeId];
    Vote storage vote = _votes[disputeId][msg.sender];

    // Checking if the user can reveal their vote
    require(
      block.timestamp <
        dispute.creationTimestampSeconds +
          COMMIT_PERIOD_SECONDS +
          REVEAL_PERIOD_SECONDS,
      "Reveal period ended"
    );
    require(
      vote.lockedTokensAmount > 0,
      "Cannot find the commited vote to reveal"
    );

    // Verifying commit hash against the revealed vote
    bytes32 expectedCommitHash = calculateHashForVote(
      disputeId,
      salt,
      votedForGuilty
    );
    require(
      expectedCommitHash == vote.commitHash,
      "Commited hash doesn't match with the revealed vote"
    );

    // Saving user vote details
    vote.revealedVote = true;
    vote.votedForGuilty = votedForGuilty;
    if (votedForGuilty) {
      dispute.revealedForGuiltyAmount += vote.lockedTokensAmount;
    } else {
      dispute.revealedForNotGuiltyAmount += vote.lockedTokensAmount;
    }
  }

  // Anyone can settle a dispute that has not beed settled before
  // when its reveal period ends. Settlement period is not limited in time
  function settleDispute(uint256 disputeId) external {
    Dispute storage dispute = _disputes[disputeId];

    // Checking if the dispute can be settled
    require(
      dispute.verdict == DisputeVerdict.Unknown,
      "Dispute has already been settled"
    );
    require(
      block.timestamp >
        dispute.creationTimestampSeconds +
          COMMIT_PERIOD_SECONDS +
          REVEAL_PERIOD_SECONDS,
      "Settlement period hasn't started yet"
    );

    // Setting verdict for the dispute
    if (dispute.revealedForGuiltyAmount > dispute.revealedForNotGuiltyAmount) {
      dispute.verdict = DisputeVerdict.Guilty;

      // Safely slashing stake from the guilty provider
      // And adding it to the dispute reward pool
      uint256 availableStakedBalance = _stakingRegistry.getStakedBalance(
        dispute.accusedAddress
      );
      if (availableStakedBalance >= PENALTY_AMOUNT) {
        _stakingRegistry.slashStake(dispute.accusedAddress, PENALTY_AMOUNT);
        dispute.rewardPoolTokensAmount += PENALTY_AMOUNT;
      }
    } else {
      dispute.verdict = DisputeVerdict.NotGuilty;
    }
  }

  // If a user has won a dispute, they need to manually claim reward
  function claimRewardForDispute(uint256 disputeId) external {
    uint256 rewardForUser = calculatePendingRewardForUser(
      disputeId,
      msg.sender
    );
    _votes[disputeId][msg.sender].claimedReward = true;
    _DaoToken.transfer(msg.sender, rewardForUser);
  }

  function calculatePendingRewardForUser(uint256 disputeId, address userAddress)
    public
    view
    returns (uint256)
  {
    Dispute storage dispute = _disputes[disputeId];
    Vote storage userVote = _votes[disputeId][userAddress];

    // Checking if the user is elgigble for the reward
    require(
      dispute.verdict != DisputeVerdict.Unknown,
      "Dispute has not been sttled yet"
    );
    require(userVote.revealedVote, "User didn't reveal vote");
    require(
      userVote.votedForGuilty || dispute.verdict == DisputeVerdict.NotGuilty,
      "User didn't win the dispute"
    );
    require(
      !userVote.claimedReward,
      "User already claimed reward for this dispute"
    );

    // Calculaing reward amount for the user
    uint256 totalLockedTokenOfAllWinners = _max(
      dispute.revealedForGuiltyAmount,
      dispute.revealedForNotGuiltyAmount
    );
    uint256 userRewardAmount = (dispute.rewardPoolTokensAmount *
      userVote.lockedTokensAmount) / totalLockedTokenOfAllWinners;

    return userRewardAmount;
  }

  // We strongly recommend voters to calculate salt off-chain using the
  // pseudo-algorithm below. It is not required by this smart contract,
  // but will allow users to unambiguously recover it for vote revealing
  // Note: `signMessage` function must produce deterministic signatures
  // const seedMessage = toUtf8Bytes(disputeId + "REDSTONE_DISPUTE_SALT");
  // const signature = await signer.signMessage(seedMessage);
  // const salt = keccak256(signature);
  // return salt;
  function calculateHashForVote(
    uint256 disputeId,
    bytes32 salt,
    bool votedForGuilty
  ) public pure returns (bytes32) {
    return keccak256(abi.encodePacked(disputeId, salt, votedForGuilty));
  }

  function getDisputesCount() public view returns (uint256) {
    return _disputes.length;
  }

  function getDisputeDetails(uint256 disputeId)
    public
    view
    returns (Dispute memory)
  {
    return _disputes[disputeId];
  }

  function getUserVote(address user, uint256 disputeId)
    public
    view
    returns (Vote memory)
  {
    return _votes[disputeId][user];
  }

  function getStakingRegistryAddress() public view returns (address) {
    return address(_stakingRegistry);
  }

  function _lockTokensAndCreateVote(
    uint256 disputeId,
    bytes32 commitHash,
    uint256 lockedTokensAmount
  ) private {
    Dispute storage dispute = _disputes[disputeId];
    require(
      _votes[disputeId][msg.sender].lockedTokensAmount == 0,
      "Already locked some tokens for this dispute"
    );

    // Locking tokens on this contract. It will fail if user hasn't approved
    // tokens spending by this contract
    _DaoToken.transferFrom(msg.sender, address(this), lockedTokensAmount);

    // Saving a new vote
    _votes[disputeId][msg.sender] = Vote({
      lockedTokensAmount: lockedTokensAmount,
      commitHash: commitHash,
      revealedVote: false,
      votedForGuilty: false,
      claimedReward: false
    });

    // Automatically reveal the vote created by the dispute creator
    if (dispute.creatorAddress == msg.sender) {
      Vote storage createdVote = _votes[disputeId][msg.sender];
      createdVote.revealedVote = true;
      createdVote.votedForGuilty = true;
      dispute.revealedForGuiltyAmount += lockedTokensAmount;
    }

    // Increasing reawrd pool for the dispute
    dispute.rewardPoolTokensAmount += lockedTokensAmount;
  }

  // Helpful function to get the maximum value of two numbers
  function _max(uint256 a, uint256 b) internal pure returns (uint256) {
    return a >= b ? a : b;
  }
}
