<template>
  <div class="absolute top-14 right-0 min-w-max p-5 shadow-lg text-sm bg-white" v-if="showPostDrawer">
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
    postUpdate() {
      console.log('update')
    },
    postDelete() {
      console.log('delete')
    }
  }
}
</script>