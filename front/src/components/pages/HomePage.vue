<template>
<div>
  <HeaderBar />
  
  <div class="flex justify-center h-full py-20">
    <div class="container lg: py-6">
      <div class="flex justify-center">
        <div class="w-3/5 border border-gray-600 h-auto  border-t-0">
          <Post />
        </div>
      </div>
    </div>
  </div>
</div>
</template>

<script>
import Post from '../PostList/Post.vue'
import HeaderBar from '../HeaderBar/HeaderBar.vue'
export default {
  components: {
    Post,
    HeaderBar
  },
}
</script>

<style lang="scss" scoped>
</style>