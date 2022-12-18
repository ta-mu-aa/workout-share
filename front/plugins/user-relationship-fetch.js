import axios from "axios";
import router from '../src/router'
import { store } from '../store/index.js'

const user_relationship_fetch = async (to) => {
  const user_id = to.params.id
  // ログインユーザー出なければ情報を取得
  if (user_id !== store.getters.current_user.id) {   
    await axios.get(`/user/${user_id}`)
    .then(res => {
      store.dispatch('getUserPageInfo', res.data)
    })
    .catch(() => {
      const message = 'ユーザーが見つかりません'
      router.push('/home')
      store.dispatch('getToast', { message })
    })
  }
  // フォローフォロワーユーザーを取得
  const fetchUserRelationshipsList = await axios.get(`/user/${user_id}/relationship_list`)
  store.dispatch('getUserRelationshipsList', fetchUserRelationshipsList.data)
}

export default user_relationship_fetch