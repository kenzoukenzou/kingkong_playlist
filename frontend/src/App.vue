<template>
  <v-app>
    <v-main>
      <Navbar />
      <v-container>
        <router-view/>
      </v-container>
    </v-main>
    <Footer />
  </v-app>
</template>

<script>
import Navbar from '@/components/Navbar';

export default {
  components: {
    Navbar,
  }
}
</script>

<style>
a {
  text-decoration: none;
}
</style>
