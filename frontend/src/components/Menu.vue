<script setup>
import {version_app} from "../main.js";
</script>

<template>
  <header class="menu bg-blue-500 ps-0.5 pe-0.5 text-xl flex space-x-2">
    <router-link to="/">Главная</router-link>
    <router-link to="/tour">Турниры</router-link>
    <router-link to="/matches">Матчи</router-link>
    <router-link to="/teams">Команды</router-link>
<!--    <router-link to="/players">Игроки</router-link>-->

    <div class="fixed top-0 right-2">v{{version_app}}</div>
  </header>
</template>

<style scoped>
</style>