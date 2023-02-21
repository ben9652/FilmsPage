<template>
    <div class="home">
        <h1>Página de inicio</h1>
        <v-btn @click="$router.push('/peliculas')">Lista de películas</v-btn>
        <v-btn @click="$router.push('/about')">Acerca de la aplicación</v-btn>
    </div>
</template>

<script>
  export default {
    name: 'HomeView',
    
    data() {
      return {
        ip_addr: null
      }
    },
    created() {
      this.ip_addr = window.location.hostname
    }
  }
</script>
