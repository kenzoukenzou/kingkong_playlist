import Vue from 'vue'
import VueRouter from 'vue-router'
import VideoList from '@/components/VideoList'
import VideoShow from '@/components/VideoShow'
import VideoNew from '@/components/VideoNew'
import About from '@/components/About'
import Login from '@/components/Login'
import firebase from '../plugins/firebase'

Vue.use(VueRouter)

  const routes = [
  {
    path: '/',
    name: 'Home',
    component: VideoList
  },
  {
    path: '/videos/:id(\\d+)',
    name: 'VideoShow',
    component: VideoShow
  },
  {
    path: '/videos/new',
    name: 'VideoNew',
    component: VideoNew,
    beforeEnter: (to, from, next) => {
      firebase.auth().onAuthStateChanged((user) => {
        if (user) {
          next()
        } else {
          next({ name: 'Login' })
        }
      })
    },
  },
  {
    path: '/about',
    name: 'About',
    component: About
  },
  {
    path: '/login',
    name: 'Login',
    component: Login
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
