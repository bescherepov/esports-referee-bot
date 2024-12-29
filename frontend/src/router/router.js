import Main from "../pages/Main.vue";
import {createRouter, createWebHistory} from "vue-router";
import Matches from "../pages/Matches.vue";
import Tournaments from "../pages/Tournaments.vue";
import About from "../pages/About.vue";

const routes = [
    {
        path: '/',
        component: Main
    },
    {
        path: '/matches',
        component: Matches
    },
    {
        path: '/tour',
        component: Tournaments
    },
    {
        path: '/about',
        component: About
    }
]

const router = createRouter({
    routes,
    history: createWebHistory()
})

export default router;