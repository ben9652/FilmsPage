import Vue from 'vue'
import VueRouter from 'vue-router'
import HomeView from '../views/HomeView.vue'
import AboutView from '../views/AboutView.vue'
import ListaView from '../views/ListaView.vue'
import PeliculaView from '../views/PeliculaView.vue'
import ActorView from '../views/ActorView.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView,
    meta: {title: 'Películas'}
  },
  {
    path: '/about',
    name: 'about',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: AboutView
  },
  {
    path: '/peliculas',
    name: 'peliculas',
    component: ListaView,
    meta: {title: 'Lista de películas'}
  },
  {
    path: '/peliculas/:id',
    name: 'pelicula',
    component: PeliculaView,
    meta: {title: 'Película'}
  },
  {
    path: '/peliculas/:id/actores/:idActor',
    name: 'actor',
    component: ActorView,
    meta: {title: 'Actor'}
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
