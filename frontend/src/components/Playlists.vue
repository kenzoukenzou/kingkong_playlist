<template>
  <div>
    <v-tabs centered>
      <v-tab to="/">動画一覧</v-tab>
      <v-tab to="/playlists">プレイリスト一覧</v-tab>
    </v-tabs>
    <v-row>
      <v-col
        class="col-lg-3 col-md-4n"
        v-for="p in playlists"
        :key="p.id"
      >
        <router-link :to="{ name: 'PlaylistShow', params: { id: p.id }}">
          <v-card
            class="mx-auto"
          >
            <v-img
              class="white--text align-end"
              height="200px"
              :src="p.thumbnail"
            >
            </v-img>
            <v-card-subtitle class="pb-0">{{ p.created_at | formatDateTime }}</v-card-subtitle>
            <v-card-text class="text--primary pb-0">
              <div>{{ p.title | truncate(15) }}</div>
            </v-card-text>
            <v-card-actions>
              <v-btn
                color="pink"
                text
              >
                Explore
              </v-btn>
            </v-card-actions>
          </v-card>
        </router-link>
      </v-col>
    </v-row>
  </div>
</template>

<script>
import axios from 'axios'

export default {
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