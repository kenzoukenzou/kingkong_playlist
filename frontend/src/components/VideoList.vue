<template>
  <div>
    <v-tabs centered>
      <v-tab to="/">動画一覧</v-tab>
      <v-tab to="/playlists">プレイリスト一覧</v-tab>
    </v-tabs>
    <v-row>
      <template v-if="videos.length > 0">
        <v-col class="col-lg-3 col-md-4" v-for="video in videos" :key="video.id">
          <v-card
              class="mx-auto"
            >
            <router-link :to="{ name: 'VideoShow', params: { id: video.id } }">
              <v-img
                class="white--text align-end"
                height="200px"
                :src="video.thumbnail"
              >
              </v-img>
            </router-link>
            <v-card-subtitle class="pb-0">{{ video.published_at | formatDateTime }}</v-card-subtitle>
            <v-card-text class="text--primary pb-0">
              <div>{{ video.title | truncate(15) }}</div>
            </v-card-text>
            <v-card-actions>
                <router-link :to="{ name: 'VideoShow', params: { id: video.id } }">
                  <v-btn
                    color="orange"
                    text
                  >
                    Explore
                  </v-btn>
                </router-link>
            </v-card-actions>
          </v-card>
        </v-col>
      </template>
      <template v-else>
        <v-col class="col-lg-3 col-md-4" v-for="n in 20" :key="n">
          <v-card
          >
            <v-skeleton-loader
              class="mx-auto"
              max-width="300"
              type="card"
            ></v-skeleton-loader>
          </v-card>
        </v-col>
      </template>
    </v-row>
  </div>
</template>

<script>
import axios from 'axios'

  export default {
    name: 'VideoList',
    data() {
      return {
        videos: [],
      }
    },
    mounted() {
      axios
        .get(`${process.env.VUE_APP_ENDPOINT}/v1/videos`)
        .then(res => {
          this.videos = res.data;
        })
    }
  }
</script>
