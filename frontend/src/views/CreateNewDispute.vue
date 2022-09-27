<template>
  <div class="propose-event-view">
    <h2>Create a new dispute</h2>
    <div class="propose-event-form">
      <template>
        <v-form v-model="valid">
          <v-text-field
            v-model="form.title"
            :counter="50"
            label="Accused data provider address"
            required
          ></v-text-field>
          <v-text-field
            v-model="form.lockedTokensAmount"
            :counter="50"
            type="number"
            label="Locked tokens amount"
            required
          ></v-text-field>
          <v-textarea
            name="textarea-description"
            rows="3"
            label="Dispute details"
            v-model="form.description"
            hint="Please specify all required details, they will be loaded to bundlr"
          ></v-textarea>
          <v-btn
            class="mt-4 mb-2"
            outlined
            rounded
            large
            block
            type="submit"
            color="#4c8bf5"
          >
            Create a new dispute
          </v-btn>
        </v-form>
      </template>
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
}
.propose-event-view {
  padding: 20px;
  .propose-event-form {
    padding: 20px;
    width: 550px;
    border-radius: 5px;
    box-shadow: rgba(0, 0, 0, 0.15) 0px 2px 8px;
    margin: 30px auto;
  }
}
</style>
