<template>
    <div class="inline-block cursor-pointer" @click="showPostFormModal">
    <svg id="postform" class="md:mr-4 h-5 w-5 md:h-7 md:w-7 hover:" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v3m0 0v3m0-3h3m-3 0H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg> 
      <PostFormModal />
    </div>
</template>

<script>
  import PostFormModal from '../../components/PostForm/PostFormModal.vue' 
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
      console.log(e.path[0].id)
      // モーダル内をクリックした際は何もしない
      if (e.path[0].id === 'postform' || e.path[0].id === 'modal-base') {
        this.showModalJudge = !this.showModalJudge
        this.$store.dispatch('getPostFormModal',  this.showModalJudge )
      }

      await silent_refresh_method();
    }
  }
}
</script>

<style lang="scss" scoped>
  
</style>