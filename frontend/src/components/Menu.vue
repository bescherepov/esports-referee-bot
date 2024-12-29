<script setup>

</script>

<template>
  <header class="menu">
    <router-link to="/">Главная</router-link>
    <router-link to="/tour">Турниры</router-link>
    <router-link to="/matches">Матчи</router-link>
    <router-link to="/about">About</router-link>
  </header>
</template>

<style scoped>
  header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    background-color: cornflowerblue;

    height: 100px;
    padding-inline: 128px;
  }
  header a{
    font-family: sans-serif;
    text-decoration: none;
    color: white;
    font-size: 1.5em;
  }
</style>