<template>
  <div class="flex justify-center h-full py-14">
    <div class="container lg: py-14">
      <form class="w-full max-w-sm m-auto">
        <UserFormName v-model:user-name="userName" />
        <UserFormEmail v-model:user-email="userEmail" />
        <UserFormPassword v-model:user-password="userPassword" />
        <UserFormConfirm v-model:user-confirm="userConfirm" />
        <div class="md:flex md:items-center mb-8">
          <div class="md:w-1/3"></div>
          <span class="text-xs">
            <router-link to="/login" class="text-blue-700 hover:text-blue-500 duration-200 cursor-pointer">ログイン
            </router-link>はこちらから
          </span>
        </div>
        <div class="md:flex md:items-center">
          <div class="md:w-1/3"></div>
          <div class="md:w-2/3">
            <button @click="clickSubmitButton" :disabled="disabled"
              :class="{ 'bg-blue-300': disabled === true, 'bg-blue-500': disabled === false}"
              class="shadow  focus:shadow-outline focus:outline-none text-white font-bold py-2 px-4 rounded"
              type="button">
              新規登録
            </button>
          </div>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import UserFormName from '../UsreForm/UserFormName.vue'
import UserFormEmail from '../UsreForm/UserFormEmail.vue'
import UserFormPassword from '../UsreForm/UserFormPassword.vue'
import UserFormConfirm from '../UsreForm/UserFormConfirm.vue'
import { authLoginMethods } from '../../../mixins/auth.js'
const API_URL = import.meta.env.VITE_API_URL
export default  {
  components: {
    UserFormName,
    UserFormEmail,
    UserFormPassword,
    UserFormConfirm
  },
  mixins: [authLoginMethods],
  data() {
    return {
      disabled: true,
      userName: '',
      userEmail: '',
      userPassword: '',
      userConfirm: '' 
    }
  },
  methods: {
    // 新規登録時のデータをAPIに送信する
    async registerDataSubmit() {
      const signupParams = {
        name: this.userName,
        email: this.userEmail,
        password: this.userPassword,
        password_confirmation: this.userConfirm
      }
      await this.axios.post(`${API_URL}/user/`, signupParams)
        .then(() => this.createUserSuccessfull())
        .catch((error) => this.createUserFailer(error))
    },
    async createUserSuccessfull() {
      const message = '新規登録を完了しました'; const color = 'bg-blue-500'
      this.$store.dispatch('getToast', { message, color })
      const loginParams = { auth: { email: this.userEmail, password: this.userPassword } }
      await this.axios.post(`/auth_token`, loginParams)
        .then(response => this.authSuccessful(response))
        .catch(error => this.authFailure(error))
    },
    createUserFailer(error) {
      const responseStatusCode = error.response.status
      if (responseStatusCode === 400) {
        const message = '正しい情報を入力してください'
        this.$store.dispatch('getToast', { message })
        return
      }
      if (responseStatusCode === 409) {
        const message = '既に登録済みのメールアドレスです'
        this.$store.dispatch('getToast', { message })
        return
      }
    },
  // 新規会員登録ボタンを押した時の処理
    clickSubmitButton() {
      this.registerDataSubmit()
    },
  },

  updated() {
    // フォームに入力された値のバリデーション
    if (this.userName === '' || this.userName.length > 30) {
      this.disabled = true
      return
    }
    if (this.userEmail === '' || this.userEmail.length > 100) {
      this.disabled = true
      return
    }
    const emailReg = new RegExp(/^[A-Za-z0-9]{1}[A-Za-z0-9_.-]*@{1}[A-Za-z0-9_.-]{1,}\.[A-Za-z0-9]{1,}$/)
    if (!emailReg.test(this.userEmail)) {
      this.disabled = true
      return
    }
    if (this.userPassword === '' || this.userPassword.length < 8) {
      this.disabled = true
      return
    }
    if (this.userPassword.length > 100) {
      this.disabled = true
      return
    }
    const passwordReg = /^(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,100}$/i
    if (!passwordReg.test(this.userPassword)) {
      this.disabled = true
      return
    }
    if (this.userPassword !== this.userConfirm) {
      this.disabled = true
      return
    }
    this.disabled = false
  },
}
</script>

<style lang="scss" scoped>
</style>