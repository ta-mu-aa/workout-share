import { createRouter, createWebHistory } from "vue-router";
import HomePage from "../components/pages/HomePage.vue";
import LoginPage from "../components/pages/LoginPage.vue";
import SignUpPage from "../components/pages/SignUpPage.vue";
import NotFoundError from '../components/pages/error/NotFound.vue';
import silent_refresh  from '../../plugins/silent-refresh-token.js'
import { authLoginMethods } from '../../mixins/auth.js'
import { store } from '../../store/index.js'
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
  // 上から順にマッチするものを探すため一番下に記述
  {
    path: "/:catchAll(.*)",
    name: 'NotFoundError',
    component: NotFoundError,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

const auth = authLoginMethods.methods
router.beforeEach(async (to,from) => {
  // ログアウト時の画面遷移では何もしない
  if (from.path !== '/' && to.path === '/login') {
    return
  }
  // 認証が失敗した際の画面遷移では何もしない
  if (to.query.auth) {
    return
  }
  // ログインしているユーザー情報がセットされていなければ取得する
  if (!auth.isExistUser()) {
    await axios.post(
      '/auth_token/refresh',
      {},
      { validateStatus: status => auth.resolveUnauthorized(status) }
    )
      .then(response => auth.login(response.data))
  }

  // ログインしている場合
  if (to.path === '/login' || to.path === '/signup') {
    if (auth.loggedIn()) {
      console.log('ログイン済みユーザーです')
      router.push('/home')
    }
  }
  else {
    // ログインしていない場合
    if (!auth.isExistUser()) {       
      // ユーザー以外の値が存在する可能性があるので全てを削除する
      await auth.logout()

      const message = 'まずはログインしてください'
      store.dispatch('getToast', {message})
      router.push({ path:'login', query:{auth:'uncertified'}})
    }
  }
  // 画面遷移時にトークンの有効期限が切れていないか判断する
  await silent_refresh()
})

export default router