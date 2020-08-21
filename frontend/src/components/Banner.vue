<template>
  <div>
    <h3 class="font-weight-bold">キングコングを応援する</h3>
    <v-banner outlined class="mt-3">
      <v-avatar
        slot="icon"
        color="deep-purple accent-4"
        size="40"
      >
        <v-img src="https://salon.jp/img/img_top_thumb05.jpg">
        </v-img>
      </v-avatar>
      西野亮廣エンタメ研究所
      <template v-slot:actions>
        <v-btn text color="deep-purple accent-4" href="https://salon.jp/nishino">見てみる</v-btn>
      </template>
    </v-banner>
    
    <v-banner outlined class="mt-3">
      <v-avatar
        slot="icon"
        color="deep-purple accent-4"
        size="40"
      >
        <v-img src="https://yt3.ggpht.com/a/AATXAJxrGbCOsu_f-CWScGgDAeVyFxbwlL3ls7Sa93Dz=s100-c-k-c0xffffffff-no-rj-mo">
        </v-img>
      </v-avatar>
      カジサックチャンネル
      <template v-slot:actions>
        <v-btn text color="deep-purple accent-4" href="https://www.youtube.com/channel/UC642pLj4GXSj-0Ybdx3ytmA">見てみる</v-btn>
      </template>
    </v-banner>
  </div>
</template>

<script>
export default {}
</script>


<style scoped>
  /* @see https://qiita.com/JotarO_Oyanagi/items/bd2262350949c7603b04 */
  .v-banner >>> .v-banner__wrapper {
    border-bottom: none!important;
  }
</style>