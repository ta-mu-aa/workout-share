<template>
  <div v-if="showUpdateArea">
    <div id="modal-base" class="fixed -inset-0 z-30 bg-black bg-opacity-5 flex flex-col justify-center" style=" background-color: rgba(0,0,0,.5);"></div>
    <div class="post-update-modal fixed top-1/2 left-1/2 bg-white flex flex-col justify-center z-40 w-3/5 h-auto rounded-xl p-8 pb-0 -translate-y-2/4 -translate-x-2/4">
      <textarea 
        v-model="textareaContent"
        class="caret-slate-500 resize-none outline-none w-full border-b" id="updateForm"
        placeholder="変更内容を入力" cols="20" rows="10" maxlength="400">
      </textarea>
      <div class="flex justify-end py-2">
        <button @click="submitPostUpdate" :disabled="buttonDisabled" class="py-2 px-6  text-white rounded-full text-sm"
        :class="{ 'bg-blue-300': buttonDisabled == true, 'bg-blue-400': buttonDisabled == false }">
        更新
        </button>
    </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    showUpdateArea: {
      type: Boolean
    },
    updatePostContent: {
      type: Object
    }
  },
  data() {
    return {
      textareaContent: '',
      buttonDisabled: false
    }
  },
  methods: {
    async submitPostUpdate() {
      await this.axios.patch(`/posts/${this.updatePostContent.id}`, {
        body: this.textareaContent,
        user_id: this.$store.getters.current_user.id
      })
        .then(response => this.postUpdateSuccess(response.data))
        .catch(error => {
          const message = error.response.data.message || '投稿が見つかりませんでした'
          this.$store.dispatch('getToast', { message })
          console.log(error)
        })
    },
    postUpdateSuccess(response) {
      this.$emit('closeUpdateFormModal', false)
      console.log(response)
      const targetPost = {
        body: response.data.body,
        id: response.data.id,
        user_id: response.data.user_id
      }
      this.$store.dispatch('updatePost', targetPost)
      const message = '投稿内容を更新しました'
      const color = 'bg-blue-500'
      const timeout = 2000
      this.$store.dispatch('getToast', { message, color, timeout })
    }
  },
  watch: {
    updatePostContent: function (newVal) {
      this.textareaContent = newVal.body  
    }
  },
  updated() {
    if (this.textareaContent === '') {
      this.buttonDisabled = true
    }
    else if (this.textareaContent.length > 400) {
      this.buttonDisabled = true
    }
    else {
      this.buttonDisabled = false
    }
  }
}
</script>