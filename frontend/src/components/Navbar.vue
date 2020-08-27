<template>
  <nav>
    <v-app-bar dark app>
      <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>
      <v-spacer></v-spacer>
      <router-link :to="{ name: 'Home' }" class="white--text text-decoration-none">
        <v-toolbar-title class="font-weight-bold">キングコングプレイリスト </v-toolbar-title>
      </router-link>
      <v-spacer></v-spacer>
    </v-app-bar>

    <v-navigation-drawer
      v-model="drawer"
      app>
      <v-list>
        <v-list-item-group color="primary">
          <router-link :to="{ name: 'About' }">
            <v-list-item>
                <v-list-item-content>
                  <v-list-item-title>
                    <v-btn icon>
                      <v-icon>mdi-help-circle-outline</v-icon>
                    </v-btn>
                    このサイトについて
                  </v-list-item-title>
                </v-list-item-content>
            </v-list-item>
          </router-link>

          <template v-if="user">
            <router-link :to="{ name: 'VideoNew' }">
              <v-list-item>
                  <v-list-item-content>
                    <v-list-item-title>動画登録</v-list-item-title>
                  </v-list-item-content>
              </v-list-item>
            </router-link>

            <router-link :to="{ name: 'PlaylistNew' }">
              <v-list-item>
                  <v-list-item-content>
                    <v-list-item-title>プレイリスト作成</v-list-item-title>
                  </v-list-item-content>
              </v-list-item>
            </router-link>

            <!-- ログイン, ログアウト -->
            <v-list-item @click="signOut">
              <v-list-item-content>
                <v-list-item-title>ログアウト</v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </template>

          <template v-else>
            <router-link :to="{ name: 'Login' }">
              <v-list-item>
                  <v-list-item-content>
                    <v-list-item-title>
                      <v-btn icon>
                        <v-icon>mdi-login-variant</v-icon>
                      </v-btn>
                      ログイン
                    </v-list-item-title>
                  </v-list-item-content>
              </v-list-item>
            </router-link>
          </template>

        </v-list-item-group>
      </v-list>
    </v-navigation-drawer>
  </nav>
</template>

<script>
import axios from 'axios'
import { store } from "../store/store"

export default {
  name: 'Navbar',
  data() {
    return {
      drawer: false,
    }
  },
  methods: {
    signOut() {
      axios
        .delete(`${process.env.VUE_APP_ENDPOINT}/v1/logout`)
        .then(() => {
          this.$router.push('/login');
          store.commit('setUser', null);
        })
    }
  },
  computed: {
    user() {
      return this.$store.state.currentUser;
    }
  },
}
</script>