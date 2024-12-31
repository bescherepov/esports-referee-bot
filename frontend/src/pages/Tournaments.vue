<script setup>

import {Column, DataTable} from "primevue";
</script>

<template>
  <h1>Список ближайших турниров</h1>
  <DataTable :value="tournaments" tableStyle="min-width: 50rem">
    <Column field="tournament" header="Турнир" />
    <Column field="game" header="Дисциплина"></Column>
    <Column field="startDate" header="Начало турнира"></Column>
  </DataTable>
</template>

<style scoped>
h1 {
  @apply mt-5 mb-5 text-3xl;
}
</style>