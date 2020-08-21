<template>
  <div v-if="video.id">
    <v-row>
      <!-- Video -->
      <v-col class="col-12 col-lg-7 col-md-7">
        <youtube
          :video-id="video.youtube_key"
          ref="youtube"
          :player-vars="palyerVars"
          class="mt-4"
        >
        </youtube>

        <!-- Bookmarks -->
        <v-card outlined id="scroll-target" style="max-height: 250px" class="overflow-y-auto" v-if="bookmarks && bookmarks.length > 0">
          <v-list
            v-scroll:#scroll-target="onScroll"
            style="height: 350px"
          >
            <v-list-item-group color="primary">
              <v-list-item
                v-for="bookmark in bookmarks"
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

        <!-- Bookmark Form -->
        <v-form @submit.prevent="addBookmark" class="mt-3" v-if="user">
          <v-select
            label="プレイリストを選択"
            :items="playlists"
            v-model="bookmark.playlist_id"
            @change="getCurrentTime"
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
            <v-btn dark class="font-weight-bold mt-0 pt-0" type="submit">追加</v-btn>
          </div>
        </v-form>

        <!-- Related Playlists -->
        <template v-if="relatedPlaylists && relatedPlaylists.length > 0">
          <p class="font-weight-bold mt-5">関連プレイリスト</p>
          <PlaylistCards :playlists="relatedPlaylists" :colSize="'col-6 col-lg-4 col-md-4'" />
        </template>

        <div class="mt-5">
          <Banner />
        </div>
      </v-col>
      
      <v-col>
        <!-- Other Video -->
        <VideoCards :videos="otherVideos" />
      </v-col>
    </v-row>
  </div>
  <div v-else>
    <p class="grey--text text-center mt-4">Loading...</p>
  </div>
</template>


<script>
import axios from 'axios'
import Banner from './Banner'
import VideoCards from './VideoCards'
import PlaylistCards from './PlaylistCards'

export default {
  name: 'VideoShow',
  components: {
    Banner,
    VideoCards,
    PlaylistCards,
  },
  data() {
    return {
      video: {},
      otherVideos: [],
      playlists: [],
      bookmarks: [],
      relatedPlaylists: [],
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
    this.getVideo();
    // Vuetifyのselectフィールドに合わせるため整形
    axios
      .get(`${process.env.VUE_APP_ENDPOINT}/v1/playlists`)
      .then((res) => {
        res.data[0].all_playlists.map((item) => {
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
          this.bookmark.time = 0;
          this.bookmark.content = '';
          this.player.playVideo();
          this.updateBookmarks();
          this.updatePlaylists();
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
          this.bookmarks = res.data[0].bookmarks;
        })
    },
    updatePlaylists() {
      axios
        .get(`${process.env.VUE_APP_ENDPOINT}/v1/videos/${this.$route.params.id}`)
        .then(res => {
          this.relatedPlaylists = res.data[0].video.playlists;
        })
    },
    deleteBookmark(id) {
      axios
        .delete(`${process.env.VUE_APP_ENDPOINT}/v1/bookmarks/${id}`)
        .then(() => {
          this.updateBookmarks();
          this.updatePlaylists();
        })
    },
    onScroll (e) {
      this.offsetTop = e.target.scrollTop
    },
    getVideo() {
      axios
        .get(`${process.env.VUE_APP_ENDPOINT}/v1/videos/${this.$route.params.id}`)
        .then(res => {
          this.video = res.data[0].video;
          this.bookmarks = res.data[0].bookmarks;
          this.relatedPlaylists = res.data[0].video.playlists;
          this.otherVideos = res.data[0].other_videos;
        })
    }
  },
  watch: {
    $route: 'getVideo'
  }
}
</script>
