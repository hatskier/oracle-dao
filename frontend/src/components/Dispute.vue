<template>
  <div @click="goToDispute" class="dispute">
    <div class="dispute-id">Dispute {{ id }}</div>
    <div class="description">{{ dispute.description }}</div>
    <div class="status">
      <div :style="{ color: dispute.statusColor }">
        Status: {{ dispute.status }}
      </div>
      <div class="status-comment">
        {{ dispute.statusComment }}
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ["id", "dispute"],
  methods: {
    goToDispute() {
      window.location.href = "/dispute/" + this.id;
    },
  },
};
</script>

<style scoped lang="scss">
.dispute {
  width: 800px;
  height: 80px;
  border-radius: 10px;
  background: #ededed;
  margin: 10px auto;
  padding: 10px;
  cursor: pointer;
  transition: all 0.5s ease;
  font-size: 14px;
  display: grid;
  gap: 18px;
  grid-template-columns: 150px auto 150px;

  .dispute-id {
    // display: flex;
    // align-items: center;
    padding-top: 7px;
    padding-left: 7px;
    font-weight: 500;
  }

  .description {
    font-size: 12px;
  }

  .status {
    font-size: 12px;
    color: green;

    .status-comment {
      font-size: 8px;
    }
  }

  &:hover {
    transform: scale(1.05);
  }
}
</style>
