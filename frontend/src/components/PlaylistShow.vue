<template>
  <div>
    <v-row v-if="playlist.videos">
      <v-col>
        <youtube
          :video-id="playVideoId"
          :player-vars="{ autoplay: 1, playsinline : 1 }"
          ref="youtube"
        >
        </youtube>
      </v-col>
      <v-col>
        <v-card outlined id="scroll-target" style="max-height: 350px" class="overflow-y-auto">
          <v-list
            style="height: 350px"
          >
            <v-subheader>{{ playlist.title }}</v-subheader>
            <v-list-item-group color="primary">
              <v-list-item
                v-for="bookmark in playlist.bookmarks"
                :key="bookmark.id"
                @click="startVideo(bookmark.video.youtube_key, bookmark.time)"
              >
                <v-list-item-content>
                  <v-list-item-subtitle class="purple--text">{{ bookmark.time | formatTime }}</v-list-item-subtitle>
                  <v-list-item-title >{{ bookmark.content }}</v-list-item-title>
                  <v-list-item-subtitle>{{ bookmark.video.title }}</v-list-item-subtitle>
                </v-list-item-content>
              </v-list-item>
            </v-list-item-group>
          </v-list>
        </v-card>

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
      playlist: {},
      playVideoId: '',
    }
  },
  mounted() {
    axios
      .get(`${process.env.VUE_APP_ENDPOINT}/v1/playlists/${this.$route.params.id}`)
      .then(res => {
        this.playlist = res.data;
        this.playVideoId = res.data.videos[0].youtube_key;
      })
  },
  methods: {
    // IDが切り替わったとき読み込みに時間がかかるのでsetTimeoutで開始位置を移動させている
    startVideo(videoId, time) {
      if (this.playVideoId === videoId) {
        this.player.seekTo(time)
      } else {
        this.playVideoId = videoId;
        setTimeout(()=> {
          this.player.seekTo(time);
        }, 1000)
      }
    }
  },
  computed: {
    player() {
      return this.$refs.youtube.player
    }
  }
}
</script>