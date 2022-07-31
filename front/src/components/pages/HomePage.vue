<template>
<div>
  <nav class="flex items-center justify-between flex-wrap shadow-md p-4 fixed top-0 w-full z-30 bg-white">
    <div class="flex items-center flex-shrink-0  mr-6">
      <span class="font-semibold text-xl tracking-tight">workout-share</span>
    </div>
    <div class="block md:hidden">
      <button class="flex items-center px-3 py-2 border rounded">
        <svg class="fill-current h-3 w-3" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><title>Menu</title><path d="M0 3h20v2H0V3zm0 6h20v2H0V9zm0 6h20v2H0v-2z"/></svg>
      </button>
    </div>
    <div class="w-full hidden flex-grow md:flex md:items-center justify-end md:w-auto">
      <div class="mr-10">
        <a href="#responsive-header" class="block mt-4 md:inline-block md:mt-0 hover: mr-4">
          <svg class="mr-4 w-6 h-6 group-hover:opacity-60" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
        </a>
        <a href="#responsive-header" class="block mt-4 md:inline-block md:mt-0  hover: mr-4">
          <svg class="mr-4 h-6 w-6 group-hover:opacity-60" fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" stroke="currentColor" viewBox="0 0 24 24"><path d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"></path></svg>
        </a>
        <a href="#responsive-header" class="block mt-4 md:inline-block md:mt-0 hover:">
          <svg class="h-6 w-6 group-hover:opacity-60" fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" stroke="currentColor" viewBox="0 0 24 24"><path d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path></svg>
        </a>
      </div>
      <div class="flex-shrink-0 flex hover:bg-blue-00 rounded-full mr-2">
        <a href="#" class="flex-shrink-0 group block">
          <div class="flex items-center group-hover:opacity-60 duration-200">
            <div>
              <img class="inline-block h-10 w-10 rounded-full" src="https://pbs.twimg.com/profile_images/1121328878142853120/e-rpjoJi_bigger.png" alt="" />
            </div>
            <div class="ml-3">
              <p class="text-sm leading-6 font-medium ">
                筋トレ 太郎
              </p>
            </div>
          </div>
        </a>
      </div>
    </div>
  </nav>

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
export default {
  components: {
    Post
  }
}
</script>

<style lang="scss" scoped>
</style>