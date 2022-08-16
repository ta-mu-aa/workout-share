<template>
  <div class="md:flex md:items-center mb-6">
    <div class="md:w-1/3">
      <label class="block text-gray-500 font-bold md:text-right mb-1 md:mb-0 pr-4" for="inline-full-name">
        名前
      </label>
    </div>
    <div class="md:w-4/5">
      <input 
        :value="userName" 
        @input="$emit('update:userName', $event.target.value)"
        class="bg-gray-200 appearance-none border-2 border-gray-200 rounded w-full py-2 px-4 text-gray-700 leading-tight focus:outline-none focus:bg-white focus:border-blue-500"
        id="inline-full-name" type="text" placeholder="30文字以内で入力してください">
    </div>
  </div>
</template>

<script>
export default {
  props: {
    userName: String 
  },
  emits: ['update:userName']
}
</script>

<style lang="scss" scoped>
input::placeholder {
  font-size: 0.8em;
}
</style>