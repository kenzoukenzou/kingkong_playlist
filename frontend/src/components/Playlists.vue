<template>
  <div>
    <v-tabs centered>
      <v-tab to="/">動画一覧</v-tab>
      <v-tab to="/playlists">プレイリスト一覧</v-tab>
    </v-tabs>
    <PlaylistCards :playlists="playlists" />
  </div>
</template>

<script>
import axios from 'axios'
import PlaylistCards from './PlaylistCards'

export default {
  components: {
    PlaylistCards,
  },
  data() {
    return {
      playlists: []
    }
  },
  name: 'Playlists',
  mounted() {
    axios
    .get(`${process.env.VUE_APP_ENDPOINT}/v1/playlists`)
      .then((res) => {
        this.playlists = res.data[0].have_bookmarks_playlists
      })
  }
}
</script>