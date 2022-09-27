<template>
  <div class="dao-view">
    <h2>{{ daoTitle }}</h2>

    <div class="big-buttons">
      <div
        class="big-button-container"
        v-for="bigButton in bigButtons"
        :key="bigButton.id"
      >
        <div class="big-button" @click="bigButtonClicked(bigButton.id)">
          {{ bigButton.title }}
        </div>
      </div>
    </div>

    <div class="px-10">
      <v-divider class="my-2"></v-divider>
    </div>

    <div class="upcoming-events">
      <UpcomingEvents />
    </div>
  </div>
</template>

<script>
import daosConfig from "@/common/daos-config";
import UpcomingEvents from "@/components/UpcomingEvents.vue";
export default {
  data: () => ({
    daosConfig,
    bigButtons: [
      { title: "DAO members 👥", id: "members" },
      { title: "Vote 🗳", id: "votings" },
      { title: "Propose an event 🎉", id: "propose-event" },
    ],
  }),
  computed: {
    daoId() {
      return this.$route.params.id;
    },
    daoTitle() {
      return daosConfig[this.daoId];
    },
  },
  methods: {
    bigButtonClicked(buttonId) {
      this.$router.push("/dao/" + this.daoId + "/" + buttonId);
    },
  },
  components: { UpcomingEvents },
};
</script>

<style lang="scss" scoped>
.big-buttons {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  // margin-top: 20px;
  padding: 20px;

  .big-button-container {
    // border: 1px solid black;
    padding: 10px;

    .big-button {
      border: 2px solid #4c8bf5;
      padding: 16px;
      font-size: 18px;
      text-align: center;
      border-radius: 50px;
      transition: transform 0.3s;

      &:hover {
        transform: scale(1.1);
        cursor: pointer;
      }
    }
  }
}
</style>
