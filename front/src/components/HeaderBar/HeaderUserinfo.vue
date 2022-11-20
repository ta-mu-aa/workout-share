<template>
  <div ref="wrapper" class="relative settingDrawer_wrapper">
    <a href="#" class="flex-shrink-0 group block" @click="showDrower">
      <div class="flex items-center group-hover:opacity-60 duration-200">
        <div>
          <img class="inline-block  md:h-10 md:w-10 h-9 w-9  rounded-full"
            src="https://pbs.twimg.com/profile_images/1121328878142853120/e-rpjoJi_bigger.png" alt="" />
        </div>
        <div class="ml-3 hidden md:block">
          <p class="text-sm leading-6 font-medium">
            {{ currentUserInfo.name }}
          </p>
        </div>
      </div>
    </a>
    <div class="absolute top-11 -left-5 min-w-max p-5 shadow-lg text-sm bg-white" v-if="settingDrower">
      <router-link :to="{ path: `/setting/${currentUserInfo.id}` }"><div class="mb-2 cursor-pointer">設定</div></router-link>
      <div class="cursor-pointer" @click="Logout">ログアウト</div>
    </div>
  </div>
</template>

<script>
import { authLoginMethods } from '../../../mixins/auth.js'
export default {
  mixins: [authLoginMethods],
  data() {
    return {
      settingDrower: false,
    }
  },
  methods: {
    showDrower() {
      this.settingDrower = !this.settingDrower
    },
    async Logout() {
      await this.logout()
      this.$router.push('/login')
    }
  },
  computed: {
    currentUserInfo() {
      return this.$store.getters.current_user
    }
  },  
  mounted() {
    const $this = this
    document.addEventListener("click", function (e) {
      const target = (e.target).closest(".settingDrawer_wrapper");
      if (target === null) {
        $this.settingDrower = false
      }
    })
  }
}
</script>