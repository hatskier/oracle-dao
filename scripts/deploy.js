// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

const TOTAL_SUPPLY = 1_000_000_000;

const toBigNum = (amount) => {
  return hre.ethers.utils.parseEther(String(amount));
};

async function main() {
  // Deploy token contract
  const TokenContractFactory = await ethers.getContractFactory("DaoToken");
  token = await TokenContractFactory.deploy(toBigNum(TOTAL_SUPPLY));
  await token.deployed();

  // Deploy the dispute resolution engine contract
  const DisputeResolutionEngineFactory = await ethers.getContractFactory(
    "DisputeResolutionEngine"
  );
  disputeResolutionEngine = await DisputeResolutionEngineFactory.deploy(
    token.address
  );

  // Attachig staking registry (which was created by dispute resolution engine)
  const stakingRegistryAddress =
    await disputeResolutionEngine.getStakingRegistryAddress();
  const StakingRegistryFactory = await ethers.getContractFactory(
    "StakingRegistry"
  );
  staking = StakingRegistryFactory.attach(stakingRegistryAddress);

  console.log("Contracts deployed on Milkomeda :)");
  console.log(`DAO token: ${token.address}`);
  console.log(`Dispute Resolution Engine: ${disputeResolutionEngine.address}`);
  console.log(`Staking registry: ${stakingRegistryAddress}`);



  // TODO: remove the commented code
  // const requiredVotesCountForSettlement = 3;
  // const EventDAO = await hre.ethers.getContractFactory("EventDAO");
  // const eventDAOContract = await EventDAO.deploy(
  //   "Test DAO",
  //   requiredVotesCountForSettlement
  // );

  // await eventDAOContract.deployed();

  // console.log(`Deployed DAO contract address: ${eventDAOContract.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
