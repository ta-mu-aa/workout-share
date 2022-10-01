<script>
  import Toaster from './components/AppToaster.vue' 
export default {
  components: {
    Toaster
  },
  methods: {
    test() {
      const message = 'test'
      const color = 'bg-red-500'
      this.$store.dispatch('getToast', {message, color})
    }
  }    

}
</script>

<template>
  <button @click = "test">test</button>
  <Toaster />
  <router-view></router-view>

</template>

<style scoped>
</style>
