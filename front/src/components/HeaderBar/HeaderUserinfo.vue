<template>
  <div ref="wrapper" class="relative settingDrawer_wrapper">
    <a href="#" class="flex-shrink-0 group block" @click="showDrower">
      <div class="flex items-center group-hover:opacity-60 duration-200">
        <div class="flex align-middle">
          <span v-if="currentUserInfo.image_url" class=" h-10 w-10 inline-block md:w-12 md:h-12 overflow-hidden rounded-full">
            <img :src="currentUserInfo.image_url" alt="" />
          </span>
          <span v-if="!currentUserInfo.image_url" class=" h-10 w-10 inline-block md:w-12 md:h-12 overflow-hidden rounded-full bg-gray-100">
            <svg class="h-full w-full text-gray-300" fill="currentColor" viewBox="0 0 24 24">
              <path d="M24 20.993V24H0v-2.996A14.977 14.977 0 0112.004 15c4.904 0 9.26 2.354 11.996 5.993zM16.002 8.999a4 4 0 11-8 0 4 4 0 018 0z" />
            </svg>
          </span>
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