<template>
  <v-form class="mt-3">
    <p class="grey--text">管理者以外はログインできません。</p>
    <p class="red--text">{{ message }}</p>
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
      },
      message: ''
    }
  },
  methods: {
    login() {
      // refs: https://qiita.com/hxrxchang/items/d51a27f486fcd1612dbf
      axios.defaults.withCredentials = true
      axios
        .post(`${process.env.VUE_APP_ENDPOINT}/v1/sessions`, this.session)
        .then(() => {
          this.$router.push('/');
        })
        .catch((error) => {
          // TODO: エラーメッセージ適切なやつを出したい
          this.message = error.message;
        })
    }
  }
}
</script>