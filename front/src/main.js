import { createApp } from 'vue'
import App from './App.vue'
import VueRouter from './router'
import './assets/styles/main.scss'
import './assets/styles/reset.scss'
import './assets/styles/tailwind.scss'

createApp(App).use(VueRouter).mount('#app')
