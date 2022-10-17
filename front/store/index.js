import { createStore } from 'vuex' 

export const store = createStore({
  state() { 
    return {
      user: {
        current: null
      },
      auth: {
        token: null,
        expires: 0,
        payload: {}
      },
      toast: {
        message: null,
        color: 'bg-red-500',
        timeout: 4000
      },
      postFormModal: {
        isVisible: false
      },
    }
  },
  mutations: {
  // ユーザー認証
    setCurrentUser (state, payload) {
    state.user.current = payload
    },
    setAuthToken (state, payload) {
      state.auth.token = payload
    },
    setAuthExpires (state, payload) {
      state.auth.expires = payload
    },
    setAuthPayload (state, payload) {
      state.auth.payload = payload
    },
  // グローバルトースター
    setToast (state, payload) {
      state.toast = payload
    },
  // 投稿用フォーム表示切り替え
    setPostFormModal(state, payload) {
      state.postFormModal.isVisible = payload
    }
  },
  actions: {
  // ユーザー認証
    getCurrentUser ({ commit }, user) {
      commit('setCurrentUser', user)
    },
    getAuthToken ({ commit }, token) {
      commit('setAuthToken', token)
    },
    getAuthExpires ({ commit }, expires) {
      expires = expires || 0
      commit('setAuthExpires', expires)
    },
    getAuthPayload ({ commit }, jwtPayload) {
      jwtPayload = jwtPayload || {}
      commit('setAuthPayload', jwtPayload)
    },
  // グローバルトースター
    getToast({ commit }, { message, color, timeout }) {
      color = color || 'bg-red-500'
      timeout = timeout || 4000
      commit('setToast', { message, color, timeout})
    },
  // 投稿用フォームモーダル表示切り替え
    getPostFormModal({ commit }, postModalPayload) {
        commit('setPostFormModal', postModalPayload)
    }
  },
  getters: {
  // ユーザー認証情報
    auth_token (state) {
      return  state.auth.token
    },
    auth_expires (state) {
      return  state.auth.expires
    },
    auth_payload (state) {
      return  state.auth.payload
    },
    current_user (state) {
      return  state.user.current || {}
    },
  // 投稿フォームモーダル
    postFormModal(state) {
      return state.postFormModal.isVisible
    }
  }
})
