<template>
  <v-row class="mt-3">
    <v-col
      class="col-12 col-lg-6 col-md-6 pt-0"
      v-for="p in playlists"
      :key="p.id"
    >
      <router-link :to="{ name: 'PlaylistShow', params: { id: p.id } }">
      <v-card
        class="mx-auto"
      >
        <v-img
          :src="p.thumbnail"
          class="white--text align-end"
        >
          <v-card-title class="font-weight-bold text-subtitle-2">{{ p.title }}</v-card-title>
        </v-img>
      </v-card>
      </router-link>
    </v-col>
  </v-row>
</template>


<script>
export default {
  props: ['playlists']
}
</script>