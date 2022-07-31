<template>
  <nav class="flex items-center justify-between flex-wrap shadow-md p-4 fixed top-0 w-full z-30 bg-white">
    <div class="flex items-center flex-shrink-0  mr-6">
      <span class="font-semibold text-xl tracking-tight">workout-share</span>
    </div>
    <HeaderSpMenu />
    <div class="w-full hidden flex-grow md:flex md:items-center justify-end md:w-auto">
      <div class="mr-10">
        <HeaderSerch />
        <HeaderNotification />
        <HeaderMessage />
      </div>
      <div class="flex-shrink-0 flex hover:bg-blue-00 rounded-full mr-2">
        <HeaderUserinfo />
      </div>
    </div>
  </nav>
</template>

<script>
import HeaderSerch from './HeaderSerch.vue'
import HeaderNotification from './HeaderNotification.vue'
import HeaderMessage from './HeaderMessage.vue'
import HeaderUserinfo from './HeaderUserinfo.vue'
import HeaderSpMenu from './HeaderSpMenu.vue'
export default {
  components: {
    HeaderSerch,
    HeaderNotification,
    HeaderMessage,
    HeaderUserinfo,
    HeaderSpMenu,
  }
}
</script>

<style lang="scss" scoped>
  
</style>