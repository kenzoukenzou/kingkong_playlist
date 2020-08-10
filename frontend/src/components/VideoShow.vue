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

        <!-- Bookmarks -->
        <v-list>
          <v-list-item-group color="primary">
            <v-list-item
              v-for="bookmark in video.bookmarks"
              :key="bookmark.id"
              @click="startOnTime(bookmark.time)"
            >
              <v-list-item-content>
                <v-list-item-subtitle class="grey--text">{{ bookmark.time | formatTime }}</v-list-item-subtitle>
                <v-list-item-title>{{ bookmark.content }}</v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </v-list-item-group>
        </v-list>

        <v-form @submit.prevent="addBookmark">
          <v-text-field
            label="テキスト"
            required
            v-model="bookmark.content"
            @focus="getCurrentTime"
          >
          </v-text-field>
          <p class="grey--text">{{ bookmark.time | formatTime }}</p>
          <v-btn dark class="font-weight-bold" type="submit">追加</v-btn>
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
        content: '',
        time: 0,
      },
      palyerVars: {
        autoplay: 0
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
      // @see https://flaviocopes.com/how-to-merge-objects-javascript/
      axios
        .post(`${process.env.VUE_APP_ENDPOINT}/v1/bookmarks`, {...this.bookmark, ...{ video_id: this.video.id }})
        .then(() => {
          this.bookmark.time = 0;
          this.bookmark.content = '';
          this.player.playVideo();
        })
    },
    startOnTime(time) {
      this.player.pauseVideo();
      this.player.seekTo(time);
      this.player.playVideo();
    }
  }
}
</script>