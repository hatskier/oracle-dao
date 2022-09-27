# Oracle DAO


## 1. Project Name
OracleDAO

## 2. Team Name
Alex Suvorov

## 3. Short description of the project
TODO: add

## 4. Long description of the project
TODO: add

## 5. Tech stack used (e.g. Web3 Js, Solidity, Truffle, Ipfs)
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
TODO: add a link

8. Documentation on how to run the project

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
TODO: add a youtube link

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

TODO: add more details about the frontend

## 12. Screens / graphic materials (optional)

TODO: add screens
