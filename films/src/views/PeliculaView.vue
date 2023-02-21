<template>
    <div class="global-container">
        <div class="container-sinopsis-portada">
            <div class="sinopsis">
                <h2>Sinópsis</h2>
                <p>{{pelicula[0].sinopsis}}</p>
                <h3>Director: {{ pelicula[0].director }}</h3>
                <h3>Duración: {{ pelicula[0].duracion }}</h3>
            </div>
            <div class="portada">
                <img class="portada imagen" :src="rutaImagen" alt="portada_pelicula">
            </div>
        </div>
        <div class="actores">
            <h2>Actores</h2>
            <div class="actores botones">
                <button v-for="actor in actores"
                        :key="actor"
                        @click="$router.push({name: 'actor', params: {id: `${id}`, idActor: actor.id}})"
                        class="btn">
                    {{ actor.nombreCompleto }}
                </button>
            </div>
        </div>
    </div>
</template>

<style>
    .sinopsis h2 {
        font-size: 1.5rem;
        margin-bottom: 0.5rem;
        text-transform: uppercase;
        letter-spacing: 0.1rem;
        color: #333;
    }

    .global-container {
        display: flex;
        flex-wrap: wrap;
    }

    .container-sinopsis-portada {
        display: flex;
        flex-direction: row;
    }

    .sinopsis {
        flex: 1;
        padding: 20px;
    }

    .portada {
        flex: 0 0 300px;
        padding: 20px;
    }

    .portada.imagen {
        max-height: 500px;
    }

    .portada img {
        max-width: 100%;
        height: auto;
    }

    .actores {
        max-width: 100%
    }

    .actores h2 {
        font-size: 1.5rem;
        margin-bottom: 0.5rem;
        margin-left: 1rem;
        margin-top: 1rem;
        text-transform: uppercase;
        letter-spacing: 0.1rem;
        color: #333;
    }

    .actores.botones {
        display: flex;
        justify-content: left;
        flex-wrap: wrap;
        margin-top: 10px;
        margin-left: 15px;
    }


    .actores.botones button {
        border: none;
        background-color: white;
        box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.3);
        padding: 10px 15px;
        margin-right: 10px;
        margin-bottom: 10px;
        flex-basis: calc((100% - 20px) / 4); /* dividir en 4 columnas */
        min-width: 120px;
    }


    .actores.botones button:hover {
        background-color: #cfcece;
    }

    .actores.botones button:active {
        background-color: #828181;
    }

    @media screen and (max-width: 768px) {
        .container {
        flex-direction: column;
        }

        .sinopsis, .portada {
        flex: 1 1 100%;
        }

        .actores {
        justify-content: flex-start;
        }
    }

    @media screen and (max-width: 480px) {
        .btn {
        min-width: 80px;
        }
    }
</style>
  

<script>
    import axios from 'axios';
    
    export default {
        data() {
            return {
                url: 'http://' + window.location.hostname + ':5000/peliculas/',
                pelicula: null,
                actores: [],
                fotoPortada: '',
                id: ''
            }
        },
        created() {
            this.id = this.$route.params.id
    
            axios.get(this.url + this.id)
                .then(response => {
                    this.pelicula = response.data[0]
                    this.fotoPortada = this.pelicula[0].imagen
                    this.id = this.pelicula[0].idPelicula
                    let actor
                    for(actor of this.pelicula) {
                        this.actores.push({
                            id: actor.idActor,
                            nombreCompleto: actor.nombresActor + ' ' + actor.apellidosActor
                        })
                    }
                })
                .catch(error => {
                    console.log('No se pudieron obtener los datos.')
                    console.log(error)
                })
        },
        computed: {
            rutaImagen() {
                if(this.fotoPortada !== '')
                    return require(`@/assets/films/${this.fotoPortada}`);
                else
                    return require('@/assets/logo.png');
            }
        },
    }
</script>
  