<template>
  <div v-if="video.id">
    <v-row>
      <v-col class="col-12 col-lg-7 col-md-7">
        <!-- Video -->
        <youtube
          :video-id="video.youtube_key"
          ref="youtube"
          :player-vars="palyerVars"
          class="mt-4"
        >
        </youtube>

        <!-- Bookmarks -->
        <template v-if="bookmarks && bookmarks.length > 0">
          <Bookmarks :bookmarks="bookmarks" @delete-bookmark="deleteBookmark" />
        </template>
        
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

        <!-- Banner -->
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
import Bookmarks from './Bookmarks'

export default {
  name: 'VideoShow',
  components: {
    Banner,
    VideoCards,
    PlaylistCards,
    Bookmarks,
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
    deleteBookmark(id) {
      axios
        .delete(`${process.env.VUE_APP_ENDPOINT}/v1/bookmarks/${id}`)
        .then(() => {
          this.updateBookmarks();
          this.updatePlaylists();
        })
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
