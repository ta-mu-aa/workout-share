<template>
  <div
   v-if="setToaster"
   v-bind:class = this.toast.color
   class=" rounded-md z-40 fixed top-9 right-0 left-0 mx-auto w-1/2"
   >
    <div class="mx-auto max-w-7xl py-3 px-3 sm:px-6 lg:px-8">
      <div class="flex flex-wrap items-center justify-between">
        <div class="flex w-0 flex-1 items-center">
          <p class="ml-3 truncate font-medium text-white">
            {{toast.message}}
          </p>
        </div>
        <div class="order-2 flex-shrink-0 sm:order-3 sm:ml-3">
          <button type="button" class="-mr-1 flex rounded-md p-2"
          @click="resetToast"
          >
            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
          </button>
        </div>
      </div>
    </div>          
  </div>
</template>

<script>
export default {
  computed: {
    toast() {
      return this.$store.state.toast
    },
    setToaster() {
      if (!!this.toast.message) {
        setTimeout(() => {this.resetToast()}, this.toast.timeout)
        return true
      }
    }
  },
  beforeDestroy () {
    // Vueインスタンスが破棄される直前にVuexのtoast.msgを削除する(無期限toastに対応)
    this.resetToast()
  },
  methods: {
    // Vuexのtoast.msgの値を変更する
    resetToast() {
      return this.$store.dispatch('getToast', { message: null })
    }
  }
}
</script>
