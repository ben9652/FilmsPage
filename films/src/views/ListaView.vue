<template>
    <div>
        <title>Lista de películas</title>
        <h2 style="font-size: 24px; color: #333; background-color: #f2f2f2; padding: 16px;">Películas existentes: {{ peliculas.length }}</h2>
        <div v-for="pelicula in peliculas" :key="pelicula.id">
            <div class="botones-container">
                <v-btn @click="$router.push('/peliculas/' + pelicula.id)" class="ma-2 elevation-2 boton" :style="{ width: `${pelicula.nombre.length*15}px`, height: `${altoBoton}px` }">
                    {{ pelicula.nombre }}
                </v-btn>
            </div>
        </div>
    </div>
</template>

<style>
.boton {
    margin-bottom: 10px;
    font-size: 16px;
    color: black;
    background-color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: all 0.2s ease-in-out;
}
.boton:hover {
    background-color: rgb(188, 188, 188);
    width: 110px;
    height: 60px;
}
.boton:active {
    background-color: rgb(147, 147, 147);
}

.botones-container {
    margin: 0 auto;
    display: flex;
    flex-direction: column;
    align-items: center;
}
</style>

<script>
    import axios from 'axios';
    export default {
        name: 'ListaView',
        data() {
            return {
                url: 'http://' + window.location.hostname + ':5000/peliculas',
                peliculas: [],
                anchoBoton: 100,
                altoBoton: 50,
                peliculaSeleccionada: null
            }
        },
        created() {
            axios.get(this.url)
                .then(response => {
                    this.peliculas = response.data[0]
                })
                .catch(error => {
                    console.log('No se pudieron obtener los datos.')
                    console.log(error)
                })
        }
    }
</script>
