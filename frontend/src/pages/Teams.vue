<script setup>

import {Column, DataTable} from "primevue";
</script>

<template>

  <h1>Введите название команды, которую ищете...</h1>
  <InputText type="text" v-model="value" />
  <AutoComplete v-model="value" :suggestions="items" @complete="search" />

</template>

<style scoped>
h1 {
  @apply mt-5 mb-5 text-3xl;
}
</style>