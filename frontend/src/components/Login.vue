<template>
  <v-form class="mt-3">
    <p class="grey--text">管理者以外はログインできません。</p>
    <v-text-field
      label="Email"
      v-model="session.email"
      required
    >
    </v-text-field>
    <v-text-field
      label="Password"
      v-model="session.password"
      required
      type="password"
    >
    </v-text-field>
    <v-btn dark @click="login">ログイン</v-btn>
  </v-form>
</template>

<script>
import axios from 'axios'

export default {
  name: 'Login',
  data() {
    return {
      session: {
        email: '',
        password: ''
      }
    }
  },
  methods: {
    login() {
      axios
        .post(`${process.env.VUE_APP_ENDPOINT}/v1/sessions`, this.session)
        .then(res => {
          console.log(res)
        })
    }
  }
}
</script>