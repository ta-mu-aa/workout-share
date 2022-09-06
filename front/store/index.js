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
      }
    }
  },
  mutations: {
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
    }
  },
  actions: {
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
    }
  },
  getters: {
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
    }
  }
})
