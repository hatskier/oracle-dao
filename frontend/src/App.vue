<template>
  <v-app id="inspire">
    <v-app-bar app color="white" flat>
      <v-container class="py-0 fill-height">
        <div class="logo-container">
          <img class="logo" src="/img/redstone-logo.png" />
          <h2>Oracle DAO</h2>
          <!-- <div class="powered-by-container">
            Deployed on
            <a href="https://milkomeda.com" target="_blank">Milkomeda</a>
          </div> -->
        </div>

        <v-btn
          v-for="topNavLink in topNavLinks"
          :key="topNavLink.text"
          :href="topNavLink.url"
          text
          class="mr-4"
        >
          <!-- <img class="top-nav-link-icon" :src="topNavLink.icon" /> -->
          <span class="top-nav-link-text">{{ topNavLink.text }}</span>
        </v-btn>

        <v-spacer></v-spacer>

        <v-responsive max-width="260">
          <BlockchainAddress />
        </v-responsive>
      </v-container>
    </v-app-bar>

    <v-main class="lighten-3">
      <div style="margin-top: 7px; height: 1px; background-color: #999"></div>
      <router-view />
    </v-main>
  </v-app>
</template>

<script>
import BlockchainAddress from "./components/BlockchainAddress.vue";
import daosConfig from "./common/daos-config";

export default {
  data: () => ({
    links: ["Dashboard", "Messages", "Profile", "Updates"],
    topNavLinks: [
      {
        text: "All disputes",
        url: "/",
        icon: "/img/discord-icon.png",
      },
      {
        text: "Deployed Contracts",
        url: "https://explorer-devnet-cardano-evm.c1.milkomeda.com/address/0xd75090Dd1022C1aC584851f4a3Ba06b27b7D05e0",
        icon: "/img/discord-icon.png",
      },
      {
        text: "GitHub Repo",
        url: "https://github.com/hatskier/oracle-dao",
        icon: "/img/github-icon.png",
      },
    ],
    daoList: Object.entries(daosConfig).map(([id, name]) => ({ name, id })),
  }),
  components: {
    BlockchainAddress,
  },
  methods: {
    alert(msg) {
      this.$toast.open({
        message: msg,
        type: "success",
      });
    },
    goBack() {
      this.$router.push("/dao/" + this.selectedDaoId);
    },
  },
  computed: {
    selectedDaoId() {
      console.log(this.$route.params.id);
      return this.$route.params.id;
    },
    displayGoBackLink() {
      console.log(this.$router.currentRoute);
      return this.selectedDaoId && this.$router.currentRoute.name !== "dao";
    },
  },
};
</script>

<style scoped lang="scss">
.logo-container {
  height: 40px;
  display: flex;
  position: relative;
  margin-right: 0px;
  // border: 1px solid black;

  img {
    display: inline;
    height: 40px;
  }

  h2 {
    display: inline;
    position: relative;
    bottom: 1px;
    padding-left: 15px;
    padding-right: 15px;
    position: relative;
    top: 3px;
    margin-right: 150px;
    // border: 1px solid black;
  }

  .powered-by-container {
    font-size: 15px;
    position: relative;
    top: 10px;
    left: 20px;
    // bottom: -5px;
    // left: 55px;
    // width: 200px;
  }
}
.top-nav-link-icon {
  margin-right: 5px;
  height: 22px;
}
.top-nav-link-text {
  font-weight: 400;
  letter-spacing: normal !important;
  font-size: 16px;
  text-transform: capitalize !important;
}
.selected {
  font-weight: 500;
  border-top: 1.5px solid #4c8bf5;
  border-bottom: 1.5px solid #4c8bf5;
}
.back-link {
  position: absolute;
  top: 15px;
  left: 15px;
  font-size: 14px;
  transition: transform 0.3s;
  &:hover {
    transform: scale(1.1);
    cursor: pointer;
  }
}
</style>

<style lang="scss">
* {
  color: #444;
  font-family: Poppins, -apple-systemsans-serif;
}

body,
h1,
h2,
h3 {
  font-family: Poppins, -apple-systemsans-serif !important;
}

.main-view {
  position: relative;
  h2 {
    margin: auto;
    text-align: center;
    padding-top: 16px;
  }
}

.v-toast {
  font-family: Roboto, sans-serif;
}
</style>
