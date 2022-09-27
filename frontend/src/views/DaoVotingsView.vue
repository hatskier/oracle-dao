<template>
  <div class="dao-members-view">
    <h2>Votings for {{ daoTitle }}</h2>
    <div class="table-container">
      <v-data-table
        :headers="headers"
        :items="daoVotings"
        outlined
        disable-pagination
        hide-default-footer
      >
        <template v-slot:[`item.vote`]="{ item }">
          <div style="display: none">{{ item }}</div>
          <v-btn
            @click="vote(item, false)"
            fab
            outlined
            dark
            x-small
            color="red"
          >
            <v-icon dark> mdi-close </v-icon>
          </v-btn>
          <v-btn
            @click="vote(item, true)"
            class="ml-2"
            fab
            outlined
            dark
            x-small
            color="green"
          >
            <v-icon dark> mdi-check </v-icon>
          </v-btn>
        </template>
      </v-data-table>
    </div>
  </div>
</template>

<script>
import daoVotings from "@/common/dao-votings";
import daosConfig from "@/common/daos-config";

export default {
  data() {
    return {
      daoVotings,
      headers: [
        { text: "Description", value: "description", align: "left" },
        {
          text: "Proposed location",
          align: "center",
          value: "location",
        },
        {
          text: "Proposed date",
          align: "center",
          value: "date",
        },
        {
          text: "Your vote",
          value: "vote",
          align: "center",
        },
      ],
    };
  },
  methods: {
    vote(votingDetails, approve) {
      this.$toast.open({
        message:
          `Vote ${approve ? "for" : "against"}: ` + votingDetails.location,
      });
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
.table-container {
  width: 700px;
  margin: 30px auto;
}
</style>
