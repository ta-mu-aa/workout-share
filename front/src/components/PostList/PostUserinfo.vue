<template>
  <a href="#" class="flex items-center group-hover:opacity-60 duration-200">
    <div>
      <span v-if="postedUserIcon" class="h-10 w-10 inline-block overflow-hidden rounded-full">
        <img :src="postedUserIcon" alt="" />
      </span>
      <span v-if="!postedUserIcon" class="h-10 w-10 inline-block overflow-hidden rounded-full bg-gray-100">
        <svg class="h-full w-full text-gray-300" fill="currentColor" viewBox="0 0 24 24">
          <path d="M24 20.993V24H0v-2.996A14.977 14.977 0 0112.004 15c4.904 0 9.26 2.354 11.996 5.993zM16.002 8.999a4 4 0 11-8 0 4 4 0 018 0z" />
        </svg>
      </span>
    </div>
    <div class="ml-3">
      <span class="text-sm leading-6 font-medium ">
        {{ postedUserName }}
      </span>
    </div>
  </a>
</template>

<script>
export default {
  props: {
    postedUserName: {
      type:String
    },
    postedUserIcon: {
      type:String
    }
  }
}
</script>