<template>
<div>
  <div v-for="post in showPostList" :key="post.id" :id=post.id>
    <div class="relative flex flex-shrink-0 p-4 pb-0">
    <a href="#" class="flex-shrink-0 group block">
      <div class="flex items-center">
        <PostUserinfo />
      </div>
    </a>
    <div class="m-auto text-sm leading-5 ml-2 font-medium text-gray-400">
      {{ postedTime(post.created_at)}}
    </div>
    <svg @click="showPostDrawer(post.id); selectePostId(post.id)" class="post-drawer-icon w-8 h-8 p-1 my-auto cursor-pointer rounded-full duration-200 hover:bg-black hover:text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
        d="M5 12h.01M12 12h.01M19 12h.01M6 12a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0z">
      </path>
    </svg>
    <PostDrawer :showPostDrawer="postDrawerBoolean" :selectedPostId = "selectedPost" v-if="post.id === selectedPost" />
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
</div>
</template>

<script>
import PostUserinfo from './PostUserinfo.vue'
import PostReply from './PostReply.vue'
import PostFavorite from './PostFavorite.vue'
import PostDrawer from './PostDrawer.vue'
export default {
  components: {
    PostUserinfo,
    PostReply,
    PostFavorite,
    PostDrawer
  },
  data() {
    return {
      postDrawerBoolean: false,
      selectedPost: null
    }
  },
  methods: {
    postedTime(time) {
      const postedMonth = time.slice(5, 7)
      const postedDate = time.slice(8, 10)
      return postedMonth + '月' + postedDate + '日'
    },
    showPostDrawer() {
      this.postDrawerBoolean = !this.postDrawerBoolean
    },
    selectePostId(id) {
      this.selectedPost = id
    }
  },
  computed: {
    showPostList() {
      return this.$store.getters.postList
    }
  },
  mounted() { 
    const $this = this
    document.addEventListener("click", function (e) {
      const target = (e.target).closest(".post-drawer-icon")
      if (target === null && $this.postDrawerBoolean) {
        $this.showPostDrawer()
      }
    })
  }
}
</script>

<style lang="scss" scoped>
  
</style>