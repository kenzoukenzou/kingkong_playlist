import Vue from 'vue'
import VueRouter from 'vue-router'
import VideoList from '@/components/VideoList'
import VideoShow from '@/components/VideoShow'
import VideoNew from '@/components/VideoNew'
import PlaylistNew from '@/components/PlaylistNew'
import Playlists from '@/components/Playlists'
import PlaylistShow from '@/components/PlaylistShow'
import About from '@/components/About'
import Login from '@/components/Login'
// import firebase from '../plugins/firebase'

Vue.use(VueRouter)

  const routes = [
  {
    path: '/',
    name: 'Home',
    component: VideoList
  },
  {
    path: '/playlists',
    name: 'Playlists',
    component: Playlists
  },
  {
    path: '/videos/:id(\\d+)',
    name: 'VideoShow',
    component: VideoShow
  },
  {
    path: '/playlists/:id(\\d+)',
    name: 'PlaylistShow',
    component: PlaylistShow
  },
  {
    path: '/videos/new',
    name: 'VideoNew',
    component: VideoNew,
    // TODO: 新しい認証の仕組みでガードする
    // beforeEnter: (to, from, next) => {
    //   firebase.auth().onAuthStateChanged((user) => {
    //     if (user) {
    //       next()
    //     } else {
    //       next({ name: 'Login' })
    //     }
    //   })
    // },
  },
  {
    path: '/playlists/new',
    name: 'PlaylistNew',
    component: PlaylistNew,
    // beforeEnter: (to, from, next) => {
    //   firebase.auth().onAuthStateChanged((user) => {
    //     if (user) {
    //       next()
    //     } else {
    //       next({ name: 'Login' })
    //     }
    //   })
    // },
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
