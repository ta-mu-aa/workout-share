<script>
  import Toaster from './components/AppToaster.vue' 
export default {
  components: {
    Toaster
  },
}
</script>

<template>
  <Toaster />
  <router-view></router-view>
</template>

<style scoped>
</style>
