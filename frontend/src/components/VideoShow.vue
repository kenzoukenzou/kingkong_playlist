<template>
  <v-row>
    <v-col>
      <youtube
        :video-id="video.youtube_key"
        >
      </youtube>
      <p class="font-weight-bold">{{ video.title }}</p>
    </v-col>
    <v-col>
      <v-form>
        <v-text-field
          label="テキスト"
          required
        >
        </v-text-field>
        <v-btn dark class="font-weight-bold">追加</v-btn>
      </v-form>
    </v-col>
  </v-row>
</template>


<script>
import axios from 'axios'

export default {
  name: 'VideoShow',
  data() {
    return {
      video: {}
    }
  },
  mounted() {
    axios
      .get(`${process.env.VUE_APP_ENDPOINT}/v1/videos/${this.$route.params.id}`)
      .then(res => {
        this.video = res.data;
      })
  }
}
</script>