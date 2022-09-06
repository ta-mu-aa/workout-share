import jwtDecode from 'jwt-decode'

export const authLoginMethods = {
  methods: {
  // 認証情報をVuexに保存する
    setAuth({ token, expires, user }) {
      const exp = expires * 1000
      const jwtPayload = (token) ? jwtDecode(token) : {}
      
      this.$store.dispatch('getAuthToken', token)
      this.$store.dispatch('getAuthExpires', exp)
      this.$store.dispatch('getCurrentUser', user)
      this.$store.dispatch('getAuthPayload', jwtPayload)
    },
  // ログイン時のメソッド
    login (response) {
      this.setAuth(response)
    }
	}
}
