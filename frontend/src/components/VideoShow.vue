<template>
  <div v-if="video.id">
    <v-row>
      <v-col class="col-12 col-lg-6 col-md-6">
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
        <v-card outlined id="scroll-target" style="max-height: 350px" class="overflow-y-auto">
          <v-list
            v-scroll:#scroll-target="onScroll"
            style="height: 350px"
          >
            <v-list-item-group color="primary">
              <v-list-item
                v-for="bookmark in video.bookmarks"
                :key="bookmark.id"
              >
                <v-list-item-content>
                  <v-list-item-subtitle @click="startOnTime(bookmark.time)" class="purple--text">{{ bookmark.time | formatTime }}</v-list-item-subtitle>
                  <v-list-item-title @click="startOnTime(bookmark.time)">{{ bookmark.content }}</v-list-item-title>
                  <v-list-item-subtitle>{{ bookmark.playlist.title }}</v-list-item-subtitle>
                </v-list-item-content>
                <v-btn outlined @click="deleteBookmark(bookmark.id)" v-if="user">削除</v-btn>
              </v-list-item>
            </v-list-item-group>
          </v-list>
        </v-card>
        
        <v-form @submit.prevent="addBookmark" class="mt-3" v-if="user">
          <v-select
            label="プレイリストを選択"
            :items="playlists"
            v-model="bookmark.playlist_id"
          >
          </v-select>
          <v-text-field
            label="テキスト"
            required
            v-model="bookmark.content"
            @focus="getCurrentTime"
          >
          </v-text-field>
          <div class="d-flex justify-space-between pa-0 ma-0">
            <p class="grey--text">{{ bookmark.time | formatTime }}</p>
            <v-btn dark class="font-weight-bold" type="submit">追加</v-btn>
          </div>
        </v-form>
      </v-col>
    </v-row>
  </div>
  <div v-else>
    <p class="grey--text text-center mt-4">Loading...</p>
  </div>
</template>


<script>
import axios from 'axios'

export default {
  name: 'VideoShow',
  data() {
    return {
      video: {},
      playlists: [],
      bookmark: {
        content: '',
        time: 0,
        playlist_id: '',
      },
      palyerVars: {
        autoplay: 0,
        playsinline : 1,
      },
      offsetTop: 0,
    }
  },
  computed: {
    player() {
      return this.$refs.youtube.player
    },
    user() {
      return this.$store.state.currentUser;
    }
  },
  mounted() {
    axios
      .get(`${process.env.VUE_APP_ENDPOINT}/v1/videos/${this.$route.params.id}`)
      .then(res => {
        this.video = res.data;
      })
    // Vuetifyのselectフィールドに合わせるため整形
    axios
      .get(`${process.env.VUE_APP_ENDPOINT}/v1/playlists`)
      .then((res) => {
        res.data.map((item) => {
          this.playlists.push(
            { text: item.title, value: item.id }
          )
        })
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
          this.updateBookmarks();

          this.bookmark.time = 0;
          this.bookmark.content = '';
          this.player.playVideo();
        })
    },
    startOnTime(time) {
      this.player.pauseVideo();
      this.player.seekTo(time);
      this.player.playVideo();
    },
    updateBookmarks() {
      axios
        .get(`${process.env.VUE_APP_ENDPOINT}/v1/videos/${this.$route.params.id}`)
        .then(res => {
          this.video.bookmarks = res.data.bookmarks;
        })
    },
    deleteBookmark(id) {
      axios
        .delete(`${process.env.VUE_APP_ENDPOINT}/v1/bookmarks/${id}`)
        .then(() => {
          this.updateBookmarks();
        })
    },
    onScroll (e) {
      this.offsetTop = e.target.scrollTop
    },
  },
}
</script>
