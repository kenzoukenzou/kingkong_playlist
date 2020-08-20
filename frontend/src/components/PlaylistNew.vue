<template>
  <div>
    <v-form @submit.prevent="addPlaylist">
      <v-text-field
        placeholder="プレイリストのタイトル"
        required
        v-model="playlist.title"
      >
      </v-text-field>
      <v-btn dark class="font-weight-bold" type="submit">追加</v-btn>
    </v-form>
    <v-list>
      <v-list-item-group color="primary">
        <v-list-item
          v-for="playlist in playlists"
          :key="playlist.id"
        >
          <v-list-item-content>
            <v-list-item-title>{{ playlist.title }}</v-list-item-title>
          </v-list-item-content>
          <v-btn @click="deletePlaylist(playlist.id)">削除</v-btn>
        </v-list-item>
      </v-list-item-group>
    </v-list>
  </div>
</template>


<script>
import axios from 'axios'

export default {
  data() {
    return {
      playlists: [],
      playlist: {
        title: ''
      }
    }
  },
  name: 'PlaylistNew',
  mounted() {
    this.updatePlaylists();
  },
  methods: {
    addPlaylist() {
      axios
        .post(`${process.env.VUE_APP_ENDPOINT}/v1/playlists`, this.playlist)
        .then(() => {
          this.playlist.title = '';
          this.updatePlaylists();
        })
    },
    updatePlaylists() {
      axios
        .get(`${process.env.VUE_APP_ENDPOINT}/v1/playlists`)
        .then((res) => {
          this.playlists = res.data[0].all_playlists;
        })
    },
    deletePlaylist(id) {
      axios
        .delete(`${process.env.VUE_APP_ENDPOINT}/v1/playlists/${id}`)
        .then(() => {
          this.updatePlaylists();
        })
    }
  }
}
</script>