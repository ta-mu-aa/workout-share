<template>
  <div class="flex justify-center h-full py-14">
    <div class="container lg: py-14">
      <form class="w-full max-w-sm m-auto">
        <UserFormEmail />
        <UserFormPassword />
        <div class="md:flex md:items-center mb-8">
        <div class="md:w-1/3"></div>
          <span class="text-xs"><router-link to="/signup" class="text-blue-700 hover:text-blue-500 duration-200 cursor-pointer">新規登録</router-link>はこちらから</span>
        </div>
        <div class="md:flex md:items-center">
          <div class="md:w-1/3"></div>
          <div class="md:w-2/3">
            <button class="shadow bg-blue-500 hover:bg-blue-400 duration-200 focus:shadow-outline focus:outline-none text-white font-bold py-2 px-4 rounded" type="button">
              ログイン
            </button>
          </div>
        </div>
      </form>
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
  }
}
</script>

<style lang="scss" scoped>
</style>