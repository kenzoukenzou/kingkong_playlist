<template>
  <v-app>
    <v-main>
      <Navbar />
      <router-view/>
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
