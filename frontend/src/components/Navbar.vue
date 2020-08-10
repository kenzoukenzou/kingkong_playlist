<template>
  <nav>
    <v-toolbar dark>
      <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>
      <v-spacer></v-spacer>
      <router-link :to="{ name: 'Home' }" class="white--text text-decoration-none">
        <v-toolbar-title class="font-weight-bold">キングコングプレイリスト </v-toolbar-title>
      </router-link>
      <v-spacer></v-spacer>
    </v-toolbar>

    <v-navigation-drawer
      v-model="drawer"
      app>
      <v-list>
        <v-list-item-group color="primary">
          <router-link :to="{ name: 'About' }">
            <v-list-item>
                <v-list-item-content>
                  <v-list-item-title>このサイトについて</v-list-item-title>
                </v-list-item-content>
            </v-list-item>
          </router-link>

          <router-link :to="{ name: 'VideoNew' }" v-if="user.uid">
            <v-list-item>
                <v-list-item-content>
                  <v-list-item-title>動画登録</v-list-item-title>
                </v-list-item-content>
            </v-list-item>
          </router-link>

          <!-- ログイン, ログアウト -->
          <v-list-item @click="signOut" v-if="user.uid" >
            <v-list-item-content>
              <v-list-item-title>ログアウト</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
          <router-link :to="{ name: 'Login' }" v-else>
            <v-list-item>
                <v-list-item-content>
                  <v-list-item-title>ログイン</v-list-item-title>
                </v-list-item-content>
            </v-list-item>
          </router-link>

        </v-list-item-group>
      </v-list>
    </v-navigation-drawer>
  </nav>
</template>

<script>
import firebase from '@/plugins/firebase'

export default {
  name: 'Navbar',
  data() {
    return {
      drawer: false,
      user: {}
    }
  },
  mounted() {
    firebase.auth().onAuthStateChanged((user) => {
      if (user) {
        this.user = user;
      } else {
        this.user = {};
      }
    })
  },
  methods: {
    signOut() {
      firebase.auth().signOut().then(() => {
        this.$router.push('/login');
      }).catch((error) =>{
        console.log(error);
      })
    }
  }
}
</script>