import axios from "axios";
import { authLoginMethods } from '../mixins/auth.js'
import router from '../src/router'
import { store } from '../store/index.js'


const silent_refresh_method = async () => {
   // 有効期限内にtrueを返す
    function isAuthenticated() {
      return new Date().getTime() < store.getters.auth_expires
    }

  // ユーザーが存在している場合はtrueを返す
    function isExistUser() {
      const user_sub = store.getters.current_user.sub
      const payload_sub = store.getters.auth_payload.sub
      return user_sub && payload_sub && user_sub === payload_sub
    }

  // ユーザーが存在し、かつ有効期限切れの場合にtrueを返す
    function isExistUserAndExpired() {
      return isExistUser() && !isAuthenticated()
    }

  // ユーザーが存在し、かつ有効期限内の場合にtrueを返す
    function loggedIn () {
      return isExistUser() && isAuthenticated()
    }
  
  if (isExistUserAndExpired()) {
    await axios.post('/auth_token/refresh')
      .then( response => authLoginMethods.methods.login(response.data))
      .catch(() => {
        const msg = 'セッションの有効期限が切れました。' +
          'もう一度ログインしてください'
        console.log(msg)

        authLoginMethods.methods.resetVuex()
        router.push('/login')
      })
  }
}

export default silent_refresh_method