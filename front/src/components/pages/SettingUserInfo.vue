
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
              <div class="col-span-6 sm:col-span-3 p-3 pb-2 border border-gray-300 border-solid rounded-md">
                <label for="user-name" class="block text-sm font-medium text-gray-400">ユーザー名</label>
                <input type="text" name="user-name" id="user-name" autocomplete="given-name"
                  class="mt-1 block w-full rounded-md outline-none sm:text-base " />
              </div>
              <div class="col-span-6 sm:col-span-4 p-3 pb-2 border border-gray-300 border-solid rounded-md">
                <label for="email-address" class="block text-sm font-medium text-gray-400">メールアドレス</label>
                <input type="text" name="email-address" id="email-address" autocomplete="email"
                  class="mt-1 block w-full rounded-md outline-none sm:text-base border-none" />
              </div>
            </div>
            <div>
              <button class="rounded-md border border-gray-300 bg-white py-2 px-3 text-sm font-medium leading-4 text-gray-600 hover:bg-gray-100 focus:outline-none ">
                パスワードを変更
                <input id="file-upload" name="file-upload" type="file" class="sr-only" />
              </button>
            </div>
            <div class="p-3 pb-2 border border-gray-300 border-solid rounded-md">
              <label for="about" class="block text-sm font-medium text-gray-400">About</label>
              <div class="mt-1">
                <textarea id="about" name="about" rows="3" class="mt-1 block w-full rounded-md outline-none  sm:text-base resize-none text-base" />
              </div>
            </div>

            <div>
              <div class="mt-1 flex items-center">
                <span class="inline-block h-12 w-12 overflow-hidden rounded-full bg-gray-100">
                  <svg class="h-full w-full text-gray-300" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M24 20.993V24H0v-2.996A14.977 14.977 0 0112.004 15c4.904 0 9.26 2.354 11.996 5.993zM16.002 8.999a4 4 0 11-8 0 4 4 0 018 0z" />
                  </svg>
                </span>
                <label for="file-upload" class="ml-5 rounded-md border border-gray-300 bg-white py-2 px-3 text-sm font-medium leading-4 text-gray-700 shadow-md hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2">
                  画像を変更
                  <input id="file-upload" name="file-upload" type="file" class="sr-only" />
                </label>
              </div>
            </div>
          </div>
          <div class="bg-gray-50 px-5 py-3 text-right sm:px-6">
            <button type="submit" class="inline-flex justify-center rounded-md border border-transparent bg-indigo-600 py-2 px-4 text-sm font-medium text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2">更新</button>
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

<!-- <template>
  <div class="flex justify-center h-full py-14">
    <div class="container lg: py-14">
      <form class="w-full max-w-sm m-auto">
        <UserFormEmail v-model:user-email="userEmail" />
        <UserFormPassword v-model:user-password="userPassword" />
        <div class="md:flex md:items-center">
          <div class="md:w-1/3"></div>
          <div class="md:w-2/3">
            <button @click="Login"
              class="shadow bg-blue-500 hover:bg-blue-400 duration-200 focus:shadow-outline focus:outline-none text-white font-bold py-2 px-4 rounded"
              type="button">
              更新
            </button>
          </div>
        </div>
      </form>
    </div>
  </div>
</template> -->

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