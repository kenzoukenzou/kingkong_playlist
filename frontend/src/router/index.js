import Vue from 'vue'
import VueRouter from 'vue-router'
import VideoList from '@/components/VideoList'
import VideoShow from '@/components/VideoShow'

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
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
