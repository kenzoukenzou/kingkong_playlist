<template>
  <div>
    <v-row>
      <v-col v-for="video in videos" :key="video.id">
        <v-card
            class="mx-auto"
            max-width="400"
          >
          <router-link :to="{ name: 'VideoShow', params: { id: video.id } }">
            <v-img
              class="white--text align-end"
              height="200px"
              :src="video.thumbnail"
            >
              <v-card-title>{{ video.title }}</v-card-title>
            </v-img>
          </router-link>
          <v-card-subtitle class="pb-0">Number 10</v-card-subtitle>
          <v-card-text class="text--primary">
            <div>Whitehaven Beach</div>
            <div>Whitsunday Island, Whitsunday Islands</div>
          </v-card-text>
          <v-card-actions>
            <v-btn
              color="orange"
              text
            >
              Share
            </v-btn>
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
