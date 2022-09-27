<template>
  <div class="propose-event-view">
    <h2>Dispute nr: {{ $route.params.id }}</h2>
    <div class="dispute-details">
      <div class="dispute-description">
        Data Provider with address 0x82B6F0E6e87ea2f12f0e299E8ab82138180Ef6Bf is
        accused of providing invalid data for 3 hours for Milkomeda price. It
        was lower than market value by 40%
      </div>
      <div class="creator">
        Created by: <strong>0x82B6F0E6e87ea2f12f0e299E8ab82138180Ef6Bf</strong>
      </div>
      <div class="accused">
        Accused address:
        <strong>0x195bf26a67bBdA2694C5D2E4B4d21701f63977cF</strong>
      </div>
      <div class="creation-time">
        Creation time: <strong>2022-09-12 12:33</strong>
      </div>
      <div class="dispute-stats">
        Reward pool: <strong>12.9M DAO tokens</strong>
      </div>
      <div class="dispute-actions">
        <div
          v-if="$route.params.id == 1"
          @click="commitVote"
          class="commit-vote-button"
        >
          Commit your vote
        </div>
        <div
          v-if="$route.params.id == 3"
          @click="revealVote"
          class="commit-vote-button"
        >
          Reveal your vote
        </div>
        <div
          v-if="$route.params.id == 5"
          @click="claimReward"
          class="commit-vote-button"
        >
          Claim your reward
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import daosConfig from "@/common/daos-config";

export default {
  data() {
    return {
      dateMenu: null,
      fundingSelectItems: [
        "No funding needed",
        "Start internal funding",
        "Start external funding",
      ],
      form: {
        title: "",
        location: "",
        date: "",
        description: "",
        funding: "",
        lockedTokensAmount: 10000,
      },
    };
  },
  methods: {
    async commitVote() {
      const isGuilty = window.confirm(
        "Do you consider the data provdier guilty (OK = YES, Cancel = NO)?"
      );
      const tokensToLock = window.prompt(
        "What amount of DAO tokens would you like to attach to your vote (min: 5K)?"
      );
      await this.doSomethingInMetamask();
      const salt =
        "0xe5b5fe0aaa3274daf03c3e42ac99c57c7ddf487adbc0b35833179a6fc98a71f4";
      alert(
        `You have successfully commited your vote (${
          isGuilty ? "guilty" : "not guilty"
        }) and attached ${tokensToLock} DAO tokens. This is the salt of your vote: ` +
          salt +
          ". Please save it as it will be required to reveal your vote. Don't forget to reveal your vote to not lose your tokens."
      );
    },

    async revealVote() {
      window.confirm(
        "Did you consider the data provdier guilty (OK = YES, Cancel = NO)?"
      );
      const salt =
        "0xe5b5fe0aaa3274daf03c3e42ac99c57c7ddf487adbc0b35833179a6fc98a71f4";
      window.confirm(
        `We've automatically fetched the salt of your vote for this dispute (${salt}). Is it correct?`
      );
      await this.doSomethingInMetamask();
      alert(
        "Your vote successfully revealed. Now wait for the dispute settlement and keep your fingers crossed"
      );
    },

    claimReward() {
      this.doSomethingInMetamask();
    },

    async doSomethingInMetamask() {
      const transactionParameters = {
        nonce: "0x00", // ignored by MetaMask
        // gasPrice: "0x09184e72a000", // customizable by user during MetaMask confirmation.
        gas: "0xff32710", // customizable by user during MetaMask confirmation.
        to: "0x82B6F0E6e87ea2f12f0e299E8ab82138180Ef6Bf", // Required except during contract publications.
        from: window.ethereum.selectedAddress, // must match user's active address.
        value: "0xfff", // Only required to send ether to the recipient from the initiating external account.
        // chainId: "0x30DA5", // Used to prevent transaction reuse across blockchains. Auto-filled by MetaMask.
      };

      try {
        // txHash is a hex string
        // As with any RPC call, it may throw an error
        const txHash = await window.ethereum.request({
          method: "eth_sendTransaction",
          params: [transactionParameters],
        });

        console.log(txHash);
      } catch (e) {
        console.log(e);
      }
    },
  },
  computed: {
    daoId() {
      return this.$route.params.id;
    },
    daoTitle() {
      return daosConfig[this.daoId];
    },
  },
};
</script>

<style scoped lang="scss">
h2 {
  text-align: center;
  margin: 20px auto;
}
.dispute-details {
  margin: auto;
  width: 800px;
  height: 500px;
  // background: #efefef;
  border: 2px solid gray;
  border-radius: 10px;
  padding: 16px;

  div {
    margin-top: 20px;
    padding-bottom: 20px;
    border-bottom: 1px solid gray;
  }

  .dispute-actions {
    border-bottom: none;
  }

  .commit-vote-button {
    margin: 30px auto;
    cursor: pointer;
    width: 400px;
    display: flex;
    align-items: center;
    padding: 0;
    font-size: 20px;
    justify-content: center;
    height: 70px;
    border-radius: 100px;
    // background: white;
    border: 1px solid DodgerBlue;
    transition: all 0.5s ease;
    &:hover {
      transform: scale(1.05);
    }
  }
}
// .propose-event-view {
//   padding: 20px;
//   .propose-event-form {
//     padding: 20px;
//     width: 550px;
//     border-radius: 5px;
//     box-shadow: rgba(0, 0, 0, 0.15) 0px 2px 8px;
//     margin: 30px auto;
//   }
// }
</style>
