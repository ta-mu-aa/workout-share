<template>
  <a href="#" class="flex items-center group-hover:opacity-60 duration-200">
    <div>
      <img class="inline-block h-10 w-10 rounded-full" src="https://pbs.twimg.com/profile_images/1121328878142853120/e-rpjoJi_bigger.png" alt="" />
    </div>
    <div class="ml-3">
      <span class="text-sm leading-6 font-medium ">
        {{ currentUserInfo.name }}
      </span>
    </div>
  </a>
</template>

<script>
export default {
  computed: {
    currentUserInfo() {
      return this.$store.getters.current_user
    }
  },
}
</script>