import axios from "axios";
import { authLoginMethods } from '../mixins/auth.js'
import router from '../src/router'
import { store } from '../store/index.js'

const silent_refresh_method = async () => {
  const auth = authLoginMethods.methods
  if (auth.isExistUserAndExpired()) {
    await axios.post('/auth_token/refresh')
      .then( response => auth.login(response.data))
      .catch(() => {
        const message = 'セッションの有効期限が切れました。\n' +
          'もう一度ログインしてください'

        auth.resetVuex()
        store.dispatch('getToast', {message})
        router.push({ path:'login', query: {auth:'expired'}})
      })
  }
}

export default silent_refresh_method