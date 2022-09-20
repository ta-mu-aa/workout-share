<script>
import { authLoginMethods } from '../mixins/auth.js'
export default {
  mixins: [authLoginMethods],
  async mounted() {
    if (location.pathname === '/login' || location.pathname === '/signup') {
      return
    }

  // 画面描画時に通信を行いVuexにログインデータを保存する
    await this.axios.post(
      '/auth_token/refresh',
      {},
      { validateStatus: status => this.resolveUnauthorized(status) }
    )
      .then(response => this.login(response.data))

  // 画面描画時にログイン情報がセットされていない場合はログイン画面に遷移
    if (!this.$store.state.user.current && !this.$store.state.auth.token &&
      !this.$store.state.expirs && !this.$store.state.sub
    ) {
      this.$router.push('/login')
    }
  }
}
</script>

<template>
  <router-view></router-view>
</template>

<style scoped>
</style>
