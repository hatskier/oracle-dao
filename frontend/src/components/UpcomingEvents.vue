<template>
  <div class="upcoming-events">
    <h3>Upcoming events</h3>

    <div class="table-container">
      <v-data-table
        :search="search"
        :headers="headers"
        :items="events"
        :items-per-page="5"
      >
        <template v-slot:top>
          <v-text-field
            v-model="search"
            label="Search events"
            class="mx-4"
            prepend-icon="mdi-magnify"
          ></v-text-field>
        </template>
        <template v-slot:[`item.fund`]="{ item }">
          <div style="display: none">{{ item.location }}</div>
          <v-btn outlined small @click="fundEvent(item)">Fund</v-btn>
        </template>
        <template v-slot:[`item.sign-up`]="{ item }">
          <v-btn outlined small @click="signUpForEvent(item)">Sign up</v-btn>
        </template>
      </v-data-table>
    </div>
  </div>
</template>

<script>
export default {
  name: "UpcomingEvents",
  data() {
    return {
      search: "",
      headers: [
        {
          text: "Date",
          align: "start",
          value: "date",
        },
        { text: "Location", value: "location" },
        { text: "Description", value: "description" },
        { text: "Fund", value: "fund", sortable: false },
        { text: "Sign Up", value: "sign-up", sortable: false },
      ],
      events: [
        {
          date: "2022-10-15",
          location: "Berlin",
          description: "Beer with hodlers",
        },
        {
          date: "2022-10-16",
          location: "Amsterdam",
          description: "Future of NFTs",
        },
        {
          date: "2022-12-15",
          location: "Warsaw",
          description: "Blockchain for good",
        },
        {
          date: "2023-01-02",
          location: "NYC",
          description: "The biggest web3 hackathon",
        },
        {
          date: "2023-01-02",
          location: "Miami",
          description: "Let's talk about DeFi oracles",
        },
        {
          date: "2023-01-02",
          location: "London",
          description: "Creating a new era of economy",
        },
        {
          date: "2023-01-02",
          location: "Bogota",
          description: "AI and blockchain - future",
        },
        {
          date: "TBA",
          location: "Online",
          description: "RedStone oracles happy hours",
        },
      ],
    };
  },
  methods: {
    fundEvent(event) {
      this.$toast.open({ message: "Fund event: " + event.location });
    },
    signUpForEvent(event) {
      this.$toast.open({ message: "Sign up for event: " + event.location });
    },
  },
};
</script>

<style lang="scss" scoped>
h3 {
  text-align: center;
  margin-top: 30px;
}

.table-container {
  padding: 20px;
}
</style>
