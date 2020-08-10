<template>
  <v-row>
    <v-col>
      <youtube
        :video-id="video.youtube_key"
        ref="youtube"
        :player-vars="palyerVars"
      >
      </youtube>
      <p class="font-weight-bold">{{ video.title }}</p>
    </v-col>
    <v-col>
      <v-form>
        <v-text-field
          label="テキスト"
          required
          @focus="getCurrentTime"
        >
        </v-text-field>
        <p class="grey--text">{{ currentTime | formatTime }}</p>
        <v-btn dark class="font-weight-bold">追加</v-btn>
      </v-form>
    </v-col>
  </v-row>
</template>


<script>
import axios from 'axios'

export default {
  name: 'VideoShow',
  data() {
    return {
      video: {},
      palyerVars: {
        autoplay: 1
      },
      currentTime: 0,
    }
  },
  computed: {
    player() {
      return this.$refs.youtube.player
    }
  },
  mounted() {
    axios
      .get(`${process.env.VUE_APP_ENDPOINT}/v1/videos/${this.$route.params.id}`)
      .then(res => {
        this.video = res.data;
      })
  },
  methods: {
    getCurrentTime() {
      this.player.pauseVideo();
      this.player.getCurrentTime().then(time => {
        this.currentTime = time;
      })
    }
  }
}
</script>