<template>
  <div class="text-center py-2 m-2 flex align-middle">
    <span class="m-auto text-sm text-gray-500 pt-2">{{ favoriteAll }}</span>
    <span @click="pressFavorite" class="w-12 mt-1 group flex items-center cursor-pointer text-gray-500 pr-3 pl-1 text-base leading-6 font-medium rounded-full hover:text-red-500 duration-150">
      <svg 
      fill="none"
      :class="{ 'fill-red-600': favoriteExists === true, 'stroke-red-600': favoriteExists === true}" 
      class="text-center h-7 w-6" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" stroke="currentColor" viewBox="0 0 24 24">
      <path d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"></path></svg>
    </span>
  </div>
</template>

<script>
export default {
  props: {
    post_id: {
      type: Number
    },
    favorite_quantity: {
      type: Array
    },
  },
  methods: {
    pressFavorite() {
      // いいねが押されている場合と押されていない場合
      if (this.favoriteExists) {
        this.deleteFavorite()
      } else {
        this.createFavorite()
      }
    },
    createFavorite() {
      this.axios.post(`/posts/${this.post_id}/favorites`)
        .then(
          this.favorite_quantity.push({user_id: this.$store.getters.current_user.id })
        ) 
    },
    deleteFavorite() {
      this.axios.delete(`/posts/${this.post_id}/favorites`)
        .then(() => {
          let deleteIndex
          this.favorite_quantity.forEach((value, key) => {
            if (value.user_id === this.$store.getters.current_user.id) {
              deleteIndex = key              
            }
          })
          this.favorite_quantity.splice(deleteIndex, 1)
        }) 
    }
  },
  computed: {
    favoriteAll() {
      return this.favorite_quantity.length
    },
    favoriteExists() {
      const done_favorite_judge = this.favorite_quantity.some(favorite => favorite.user_id === this.$store.getters.current_user.id)
      return done_favorite_judge
    }
  }
}
</script>