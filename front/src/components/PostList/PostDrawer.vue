<template>
  <div class="absolute top-14 right-0 min-w-max z-10 p-5 shadow-lg text-sm bg-white" v-if="showPostDrawer">
    <div class="mb-2 cursor-pointer" @click="postUpdate">編集</div>
    <div class="cursor-pointer" @click="postDelete">削除</div>
  </div>
</template>

<script>
export default {
  props: {
    showPostDrawer: {
      type: Boolean
    },
    selectedPostId: {
      type: Number
    }
  },
  methods: {
    postDelete() {
      if (confirm('本当に削除しますか？')) {
        this.axios.delete(`/posts/${this.selectedPostId}`)
          .then(() => this.$store.dispatch('deletePost', this.selectedPostId))
          .catch(() => {
            const message = '投稿を削除できませんでした'
            this.$store.dispatch('getToast', {message})
          })
      }
    },
    postUpdate() {
      console.log('showupdateArea')
      this.$emit('showPostUpdateArea', true)
    }
  }
}
</script>