<template>
  <div :class="{ 'hidden': bannerShow === false }"
    class=" bg-red-600 rounded-md absolute top-8 left-0 right-0 mx-auto w-3/5">
    <div class="max-w-7xl mx-auto py-3 px-3 sm:px-6 lg:px-8">
      <div class="flex items-center justify-between flex-wrap">
        <div class="w-0 flex-1 flex justify-center">
          <p class="ml-3 font-medium text-white truncate">
            <span>{{ bannerMessage }}</span>
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    bannerShow: Boolean,
    bannerMessage: String
  }
}
</script>