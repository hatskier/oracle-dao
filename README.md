# Oracle DAO


## 1. Project Name
OracleDAO

## 2. Team Name
Alex Suvorov

## 3. Short description of the project
Oracles are a crucial piece of blockchain infrastructure. Thanks to them other web3 applications can access data that wouldn't be available on blockchain otherwise.
DAO for data providers is another step forward in the oracle development. It creates an ecosystem where reliable sources of data for oracles are rewarded, while actors trying to push untruthful information get penalized.

## 4. Long description of the project

Oracles need an efficient and self-sustainable way of getting data that are later put on blockchain. This can be achieved in several different ways like using official government sources or well-known media, however even the most honest websites are prone to mistakes and hacks. If the incorrect data are later used in DeFi protocols, this could cause a massive shake-ups on the market.

DAO for data providers will allow to create a reliable ecosystem rewarding true information while penalizing data providers who are wrong. Such a solution creates a decentralized and automated ecosystem, where everyone can take part in verification of the data. This also helps to automate the process and allows to provide oracles not only with simple price feeds but also with all kinds of off-chain world information.

The project has been built on Milkomeda which is an EVM-compatible Cardano rollup and it is connected to RedStone EVM-compatible oracle. This setup opens the project up for a fast-growing ecosystem.

## 5. Tech stack used
- Smart contracts
  - Solidity
  - Hardhat
  - Blockscout
  - Typescript
  - Typechain
  - Milkomeda
- Frontend
  - Javascript
  - Netlify
  - Vue.js
- Documentation
  - Gitbook
  - Markdown
- Data storage
  - Arweave
  - Bundlr

## 6. Payment Address (USDC on Milkomeda)
0x195bf26a67bBdA2694C5D2E4B4d21701f63977cF

## 7. The website link (if applicable)
https://unique-centaur-52f854.netlify.app/

## 8. Documentation on how to run the project

### Install dependencies
```sh
$ git clone https://github.com/hatskier/oracle-dao
$ yarn install
```

### How to deploy smart contracts on milkomeda
```sh
$ npx hardhat run scripts/deploy.js --network milkomeda
```

### Run smart contracts tests
```sh
$ yarn test
```

### Run front end app
```sh
$ cd frontend
$ yarn install
$ yarn serve
```

Documentation on Gitbook: https://milkomeda-hackathon.gitbook.io/dao-for-data-providers/

## 9. Recorded pitch
https://youtu.be/i5TY-38gIFk

## 10. Smart-contracts

### Deployed on Milkomeda DevNet
- [DAO Token (0x973cAB279B99a18D3e5F63B9680F2E28D0A5C9A9)](https://explorer-devnet-cardano-evm.c1.milkomeda.com/address/0x973cAB279B99a18D3e5F63B9680F2E28D0A5C9A9)
- [Dispute Resolution Engine (0xd75090Dd1022C1aC584851f4a3Ba06b27b7D05e0)](https://explorer-devnet-cardano-evm.c1.milkomeda.com/address/0xd75090Dd1022C1aC584851f4a3Ba06b27b7D05e0)
- [Staking Registry (0x9D98Cc66E3dB0f759971Ff5203bC58A1b76bFab4)](https://explorer-devnet-cardano-evm.c1.milkomeda.com/address/0x9D98Cc66E3dB0f759971Ff5203bC58A1b76bFab4)

Smart contracts source code is located in: [contracts/](contracts/)

Flattended contracts are placed in the [flattended-contracts/](flattended-contracts/) folder.

### To deploy smart contracts on milkomeda:
1. Prepare .env file similar to `example.env` with your private key (env. `PRIVATE_KEY=0x123...`)
2. Run the following command `npx hardhat run scripts/deploy.js --network milkomeda`

### Smart contracts tests
Testing is extremely important for smart contracts, that's why I've implemented extensive tests covering majority of use cases and edge cases.

Smart contract tests are located in the [test/](test) folder.

You can run tests using the `yarn test` command.

## 11. Frontend code (if applicable)

Front-end code is located in the [frontend/](frontend/) folder.

Frontend is accessible under: https://unique-centaur-52f854.netlify.app/

It has the following routes:

- Main route
- Route with the selected Dispute
- Route with the dispute creation

## 12. Screens / graphic materials (optional)

TODO: add screens
