<template>
<div v-for="post in showPostList" :key="post.id">
  <div class="flex flex-shrink-0 p-4 pb-0">
    <a href="#" class="flex-shrink-0 group block">
      <div class="flex items-center">
        <PostUserinfo />
        <div class="ml-3">
          <span class="text-sm leading-5 ml-2 font-medium text-gray-400">
            {{ postedTime(post.created_at)}}
          </span>
        </div>
      </div>
    </a>
  </div>
  <div class="pl-16">
    <p class="text-base width-auto font-medium  flex-shrink">
      {{ post.body }}
      <span class="text-blue-400"># リンクが入ります</span>
    </p>

    <div class="flex">
      <div class="w-full">
        <div class="flex justify-end items-center">
          <PostReply />
          <PostFavorite />
        </div>
      </div>
    </div>  
  </div>
  <hr class="border-gray-600">
</div>
</template>

<script>
import PostUserinfo from './PostUserinfo.vue'
import PostReply from './PostReply.vue'
import PostFavorite from './PostFavorite.vue'
export default {
  components: {
    PostUserinfo,
    PostReply,
    PostFavorite
  },
  methods: {
    postedTime(time) {
      const postedMonth = time.slice(5, 7)
      const postedDate = time.slice(8, 10)
      return postedMonth + '月' + postedDate + '日'
    }
  },
  computed: {
    showPostList() {
      return this.$store.getters.postList
    }
  }
}
</script>

<style lang="scss" scoped>
  
</style>