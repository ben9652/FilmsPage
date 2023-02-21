<template>
  <v-app>
    <v-main>
      <router-view></router-view>
    </v-main>
  </v-app>
</template>

<script>
  // import axios from 'axios'
  export default {
    name: 'App',
    watch: {
      $route: {
        immediate: true,
        handler(to) {
          document.title = to.meta.title || 'Películas';
        }
      }
    }
  };
</script>
