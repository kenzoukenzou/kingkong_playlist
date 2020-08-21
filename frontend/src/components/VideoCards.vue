<template>
  <v-row class="mt-3" dense>
    <v-col
      v-for="v in videos"
      :key="v.id"
      cols="12"
    >
      <router-link :to="{ name: 'VideoShow', params: { id: v.id } }">
        <v-card
          outlined
        >
          <div class="d-flex flex-no-wrap">
            <v-avatar
              size="125"
              tile
            >
              <v-img :src="v.thumbnail"></v-img>
            </v-avatar>
            <div>
              <v-card-subtitle class="text--primary font-weight-bold pb-1">
                {{ v.title | truncate(15) }}
              </v-card-subtitle>
              <v-card-subtitle class="ma-0 pt-0">
                {{ v.published_at | formatDateTime }}
              </v-card-subtitle>
            </div>
          </div>
        </v-card>
      </router-link>
    </v-col>
  </v-row>
</template>

<script>
export default {
  props: ['videos']
}
</script>