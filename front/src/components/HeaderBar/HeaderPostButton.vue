<template>
    <div class="inline-block cursor-pointer" @click="showPostFormModal">
    <svg id="postform" class="md:mr-4 h-5 w-5 md:h-7 md:w-7 hover:" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path id="postform-icon-path" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v3m0 0v3m0-3h3m-3 0H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg> 
      <PostFormModal @closeFormModal="postedCloseModal" />
    </div>
</template>

<script>
  import PostFormModal from '../PostForm/PostFormModal.vue' 
  import silent_refresh_method from '../../../plugins/silent-refresh-token.js'
export default {
  components: {
    PostFormModal
  },
  data() {
    return {
      showModalJudge: false
    }
  },
  methods: {
    async showPostFormModal(e) {
      // モーダル内をクリックした際は何もしない
      if (e.target.id === 'postform' || e.target.id === 'modal-base' || e.target.id === 'postform-icon-path') {
        this.showModalJudge = !this.showModalJudge
        this.$store.dispatch('getPostFormModal',  this.showModalJudge )
      }
      await silent_refresh_method();
    },
    // 投稿後にモーダルを閉じる
    postedCloseModal(params) {
      this.showModalJudge = params
      this.$store.dispatch('getPostFormModal',  this.showModalJudge )
    }
  }
}
</script>

<style lang="scss" scoped>
  
</style>