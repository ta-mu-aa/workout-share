<template>
  <div class="flex justify-center h-full py-14">
    <div class="container lg: py-14">
      <form class="w-full max-w-sm m-auto">
        <UserFormName />
        <UserFormEmail />
        <UserFormPassword />
        <UserFormConfirm />
        <div class="md:flex md:items-center mb-8">
        <div class="md:w-1/3"></div>
          <span class="text-xs"><router-link to="/login" class="text-blue-700 hover:text-blue-500 duration-200 cursor-pointer">ログイン</router-link>はこちらから</span>
        </div>
        <div class="md:flex md:items-center">
          <div class="md:w-1/3"></div>
          <div class="md:w-2/3">
            <button class="shadow bg-blue-500 hover:bg-blue-400 duration-200 focus:shadow-outline focus:outline-none text-white font-bold py-2 px-4 rounded" type="button">
              新規会員登録
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
export default {
  components: {
    UserFormName,
    UserFormEmail,
    UserFormPassword,
    UserFormConfirm
  }
}
</script>

<style lang="scss" scoped>
</style>