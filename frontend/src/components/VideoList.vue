<template>
  <div>
    <v-row>
      <v-col v-for="n in 10" :key="n">
        <v-card
            class="mx-auto"
            max-width="400"
          >
          <v-img
            class="white--text align-end"
            height="200px"
            src="https://cdn.vuetifyjs.com/images/cards/docks.jpg"
          >
            <v-card-title>Top 10 Australian beaches</v-card-title>
          </v-img>
        
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
      
              <router-link :to="{ name: 'VideoShow', params: { id: 1 } }">
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
  export default {
    name: 'VideoList',
  }
</script>
