<template>
  <v-app>
    <v-content>
        <nuxt />
    </v-content>
    <v-footer
      :fixed="fixed"
      app
    >
      <span>&copy; 2020</span>
    </v-footer>
  </v-app>
</template>

<script>
export default {
  data () {
    return {
    }
  }
}
</script>
