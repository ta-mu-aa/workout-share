import jwtDecode from 'jwt-decode'
import axios from 'axios'
import { store } from '../store/index.js'

export const authLoginMethods = {
  methods: {
  // 認証情報をVuexに保存する
    setAuth({ token, expires, user }) {
      const exp = expires * 1000
      const jwtPayload = (token) ? jwtDecode(token) : {}
      
      store.dispatch('getAuthToken', token)
      store.dispatch('getAuthExpires', exp)
      store.dispatch('getCurrentUser', user)
      store.dispatch('getAuthPayload', jwtPayload)
    },
  // ログイン時のメソッド
    login (response) {
      this.setAuth(response)
    },

  // Vuexの値を初期値に戻す
    resetVuex() {
      this.setAuth({ token: null, expires: 0, user: null })
    },

  // axiosのレスポンス401を許容する
    resolveUnauthorized(status) {
      return (status >= 200 && status < 300) || (status === 401)
    },

  // ログアウト時のメソッド
    async logout() {
      await axios.delete(
        '/auth_token/',
        { validateStatus: status => this.resolveUnauthorized(status) }
      )
      this.resetVuex()
    },
    
   // 有効期限内にtrueを返す
    isAuthenticated() {
      return new Date().getTime() < store.getters.auth_expires
    },

  // ユーザーが存在している場合はtrueを返す
    isExistUser() {
      const user_sub = store.getters.current_user.sub
      const payload_sub = store.getters.auth_payload.sub
      return user_sub && payload_sub && user_sub === payload_sub
    },

  // ユーザーが存在し、かつ有効期限切れの場合にtrueを返す
    isExistUserAndExpired () {
      return this.isExistUser() && !this.isAuthenticated()
    },

  // ユーザーが存在し、かつ有効期限内の場合にtrueを返す
    loggedIn () {
      return this.isExistUser() && this.isAuthenticated()
    }
	}
}
