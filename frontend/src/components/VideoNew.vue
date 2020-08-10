<template>
  <v-form @submit="addVideo">
    <v-text-field
      label="Youtube ID"
      required
      v-model="video.youtube_key"
    >
    </v-text-field>
    <v-btn dark class="font-weight-bold" type="submit">追加</v-btn>
  </v-form>
</template>

<script>
import axios from 'axios'

export default {
  name: 'VideoNew',
  data() {
    return {
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
          this.$router.push({ name: 'Home' })
        )
    }
  }
}
</script>