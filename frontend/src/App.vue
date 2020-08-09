<template>
  <v-app>
    <v-main>
      <Navbar />
      <HelloWorld/>
    </v-main>
    <Footer />
  </v-app>
</template>

<script>
import HelloWorld from './components/HelloWorld';
import Navbar from './components/Navbar';
import Footer from './components/Footer';

export default {
  name: 'App',

  components: {
    HelloWorld,
    Navbar,
    Footer,
  },

  data: () => ({
    //
  }),
};
</script>
