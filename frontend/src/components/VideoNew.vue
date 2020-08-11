<template>
  <div>
    <v-form @submit="addVideo">
      <v-text-field
        label="YoutubeID"
        placeholder="https://youtube.com/xxx"
        required
        v-model="video.youtube_key"
      >
      </v-text-field>
      <v-btn dark class="font-weight-bold" type="submit">追加</v-btn>
    </v-form>
    <v-list>
      <v-list-item-group color="primary">
        <v-list-item
          v-for="video in videos"
          :key="video.id"
        >
          <v-list-item-content>
            <v-list-item-title>{{ video.title }}</v-list-item-title>
          </v-list-item-content>
          <v-btn @click="deleteVideo(video.id)">削除</v-btn>
        </v-list-item>
      </v-list-item-group>
    </v-list>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'VideoNew',
  data() {
    return {
      videos: [],
      video: {
        youtube_key: ''
      }
    }
  },
  methods: {
    addVideo: function() {
      axios
        .post(`${process.env.VUE_APP_ENDPOINT}/v1/videos`, this.video)
        .then(
          this.$router.push({ name: 'VideoNew' })
        )
    },
    deleteVideo: function(id) {
      axios
        .delete(`${process.env.VUE_APP_ENDPOINT}/v1/videos/${id}`)
        .then(()=> {
          this.updateVideos();
        })
    },
    updateVideos: function() {
      axios
        .get(`${process.env.VUE_APP_ENDPOINT}/v1/videos`)
        .then(res => {
          this.videos = res.data;
        })
      }
  },
  mounted() {
    this.updateVideos();
  }
}
</script>