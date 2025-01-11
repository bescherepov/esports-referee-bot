import Main from "../pages/Main.vue";
import {createRouter, createWebHistory} from "vue-router";
import Matches from "../pages/Matches.vue";
import Tournaments from "../pages/Tournaments.vue";
import About from "../pages/About.vue";
import Power from "../pages/Power.vue";
import Teams from "../pages/Teams.vue";
import Profile from "../pages/Profile.vue";

const routes = [
    {
        path: '/',
        component: Main
    },
    {
        path: '/matches',
        name: 'Matches',
        component: Matches
    },
    {
        path: '/tour',
        component: Tournaments
    },
    {
        path: '/about',
        component: About
    },
    {
        path: '/teams',
        component: Teams
    },
    {
        path: '/profile',
        component: Profile
    },
    {
        path: '/power',
        component: Power
    }
]

const router = createRouter({
    routes,
    history: createWebHistory()
})

export default router