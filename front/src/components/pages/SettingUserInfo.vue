
<template>
  <div class="pt-6"> 
    <div class="md:grid md:grid-cols-4 md:gap-6">
      <div class="md:col-span-1">
        <div class="px-4 sm:px-0">
          <h3 class="text-lg font-medium leading-6 text-gray-900 pl-6">ユーザー情報</h3>
          <p class="mt-1 text-sm text-gray-600"></p>
        </div>
      </div>
      <div class="mt-5 md:col-span-3 md:mt-0">
        <div class="shadow sm:overflow-hidden sm:rounded-md">
          <div class="space-y-6 bg-white px-4 py-5 sm:p-6">
            <div class="grid grid-cols-6 gap-6">
              <div class="col-span-6 sm:col-span-3 p-2 border border-gray-300 border-solid rounded-md">
                <label for="user-name" class="block text-sm font-medium text-gray-400">ユーザー名</label>
                <input type="text" v-model="currentUserInfo.name" name="user-name" id="user-name" autocomplete="off"
                  class="mt-1 block w-full rounded-md outline-none sm:text-base " />
              </div>
              <div class="col-span-6 sm:col-span-4 p-2 border border-gray-300 border-solid rounded-md">
                <label for="email-address" class="block text-sm font-medium text-gray-400">メールアドレス</label>
                <input type="text" v-model="currentUserInfo.email" name="email-address" id="email-address" autocomplete="off"
                  class="mt-1 block w-full rounded-md outline-none sm:text-base border-none" />
              </div>
            </div>
            <div>
              <button v-if="!changePasswordArea" @click="changePasswordArea = true" class="rounded-md border border-gray-300 bg-white py-2 px-3 text-sm font-medium leading-4 text-gray-600 hover:bg-gray-100 focus:outline-none ">
                パスワードを変更
              </button>
              <div v-if="changePasswordArea" class="col-span-6 sm:col-span-4 p-3 pb-2 border border-gray-300 border-solid rounded-md">
                <label for="password" class="block text-sm font-medium text-gray-400">新規パスワード</label>
                <input type="password" v-model="currentUserInfo.password" 
                  name="password" id="password" autocomplete="off" class="mt-1 block w-full rounded-md outline-none sm:text-base border-none" />
                <label for="password_confirmation" class="block text-sm font-medium text-gray-400">新規パスワード確認</label>
                <input type="password" v-model="currentUserInfo.password_confirmation"
                  name="password_confirmation" id="password_confirmation" autocomplete="off" class="mt-1 block w-full rounded-md outline-none sm:text-base border-none" />
                <div class="text-right">    
                  <button @click="changePasswordArea = false"
                  class="inline-flex justify-center rounded-md border border-transparent bg-gray-300 py-2 px-3 text-xs font- text-white shadow-sm  focus:ring-offset-2">
                  キャンセル
                </button>
              </div>
              </div>
            </div>
            <div class="p-2 border border-gray-300 border-solid rounded-md">
              <label for="about" class="block text-sm font-medium text-gray-400">自己紹介</label>
              <div class="mt-1">
                <textarea v-model="currentUserInfo.user_discription" id="about" name="about" rows="3" class="mt-1 block w-full rounded-md outline-none  sm:text-base resize-none text-base" />
              </div>
            </div>

            <div>
              <div class="mt-1 flex items-center">
                <span v-if="this.$store.getters.current_user.image_url" class="inline-block h-16 w-16 overflow-hidden rounded-full">
                  <img :src=this.$store.getters.current_user.image_url alt="" >
                </span>
                <span v-if="!this.$store.getters.current_user.image_url" class="inline-block h-16 w-16 overflow-hidden rounded-full bg-gray-100">
                  <svg class="h-full w-full text-gray-300" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M24 20.993V24H0v-2.996A14.977 14.977 0 0112.004 15c4.904 0 9.26 2.354 11.996 5.993zM16.002 8.999a4 4 0 11-8 0 4 4 0 018 0z" />
                  </svg>
                </span>
                <label for="file-upload" class="ml-5 rounded-md border border-gray-300 bg-white py-2 px-3 text-sm font-medium leading-4 text-gray-700 shadow-md hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2">
                  画像を変更
                  <input @change="setImageIcon" id="file-upload" name="file-upload" type="file" class="sr-only" />
                </label>
                <div v-if="previewImageIcon" class="flex items-center">
                  <span class="ml-2">{{ previewImageIcon.name }}</span>
                  <img :src="currentUserInfo.ImageIconBase64" alt="" class=" h-16 w-16 ml-4">
                </div>
              </div>
            </div>
          </div>
          <div class="bg-gray-50 px-5 py-3 text-right sm:px-6">
            <button type="submit" @click="submitUpdateInfo" :disabled="submitButtonDisabled" 
              :class="{ 'bg-indigo-300': submitButtonDisabled === true, 'bg-indigo-600': submitButtonDisabled === false, 'hover:bg-indigo-700': submitButtonDisabled === false}"
              class="inline-flex justify-center rounded-md border border-transparent  py-2 px-4 text-sm font-medium text-white shadow-sm  focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2">
              更新
            </button>
          </div>
        </div>
      </div>
    </div>

    <div class="hidden sm:block" aria-hidden="true">
      <div class="py-5">
        <div class="border-t border-gray-200" />
      </div>
    </div>
  </div>
</template>

<script>
import UserFormEmail from '../UsreForm/UserFormEmail.vue'
import UserFormPassword from '../UsreForm/UserFormPassword.vue'
export default {
  components: {
    UserFormEmail,
    UserFormPassword,
  },
  data() {
    return {
      currentUserInfo: {
        id: '',
        name: '',
        email: '',
        password: '',
        password_confirmation: '',
        user_discription: '',
        ImageIconBase64: null
      },
      changePasswordArea: false,
      submitButtonDisabled: false,
      previewImageIcon: null
    }
  },
  methods: {
    setImageIcon(e) {
      e.preventDefault()
      this.previewImageIcon = e.target.files[0]
      const reader = new FileReader()
      if (this.previewImageIcon) {
        reader.readAsDataURL(this.previewImageIcon)
      } else {
        this.currentUserInfo.ImageIconBase64 = ''
      }
      // 変換が終わったら実行される
      reader.onload = () => {
        this.currentUserInfo.ImageIconBase64 = reader.result
      }
    },
    async submitUpdateInfo() {
      const update_params = {
        name: this.currentUserInfo.name,
        email: this.currentUserInfo.email,
        password: this.currentUserInfo.password,
        password_confirmation: this.currentUserInfo.password_confirmation,
        user_discription: this.currentUserInfo.user_discription,
        image_icon: this.currentUserInfo.ImageIconBase64
      }
    // パスワードの変更がなかった際はパラメータから削除
      if (update_params.password === '' || update_params.password_confirmation === '') {
        delete update_params.password
        delete update_params.password_confirmation
      }
      await this.axios.patch(`user/${this.currentUserInfo.id}`, update_params)
        .then((response) => {
          this.user_update_success(response.data) 
      })
        .catch(error => {
          const message = error.response.data.message
          this.$store.dispatch('getToast', { message })
      })
    },
    async user_update_success(response) {
      await this.$store.dispatch('getCurrentUser', response)
      await this.$router.push('/home')
      const message = 'ユーザー情報を更新しました'; const color = 'bg-blue-500';
      this.$store.dispatch('getToast', { message, color })
    }
  },
  created() {
    const gettersCurrentUser = this.$store.getters.current_user
    // あらかじめユーザー情報をフォームに出力
    this.currentUserInfo.id = gettersCurrentUser.id; this.currentUserInfo.name = gettersCurrentUser.name; this.currentUserInfo.email = gettersCurrentUser.email
    gettersCurrentUser.user_discription ? this.currentUserInfo.user_discription = gettersCurrentUser.user_discription : this.currentUserInfo.user_discription = ''
  },
  updated() {
    // フォームに入力された値のバリデーション
    if (this.currentUserInfo.name === '' || this.currentUserInfo.name.length > 30) {
      this.submitButtonDisabled = true
      return
    }
    if (this.currentUserInfo.email === '' || this.currentUserInfo.email.length > 100) {
      this.submitButtonDisabled = true
      return
    }
    const emailReg = new RegExp(/^[A-Za-z0-9]{1}[A-Za-z0-9_.-]*@{1}[A-Za-z0-9_.-]{1,}\.[A-Za-z0-9]{1,}$/)
    if (!emailReg.test(this.currentUserInfo.email)) {
      this.submitButtonDisabled = true
      return
    }
    if (this.changePasswordArea) {
      if (this.currentUserInfo.password === '' || this.currentUserInfo.password.length < 8) {
        this.submitButtonDisabled = true
        return
    }
    if (this.currentUserInfo.password.length > 100) {
      this.submitButtonDisabled = true
      return
    }
    const passwordReg = /^(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,100}$/i
    if (!passwordReg.test(this.currentUserInfo.password)) {
      this.submitButtonDisabled = true
      return
    }
    if (this.currentUserInfo.password !== this.currentUserInfo.password_confirmation) {
      this.submitButtonDisabled = true
      return
    }
  }
  if (this.currentUserInfo.user_discription.length > 400) {
    this.submitButtonDisabled = true
    return
  }
    this.submitButtonDisabled = false
  },
}
</script>

<style lang="scss" scoped>

</style>