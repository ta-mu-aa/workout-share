<template>
<div>
  <div v-if="isLoading" class="flex justify-center pt-8">
    <Loading />
  </div>
  <div v-for="post in showPostList" :key="post.id" :id=post.id>
    <div class="relative flex flex-shrink-0 p-4 pb-0">
      <a href="#" class="flex-shrink-0 group block">
        <div class="flex items-center">
          <PostUserinfo 
          :postedUserId="post.user_id" 
          :postedUserName="post.user_name" 
          :postedUserIcon="post.image_icon"
          />
        </div>
      </a>
      <div class="m-auto text-sm leading-5 ml-2 font-medium text-gray-400">
        {{ postedTime(post.created_at)}}
      </div>
      <svg v-if="currentUser.id === post.user_id" @click="showPostDrawer(post.id); selectePostId(post.id)" class="post-drawer-icon w-8 h-8 p-1 my-auto cursor-pointer rounded-full duration-200 hover:bg-black hover:text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
          d="M5 12h.01M12 12h.01M19 12h.01M6 12a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0z">
        </path>
      </svg>
      <PostDrawer 
      :showPostDrawer="postDrawerBoolean" 
      :selectedPostId = "selectedPost" 
      @showPostUpdateArea = "postUpdateArea = $event, showPostDrawer()"
      v-if="post.id === selectedPost" 
      />
    </div>
    <div class="pl-16">
      <p class="text-base width-auto font-medium  flex-shrink break-all pr-4">
        {{ post.body }}
      </p>
      <div class="flex">
        <div class="w-full">
          <div class="flex justify-end items-center">
            <!-- <PostReply /> -->
            <PostFavorite 
            :post_id="post.id" 
            :favorite_quantity="post.favorite"
            />
          </div>
        </div>
      </div>  
    </div>
    <hr class="border-gray-600">
  </div>
  <UpdatePostForm 
  :showUpdateArea = postUpdateArea
  :updatePostContent = identifyPostUpdate
  @closeUpdateFormModal = "postUpdateArea = $event" 
  />
</div>
</template>

<script>
import PostUserinfo from './PostUserinfo.vue'
import PostReply from './PostReply.vue'
import PostFavorite from './PostFavorite.vue'
import PostDrawer from './PostDrawer.vue'
import UpdatePostForm from '../PostForm/UpdatePostForm.vue'
import Loading from '../Loading.vue'
import { post_list_fetch } from '../../../plugins/post-list-fetch.js'
import { mypage_post_list_fetch } from '../../../plugins/post-list-fetch.js'
export default {
  components: {
    PostUserinfo,
    PostReply,
    PostFavorite,
    PostDrawer,
    UpdatePostForm,
    Loading
  },
  props: {
    page: {
      type: String
    }
  },
  data() {
    return {
      isLoading: true,
      postDrawerBoolean: false,
      selectedPost: null,
      postUpdateArea: false,
      identifyPostUpdate: null,
      currentUser: this.$store.getters.current_user
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
      if (this.page === 'mypage') {
        return this.$store.getters.mypostList
      }
      else {
        return this.$store.getters.postList
      }
    },
  },
  watch: {
    postUpdateArea: function (newVal) {
      if (newVal === true) {
        for (let i = 0; i < this.showPostList.length; i++){
          if (this.showPostList[i].id === this.selectedPost) {
            this.identifyPostUpdate = this.showPostList[i]
            break
          }
        }
      }
    }
  },
  async created() {
    if (this.showPostList.length > 0) {
      this.isLoading = false
    }
    if (this.page === 'mypage') {
      await mypage_post_list_fetch()
    }
    else {
      await post_list_fetch()
    }
    this.isLoading = false
  },
  mounted() { 
    // ドロワー表示中に画面をクリックした際にドロワーを閉じる
    const $this = this
    document.addEventListener("click", function (e) {
      const targetPostDrawer = (e.target).closest(".post-drawer-icon")
      if (targetPostDrawer === null && $this.postDrawerBoolean) {
        $this.showPostDrawer()
      }
    // 投稿更新用のモーダルを閉じる
      const targetPostUpdateArea = (e.target).closest(".post-update-modal")
      const postUpdateButton = (e.target).closest(".post-update-button")
      if (targetPostUpdateArea === null && $this.postUpdateArea && !postUpdateButton) {
        $this.postUpdateArea = false
      }
    })
  }
}
</script>

<style lang="scss" scoped>
  
</style>