<template>
  <v-form class="mt-3">
    <v-text-field
      label="Email"
      required
    >
    </v-text-field>
    <v-text-field
      label="Password"
      required
      type="password"
    >
    </v-text-field>
    <v-btn dark>ログイン</v-btn>
  </v-form>
</template>

<script>
export default {
  name: 'Login',
}
</script>