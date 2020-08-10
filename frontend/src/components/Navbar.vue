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
      <v-list
        v-scroll:#scroll-target="onScroll"
        style="height: 350px"
      >
        <v-list-item-group color="primary">
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>このサイトについて</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </v-list-item-group>
      </v-list>
    </v-navigation-drawer>
  </nav>
</template>

<script>
export default {
  name: 'Navbar',
  data() {
    return {
      drawer: false
    }
  }
}
</script>