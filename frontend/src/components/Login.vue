<template>
  <v-form class="mt-3">
    <p class="grey--text">管理者以外はログインできません。</p>
    <v-text-field
      label="Email"
      v-model="email"
      required
    >
    </v-text-field>
    <v-text-field
      label="Password"
      v-model="password"
      required
      type="password"
    >
    </v-text-field>
    <v-btn dark @click="login">ログイン</v-btn>
  </v-form>
</template>

<script>
import firebase from '@/plugins/firebase';

export default {
  name: 'Login',
  data() {
    return {
      email: '',
      password: ''
    }
  },
  methods: {
    login() {
      firebase
        .auth()
        .signInWithEmailAndPassword(this.email, this.password)
        .then(() => {
          this.$router.push("/");
        })
    }
  }
}
</script>