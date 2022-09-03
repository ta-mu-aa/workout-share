import { createApp } from 'vue'
import App from './App.vue'
import VueRouter from './router'
import axios from 'axios'
import VueAxios from 'vue-axios'
import './assets/styles/main.scss'
import './assets/styles/reset.scss'
import './assets/styles/tailwind.scss'
const API_URL = import.meta.env.VITE_API_URL
axios.defaults.baseURL = API_URL
axios.defaults.withCredentials = true

const app = createApp(App)
  app.use(VueRouter)
  app.use(VueAxios, axios)
  app.mount('#app')