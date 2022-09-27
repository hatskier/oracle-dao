<template>
  <div class="dao-members-view">
    <h2>Members of {{ daoTitle }}</h2>
    <div class="table-container">
      <v-data-table
        :search="search"
        :headers="headers"
        :items="daoMembers"
        outlined
        :items-per-page="10"
        class=""
      >
        <template v-slot:[`item.avatar`]="{ item }">
          <v-avatar size="36px">
            <img :src="item.img" />
          </v-avatar>
        </template>
      </v-data-table>
    </div>
  </div>
</template>

<script>
import daoMembers from "@/common/dao-members";
import daosConfig from "@/common/daos-config";

export default {
  data() {
    return {
      daoMembers,
      headers: [
        {
          text: "Avatar",
          align: "center",
          value: "avatar",
        },
        { text: "Nickname", value: "name", align: "center" },
        { text: "Address", value: "address", align: "center" },
        {
          text: "Token balance",
          value: "balance",
          align: "center",
        },
      ],
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
.table-container {
  width: 700px;
  margin: 30px auto;
}
</style>
