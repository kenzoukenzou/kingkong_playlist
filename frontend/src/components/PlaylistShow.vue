<template>
  <div>
    <v-row v-if="playlist.videos">
      <v-col class="col-12 col-lg-7 col-md-7">
        <youtube
          :video-id="playVideoId"
          :player-vars="{ playsinline : 1 }"
          ref="youtube"
        >
        </youtube>
        <!-- スマホ表示の際順番が狂うので非表示 -->
        <div class="d-none d-lg-block">
          <Banner />
          <p class="font-weight-bold mt-5">他のプレイリスト</p>
          <PlaylistCards :playlists="otherPlaylists" />
        </div>
      </v-col>
      <v-col class="col-12 col-lg-5 col-md-5">
        <v-card outlined id="scroll-target" style="max-height: 350px" class="overflow-y-auto">
          <v-list
            style="height: 350px"
          >
            <v-subheader class="font-weight-bold">{{ playlist.title }}</v-subheader>
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
        <p class="font-weight-bold my-3">このプレイリストの動画</p>
        <VideoCards :videos="playlist.videos" />
      </v-col>
    </v-row>
  </div>
</template>

<script>
import axios from 'axios'
import Banner from './Banner'
import VideoCards from './VideoCards'
import PlaylistCards from './PlaylistCards'

export default {
  name: 'PlaylistShow',
  components: {
    Banner,
    VideoCards,
    PlaylistCards
  },
  data() {
    return {
      playlist: {},
      playVideoId: '',
      otherPlaylists: []
    }
  },
  mounted() {
    axios
      .get(`${process.env.VUE_APP_ENDPOINT}/v1/playlists/${this.$route.params.id}`)
      .then(res => {
        this.playlist = res.data[0].playlist;
        this.playVideoId = res.data[0].playlist.videos[0].youtube_key;
        this.otherPlaylists = res.data[0].other_playlists;
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