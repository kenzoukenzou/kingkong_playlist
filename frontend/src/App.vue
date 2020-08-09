<template>
  <v-app>
    <v-main>
      <Navbar />
      <VideoList/>
    </v-main>
    <Footer />
  </v-app>
</template>

<script>
import VideoList from './components/VideoList';
import Navbar from './components/Navbar';
import Footer from './components/Footer';

export default {
  name: 'App',

  components: {
    VideoList,
    Navbar,
    Footer,
  },

  data: () => ({
    //
  }),
};
</script>
