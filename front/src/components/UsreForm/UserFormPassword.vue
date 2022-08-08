<template>
  <div class="md:flex md:items-center mb-6">
    <div class="md:w-1/3">
      <label class="block text-gray-500 font-bold md:text-right mb-1 md:mb-0 pr-4" for="inline-password">
        パスワード
      </label>
    </div>
    <div class="md:w-2/3">
      <input 
        :value="userPassword" 
        @input="$emit('update:userPassword', $event.target.value)"
        class="bg-gray-200 appearance-none border-2 border-gray-200 rounded w-full py-2 px-4 text-gray-700 leading-tight focus:outline-none focus:bg-white focus:border-blue-500"
        id="inline-password" type="password" placeholder="******************">
    </div>
  </div>
</template>

<script>
export default {
  props: {
    userPassword: String
  },
  emits: ['update:userPassword']
}
</script>

<style lang="scss" scoped>
</style>