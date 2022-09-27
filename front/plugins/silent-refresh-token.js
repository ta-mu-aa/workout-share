import axios from "axios";
import { authLoginMethods } from '../mixins/auth.js'
import router from '../src/router'

const silent_refresh_method = async () => {
  const auth = authLoginMethods.methods
  if (auth.isExistUserAndExpired()) {
    await axios.post('/auth_token/refresh')
      .then( response => auth.login(response.data))
      .catch((error) => {
        const msg = 'セッションの有効期限が切れました。' +
          'もう一度ログインしてください'
        console.log(msg)

        auth.resetVuex()
        router.push({ path:'login', query: {auth:'expired'}})
      })
  }
}

export default silent_refresh_method