<template>
  <v-row>
    <v-col>
      <iframe
        width="560"
        height="315"
        src="https://www.youtube.com/embed/1mszH5OqU5k"
        frameborder="0"
        allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
        allowfullscreen>
      </iframe>
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
export default {
  name: 'VideoShow',
}
</script>