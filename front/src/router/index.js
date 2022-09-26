import { createRouter, createWebHistory } from "vue-router";
import HomePage from "../components/pages/HomePage.vue";
import LoginPage from "../components/pages/LoginPage.vue";
import SignUpPage from "../components/pages/SignUpPage.vue";
import silent_refresh  from '../../plugins/silent-refresh-token.js'
import { authLoginMethods } from '../../mixins/auth.js'
import axios from 'axios'

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

const auth = authLoginMethods.methods
router.beforeEach(async () => {

  // ログインしているユーザー情報がセットされていなければ取得する
  if (!auth.isExistUser()) {
    await axios.post(
      '/auth_token/refresh',
      {},
      { validateStatus: status => auth.resolveUnauthorized(status) }
    )
      .then(response => auth.login(response.data))
  }

  // 画面遷移時にトークンの有効期限が切れていないか判断する
  await silent_refresh()
})

export default router