<!-- Playlist詳細ページでは出力内容が異なるので共通化しない -->
<template>
  <v-card outlined id="scroll-target" style="max-height: 250px" class="overflow-y-auto">
    <v-list
      v-scroll:#scroll-target="onScroll"
      style="height: 350px"
    >
      <v-list-item-group color="primary">
        <v-list-item
          v-for="bookmark in bookmarks"
          :key="bookmark.id"
        >
          <v-list-item-content @click="startOnTime(bookmark.time)">
            <v-list-item-subtitle @click="startOnTime(bookmark.time)" class="purple--text">{{ bookmark.time | formatTime }}</v-list-item-subtitle>
            <v-list-item-title @click="startOnTime(bookmark.time)">{{ bookmark.content }}</v-list-item-title>
            <v-list-item-subtitle>{{ bookmark.playlist.title }}</v-list-item-subtitle>
          </v-list-item-content>
          <v-btn outlined @click="$emit('delete-bookmark', bookmark.id)" v-if="user">削除</v-btn>
        </v-list-item>
      </v-list-item-group>
    </v-list>
  </v-card>
</template>

<script>
export default {
  props: ['bookmarks'],
  data() {
    return {
      offsetTop: 0
    }
  },
  methods: {
    onScroll (e) {
      this.offsetTop = e.target.scrollTop
    },
    startOnTime(time) {
      this.player.pauseVideo();
      this.player.seekTo(time);
      this.player.playVideo();
    },
  },
  computed: {
    player() {
      return this.$parent.$refs.youtube.player
    },
    user() {
      return this.$store.state.currentUser;
    }
  },
}
</script>
