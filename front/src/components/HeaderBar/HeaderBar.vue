<template>
  <nav class="flex items-center justify-between flex-wrap shadow-md p-4 fixed top-0 w-full z-30 bg-white">
    <div class="flex items-center flex-shrink-0">
      <span class="font-semibold text-xl tracking-tight mb-2">workout-share</span>
    </div>
    <div class="flex-grow flex items-center justify-end w-auto">
      <div class="mr-6 md:mr-10">
        <HeaderHome />
        <HeaderSerch />
        <HeaderMessage />
        <HeaderNotification />
      </div>
      <div class="flex-shrink-0 flex hover:bg-blue-00 rounded-full mr-2">
        <HeaderUserinfo />
      </div>
    </div>
  </nav>
</template>

<script>
import HeaderHome from './HeaderHome.vue'
import HeaderSerch from './HeaderSerch.vue'
import HeaderNotification from './HeaderNotification.vue'
import HeaderMessage from './HeaderMessage.vue'
import HeaderUserinfo from './HeaderUserinfo.vue'
export default {
  components: {
    HeaderHome,
    HeaderSerch,
    HeaderNotification,
    HeaderMessage,
    HeaderUserinfo,
  }
}
</script>

<style lang="scss" scoped>
  
</style>