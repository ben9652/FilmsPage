<template>
    <div class="profile">
        <div class="profile-title">
            <h2>{{ actor.nombres }} {{ actor.apellidos }}</h2>
        </div>
        <div class="separador"></div>
        <div v-if="fotoActor !== ''" class="profile-image">
            <img :src="rutaImagen" :alt="actor.nombres + ' ' + actor.apellidos">
        </div>
        <div v-else>Sin imagen</div>
        <div class="separador"></div>
        <div class="profile-birthdate">
            <p>Fecha de nacimiento: {{ formattedBirthdate }}</p>
        </div>
    </div>
  </template>
  
  <script>
  import axios from 'axios';
  export default {
    name: 'ActorView',
    data() {
        return {
            url: 'http://' + window.location.hostname + ':5000/peliculas/',
            actor: null,
            idPelicula: null,
            idActor: null,
            fotoActor: ''
        }
    },
    created() {
        this.idPelicula = this.$route.params.id
        this.idActor = this.$route.params.idActor
        this.url = this.url + this.idPelicula + '/actores/' + this.idActor
        console.log(this.url)
        axios.get(this.url)
            .then(response => {
                this.actor = response.data[0]
                if(this.actor.imagen !== null)
                    this.fotoActor = this.actor.imagen
            })
            .catch(error => {
                console.log('No se pudieron obtener los datos.')
                console.log(error)
            })
    },
    computed: {
        formattedBirthdate() {
            if(this.actor.nacimiento !== null) {
                const date = new Date(this.actor.nacimiento)
                const day = date.getDate()
                const month = new Intl.DateTimeFormat('es-ES', { month: 'long' }).format(date)
                const year = date.getFullYear()
                return `${day} de ${month} de ${year}`
            }
            else
                return 'No disponible'
        },
        rutaImagen() {
            if(this.fotoActor !== '')
                return require(`@/assets/actors/${this.fotoActor}`);
            else
                return 'No image';
        }
    }
  }
  </script>
  
<style scoped>
    .separador {
        width: 100%;
        margin: 10px 0;
        border-top: 1px solid #ccc;
    }

  .profile {
    display: flex;
    flex-direction: column;
    align-items: center;
    border: 1px solid #ccc;
    border-radius: 4px;
    padding: 20px;
    margin: 20px;
    max-width: 500px;
    min-width: 484px;
  }
  
  .profile h2 {
    font-size: 1.5rem;
    margin: 0;
    text-align: center;
  }
  
  .profile-image {
    margin: 20px 0;
  }
  
  .profile-image img {
    max-height: 350px;
    width: auto;
  }
  
  .profile-birthdate {
    font-size: 1.2rem;
  }
  </style>
  