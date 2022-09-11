import jwtDecode from 'jwt-decode'
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
      await this.axios.delete(
        '/auth_token/',
        { validateStatus: status => this.resolveUnauthorized(status) }
      )
      this.resetVuex()
    }
	}
}
