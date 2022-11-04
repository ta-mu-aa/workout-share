import axios from "axios"
import { store } from '../store/index.js'

const post_list_fetch = async () => {
  await axios.get('/posts')
    .then(response => store.dispatch('getPostList', response.data))
    .catch(error => console.log(error))
}

export default post_list_fetch
