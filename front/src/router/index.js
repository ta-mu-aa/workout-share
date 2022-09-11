import { createRouter, createWebHistory } from "vue-router";
import HomePage from "../components/pages/HomePage.vue";
import LoginPage from "../components/pages/LoginPage.vue";
import SignUpPage from "../components/pages/SignUpPage.vue";
import axios from "axios";
import { authLoginMethods } from '../../mixins/auth.js'

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

router.beforeResolve(async (to) => {
  if (to.fullPath === '/login' || to.fullPath === '/signup') {
    return
  }
    await axios.post(
      '/auth_token/refresh',
      {},
      { validateStatus: status => authLoginMethods.methods.resolveUnauthorized(status) }
      ).then(response => authLoginMethods.methods.login(response.data))
  })

export default router