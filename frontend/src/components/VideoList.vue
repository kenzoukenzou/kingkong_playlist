<template>
  <div>
    <v-autocomplete
      v-model="query.title_cont"
      :items="searchItems"
      cache-items
      class="mx-4"
      hide-details
      prepend-icon="mdi-database-search"
      label="毎週キングコングの動画を検索"
      append-icon
    >
    </v-autocomplete>
    <v-tabs centered>
      <v-tab to="/">動画一覧</v-tab>
      <v-tab to="/playlists">プレイリスト一覧</v-tab>
    </v-tabs>
    <v-row>
      <template v-if="videos && videos.length > 0">
        <v-col class="col-12 col-lg-3 col-md-4" v-for="video in videos" :key="video.id">
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
        <v-col class="col-lg-3 col-md-4 col-12" v-for="n in 20" :key="n">
          <v-card
            class="mx-auto"
          >
            <v-skeleton-loader
              class="mx-auto"
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
        searchItems: [],
        query: {
          title_cont: ''
        }
      }
    },
    mounted() {
      axios
        .get(`${process.env.VUE_APP_ENDPOINT}/v1/videos`)
        .then(res => {
          this.videos = res.data;
          res.data.map((item) => this.searchItems.push(item.title));
        })
    }
  }
</script>
