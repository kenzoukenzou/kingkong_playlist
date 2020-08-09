<template>
  <v-app-bar
      app
      dark
    >
    <v-spacer></v-spacer>
    
    <router-link :to="{ name: 'VideoList' }" class="white--text text-decoration-none">
      <v-toolbar-title class="font-weight-bold">キングコングプレイリスト </v-toolbar-title>
    </router-link>
    
    <v-spacer></v-spacer>
  </v-app-bar>
</template>

<script>
export default {
  name: 'Navbar'
}
</script>