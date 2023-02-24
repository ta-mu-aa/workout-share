import axios from "axios"
import { store } from '../store/index.js'

const post_list_fetch = async () => {
  await axios.get('/posts')
    .then(response => store.dispatch('getPostList', response.data))
    .catch(error => console.log(error))
}

const mypage_post_list_fetch = async () => {
  await axios.get(`posts/individual_post/${store.getters.current_user.id}`)
    .then(response => store.dispatch('getMyPostList', response.data)) 
    .catch(error => console.log(error))
}

export { post_list_fetch, mypage_post_list_fetch }
