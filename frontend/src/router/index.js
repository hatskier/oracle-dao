import Vue from "vue";
import VueRouter from "vue-router";
import HomeView from "../views/HomeView.vue";
// import DaoView from "../views/DaoView.vue";
// import DaoMembersView from "../views/DaoMembersView.vue";
// import DaoVotingsView from "../views/DaoVotingsView.vue";
import CreateNewDispute from "../views/CreateNewDispute.vue";
import DisputeView from "../views/DisputeView.vue";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "home",
    component: HomeView,
  },
  {
    path: "/create-new-dispute",
    name: "create-new-dispute",
    component: CreateNewDispute,
  },
  {
    path: "/dispute/:id",
    name: "dispute",
    component: DisputeView,
  },
  // {
  //   path: "/dao/:id",
  //   name: "dao",
  //   component: DaoView,
  // },
  // {
  //   path: "/dao/:id/members",
  //   name: "dao-members",
  //   component: DaoMembersView,
  // },
  // {
  //   path: "/dao/:id/votings",
  //   name: "dao-votings",
  //   component: DaoVotingsView,
  // },
  // {
  //   path: "/dao/:id/propose-event",
  //   name: "propose-event",
  //   component: ProposeEventView,
  // },
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

export default router;
