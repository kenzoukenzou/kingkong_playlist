<template>
  <div v-if="video.id">
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
            v-model="bookmark.content"
            @focus="getCurrentTime"
          >
          </v-text-field>
          <p class="grey--text">{{ bookmark.time | formatTime }}</p>
          <v-btn dark class="font-weight-bold" @click="addBookmark">追加</v-btn>
        </v-form>
      </v-col>
    </v-row>
  </div>
  <div v-else>
    <p class="grey--text text-center mt-4">お探しの動画は見つかりませんでした。</p>
  </div>
</template>


<script>
import axios from 'axios'

export default {
  name: 'VideoShow',
  data() {
    return {
      video: {},
      bookmark: {
        video_id: this.$route.params.id,
        content: '',
        time: 0,
      },
      palyerVars: {
        autoplay: 1
      },
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
        this.bookmark.time = time;
      })
    },
    addBookmark() {
      axios
        .post(`${process.env.VUE_APP_ENDPOINT}/v1/bookmarks`, this.bookmark)
        .then(() => {
          this.bookmark.time = 0;
          this.bookmark.content = '';
          this.player.playVideo();
        })
    }
  }
}
</script>