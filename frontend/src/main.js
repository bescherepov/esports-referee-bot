import { createApp } from 'vue'
import App from './App.vue'
import router from './router/router.js'
import PrimeVue from 'primevue/config';
import Aura from '@primevue/themes/aura'
import {version} from "../package.json"

const app = createApp(App)
export const version_app = version

app
    .use(router)
    .use(PrimeVue, {
        theme: {
            preset: Aura
        }
    })
    .mount('#app')
