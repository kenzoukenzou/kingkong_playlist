import Vue from 'vue'
import App from './App.vue'
import vuetify from './plugins/vuetify';
import router from './router'
import VueYoutube from 'vue-youtube'

Vue.config.productionTip = false
Vue.use(VueYoutube)

// Filters
Vue.filter('truncate', function(value, length){
  if (value.length <= length) {
    return value;
  } else {
    return value.substring(0, 15) + '...';
  }
})

new Vue({
  vuetify,
  router,
  render: h => h(App)
}).$mount('#app')
