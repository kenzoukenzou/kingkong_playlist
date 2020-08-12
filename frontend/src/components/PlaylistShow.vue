<template>
  <div>
    <v-row v-if="playlist.videos">
      <v-col>
        <youtube
          :video-id="playlist.videos[0].youtube_key"
          ref="youtube"
        >
        </youtube>
      </v-col>
    </v-row>    
  </div>
</template>

<script>
import axios from 'axios'
export default {
  name: 'PlaylistShow',
  data() {
    return {
      playlist: {}
    }
  },
  mounted() {
    axios
      .get(`${process.env.VUE_APP_ENDPOINT}/v1/playlists/${this.$route.params.id}`)
      .then(res => {
        this.playlist = res.data;
      })
  }
}
</script>