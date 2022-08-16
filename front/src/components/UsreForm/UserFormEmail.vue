<template>
  <div class="md:flex md:items-center mb-6">
    <div class="md:w-1/3">
      <label class="block text-gray-500 font-bold md:text-right mb-1 md:mb-0 pr-4" for="inline-email">
        Eメール
      </label>
    </div>
    <div class="md:w-4/5">
      <input 
        :value="userEmail" 
        @input="$emit('update:userEmail', $event.target.value)"
        class="bg-gray-200 appearance-none border-2 border-gray-200 rounded w-full py-2 px-4 text-gray-700 leading-tight focus:outline-none focus:bg-white focus:border-blue-500"
        id="inline-email" placeholder="workout@example.com">
    </div>
  </div>
</template>

<script>
export default {
  props: {
    userEmail: String
  },
  emits: ['update:userEmail']
}
</script>

<style lang="scss" scoped>
</style>
