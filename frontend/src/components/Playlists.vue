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
        <v-card
          class="mx-auto"
          max-width="344"
        >
          <v-img
            :src="p.thumbnail"
            height="200px"
          ></v-img>
          <v-card-title>
            {{ p.title }}
          </v-card-title>
          <v-card-actions>
            <v-btn
              color="purple"
              text
            >
              Explore
            </v-btn>
            <v-spacer></v-spacer>
          </v-card-actions>
        </v-card>
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
        this.playlists = res.data         
      })
  }
}
</script>