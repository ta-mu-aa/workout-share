import { createRouter, createWebHistory } from "vue-router";
import HomePage from "../components/pages/HomePage.vue";
import LoginPage from "../components/pages/LoginPage.vue";
import SignUpPage from "../components/pages/SignUpPage.vue";
import  silent_refresh  from '../../plugins/silent-refresh-token.js'

const routes = [
  {
    path: "/home",
    name: "Home",
    component: HomePage,
  },
  {
    path: "/signup",
    name: "Singup",
    component: SignUpPage,
  },
  {
    path: "/login",
    name: "Login",
    component: LoginPage,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

router.beforeEach(async (to) => {
  if (to.fullPath === '/login' || to.fullPath === '/signup') {
    return
  }
  // 画面遷移時にトークンの有効期限が切れているか判断する
  silent_refresh()
})

export default router