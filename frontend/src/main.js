import Vue from 'vue'
import App from './App.vue'
import vuetify from './plugins/vuetify'
import router from './router'
import VueYoutube from 'vue-youtube'
import moment from 'moment'
import { store } from './store/store'
import authCheck from './plugins/authCheck'
import VueCookie from 'vue-cookie'

Vue.config.productionTip = false
Vue.use(VueYoutube)
Vue.use(authCheck)
Vue.use(VueCookie)

// Filters
Vue.filter('truncate', function(value, length){
  if (value.length <= length) {
    return value;
  } else {
    return value.substring(0, 15) + '...';
  }
})
Vue.filter('formatTime', function(value){
  const time = moment.utc(value*1000).format('HH:mm:ss');
  return time;
})
Vue.filter('formatDateTime', function(value){
  const datetime = moment(value).format("YYYY/MM/DD"); 
  return datetime;
})

new Vue({
  store: store,
  vuetify,
  router,
  render: h => h(App)
}).$mount('#app')
