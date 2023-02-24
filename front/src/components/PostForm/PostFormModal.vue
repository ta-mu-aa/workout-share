<template>
  <div v-if="isVisible">
    <div id="modal-base" class="fixed -inset-0 bg-black bg-opacity-5 flex flex-col justify-center" style=" background-color: rgba(0,0,0,.5);" ></div>
    <div class="fixed top-1/2 left-1/2 bg-white flex flex-col justify-center w-3/5 h-auto rounded-xl p-8 pb-0 -translate-y-2/4 -translate-x-2/4">
      <textarea 
      v-model="postContent.body" 
      class="caret-slate-500 border-b resize-none outline-none" 
      placeholder="投稿内容を入力" cols="20" rows="10" maxlength="400"
      >
      </textarea>
      <div class="text-right py-3">
        <button @click="submitPostContent" 
        :disabled="buttonDisabled" 
        class="py-2 px-6 text-white rounded-full text-sm"
        :class="{ 'bg-blue-300': buttonDisabled == true, 'bg-blue-400': buttonDisabled == false }"
        >
        投稿
      </button>  
      </div>
    </div>
  </div>
</template>

<script>
import { post_list_fetch } from '../../../plugins/post-list-fetch.js'
import { mypage_post_list_fetch } from '../../../plugins/post-list-fetch.js'
export default {
  data() {
    return {
      postContent: {
        body: '',
        user_id: this.$store.getters.current_user.id
      },
      buttonDisabled: false
    }
  },
  methods: {
    async submitPostContent() {
      await this.axios.post('/posts', this.postContent)
        .then( response => this.postContentSuccess(response))
        .catch( error => this.postContentError(error))
      },
      postContentSuccess() {
        this.postContent.body = ''
        this.$emit("closeFormModal", false)  
        post_list_fetch()
        mypage_post_list_fetch()
      },
      postContentError(error) {
        const message = error.response.data.message
        this.$store.dispatch('getToast', { message })
      }
  },
  computed: {
    isVisible() {
      return this.$store.getters.postFormModal
    }, 
  },
  updated() {
    if (this.postContent.body === '') {
      this.buttonDisabled = true
    }
    else if (this.postContent.body.length > 400) {
      this.buttonDisabled = true
    }
    else {
      this.buttonDisabled = false
    }
  }
}
</script>