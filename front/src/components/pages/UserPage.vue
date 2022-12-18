<template>
  <div>
    <div class="pt-12 pb-4 px-28">
      <div class="flex justify-start border-b border-solid border-gray-300 px-6 pb-4">
        <div class="px-14 py-6">
          <svg v-if="!userProfile.image_url" class="w-28 h-28 overflow-hidden rounded-full bg-gray-100 text-gray-300" fill="currentColor" viewBox="0 0 24 24">
            <path d="M24 20.993V24H0v-2.996A14.977 14.977 0 0112.004 15c4.904 0 9.26 2.354 11.996 5.993zM16.002 8.999a4 4 0 11-8 0 4 4 0 018 0z" />
          </svg>
          <figure v-if="userProfile.image_url" class="inline-block w-28 h-28 overflow-hidden rounded-full">
            <img :src=userProfile.image_url>
          </figure>
        </div>
        <div class="px-4 break-words">
          <div class="w-full my-4 flex items-center">
            <span class="font-semibold">{{ userProfile.name }}</span>
              <router-link :to="{ path: `setting/${userProfile.id}`}" v-if="currentUserFlag" class="flex cursor-pointer">
                <span class="ml-6 px-2 py-1 text-xs font-semibold rounded-md border border-solid border-gray-400">プロフィールを編集</span>
                <svg class="w-6 h-6 text-gray-600 ml-1" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z">
                </path>
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
              </svg>
            </router-link>
            <span 
              @click="following(userProfile.id)" v-if="(!currentUserFlag && !followingStatus)" 
              class="ml-6 px-4 py-1 cursor-pointer font-semibold rounded-full text-xs border-2 border-solid border-blue-400 text-white bg-blue-400 cousor-pointer" >フォロー</span>
            <span 
              @click="unfollow(userProfile.id)" v-if="(!currentUserFlag && followingStatus)" 
              class="ml-6 px-4 py-1 cursor-pointer font-semibold rounded-full text-xs border-2 border-solid border-blue-400 bg-white text-blue-400 cousor-pointer" >フォロー中</span>
          </div>
          <div class="flex mb-4">
            <span class="mr-6 text-sm">フォロワー<span class="font-bold">{{ UserRelationshipsList.followerUser.length }}</span>人</span>
            <span class="text-sm">フォロー中<span class="font-bold">{{ UserRelationshipsList.followingUser.length }}</span>人</span>
          </div>
          <span class="w-full">{{ userProfile.user_discription }}</span>
        </div>
      </div>
    </div>
    <div class="flex justify-center h-full pb-20 pt-4">
      <div class="container">
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
import post_list_fetch from '../../../plugins/post-list-fetch.js'
import user_relationship_fetch from '../../../plugins/user-relationship-fetch.js'
export default {
  components: {
    Post
  },
  async beforeRouteEnter(to, from, next) {
    await user_relationship_fetch(to)
    next()
  },
  data() {
    return {
      currentUserFlag: false,
      userProfile: {},
      UserRelationshipsList: {
        followingUser: [],
        followerUser: []
      },
      followingStatus: false
    }
  },
  methods: {
    setUserRelationshipInfo() {
      const curretUser = this.$store.getters.current_user
      let user_id = this.$route.params.id
      user_id === curretUser.id ? this.currentUserFlag = true : this.currentUserFlag = false
      if (this.currentUserFlag) {
        this.userProfile = this.$store.getters.current_user
      }
      else {
        this.userProfile = this.$store.getters.userPage
      }
      this.UserRelationshipsList.followingUser = this.$store.getters.followingUser
      this.UserRelationshipsList.followerUser = this.$store.getters.followerUser
      this.UserRelationshipsList.followerUser.forEach(followerUser => {
        if (followerUser.id === this.$store.getters.current_user.id) {
          this.followingStatus = true
        }
      })
    },
    following(following_user_id) {  //フォローするメソッド
      this.axios.post(`/user/${following_user_id}/relationships`)
        .then(() => {
          this.followingStatus = true
          const currentUser = this.$store.getters.current_user
          this.UserRelationshipsList.followerUser.push({ id: currentUser.id, name: currentUser.name, discription: currentUser.user_discription, icon: currentUser.image_url })
        })
        .catch(() => {
          const message = 'フォローするユーザーが見つかりません'
          this.$store.dispatch('getToast', { message })
        })
    },
    unfollow(unfollowing_user_id) {  //フォロー解除するメソッド
      if (window.confirm('フォローを解除しますか？')) {  
        this.axios.delete(`/user/${unfollowing_user_id}/relationships`)
        .then(() => {
          this.followingStatus = false
          this.UserRelationshipsList.followerUser =
            this.UserRelationshipsList.followerUser.filter(unfollow_user => {
            unfollow_user.id === this.$store.getters.current_user.id
          })
        })
        .catch(() => {
          const message = 'ユーザーが見つかりません'
          this.$store.dispatch('getToast', { message })
        })
      }
    }
  },
  async created() {
    this.setUserRelationshipInfo()
    await post_list_fetch()
  },
  watch: {
    // URLパラメータの変更を検知して反映させる
    $route(to, from) {
      this.setUserRelationshipInfo()
    }
  }
}
</script>

<style lang="scss" scoped>

</style>