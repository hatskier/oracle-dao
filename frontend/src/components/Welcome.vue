<template>
  <v-container>
    <v-row class="text-center">
      <v-col class="mb-4">
        <h2 class="mb-3">Disputes</h2>
        <div><a href="/create-new-dispute">Create a new dispute</a></div>
      </v-col>
    </v-row>
    <div id="disputes-container">
      <Dispute
        v-for="dispute in disputes"
        :key="dispute.id"
        :id="dispute.id"
        :dispute="dispute"
      />
    </div>
  </v-container>
</template>

<script>
import Dispute from "./Dispute.vue";

function generateDisputes() {
  return [
    {
      id: 1,
      description:
        "Data Provider with address 0x345... is accused of providing invalid data for 3 hours for Milkomeda price. It was lower than market value by 40%",
      status: "Commitment",
      statusComment: "You can commit your vote",
      statusColor: "DodgerBlue",
    },
    {
      id: 2,
      description:
        "Data Provider with address 0x789... is accused of providing invalid data for 1 hour for Ethereum price. It was lower than market value by 95%",
      status: "Commitment",
      statusComment: "You've already commited your vote",
      statusColor: "DodgerBlue",
    },
    {
      id: 3,
      description: "0xab2... is accused of not providing data for 2 days",
      status: "Revealing",
      statusComment: "You must reveal your vote",
      statusColor: "orange",
    },
    {
      id: 4,
      description: "0xfb3... is accused of not providing data for 1 day",
      status: "Revealing",
      statusComment: "You've already revealed your vote",
      statusColor: "orange",
    },
    {
      id: 5,
      description: "0xfb3... is accused of not providing data for 1 day",
      status: "Dispute settled",
      statusComment: "You can claim your reward",
      statusColor: "green",
    },
    {
      id: 6,
      description: "0xDb5... is accused of not providing data for 1 day",
      status: "Dispute settled",
      statusComment: "You've already claimed your reward",
      statusColor: "green",
    },
    {
      id: 7,
      description: "0xDb5... is accused of not providing data for 1 day",
      status: "Dispute settled",
      statusComment: "You didn't win this dispute unfortunately",
      statusColor: "red",
    },
  ];
}

export default {
  name: "Welcome",
  data() {
    return {
      disputes: generateDisputes(),
    };
  },
  components: { Dispute },
};
</script>

<style lang="scss" scoped>
.big-logo {
  margin-top: 50px;
}

.disputes-container {
  margin: auto;
  width: 800px;
}
</style>
