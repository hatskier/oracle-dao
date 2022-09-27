<template>
  <div class="propose-event-view">
    <h2>Propose an event for {{ daoTitle }}</h2>
    <div class="propose-event-form">
      <template>
        <v-form v-model="valid">
          <v-text-field
            v-model="form.title"
            :counter="20"
            label="Title"
            required
          ></v-text-field>
          <v-text-field
            v-model="form.location"
            :counter="50"
            append-icon="mdi-map-marker"
            label="Location"
            required
          ></v-text-field>
          <v-menu
            v-model="dateMenu"
            :close-on-content-click="false"
            :nudge-right="40"
            transition="scale-transition"
            offset-y
            min-width="290px"
          >
            <template v-slot:activator="{ on, attrs }">
              <v-text-field
                v-model="form.date"
                label="Proposed date"
                append-icon="mdi-calendar"
                readonly
                v-bind="attrs"
                v-on="on"
              ></v-text-field>
            </template>
            <v-date-picker
              v-model="form.date"
              @input="dateMenu = false"
            ></v-date-picker>
          </v-menu>
          <v-select
            v-model="form.funding"
            label="Funding type"
            required
            :items="fundingSelectItems"
          >
          </v-select>
          <v-textarea
            name="textarea-description"
            rows="3"
            label="Description"
            v-model="form.description"
            hint="Please specify all required details and related links"
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
            Propose event 🎉
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
