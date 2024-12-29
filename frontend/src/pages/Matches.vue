<script setup>
import {DataTable, Column} from "primevue";
</script>

<script>
import axios from "axios"
export default {
  data() {
    return {
      matches: []
    }
  },
  methods: {
    getMatches() {
      const path = 'http://localhost:5000/matches';
      axios.get(path)
        .then((res) => {
          this.matches = res.data.matches;
        })
        .catch((error) => {
          console.error(error);
        });
    }
  },
  created() {
    this.getMatches();
  }
}
</script>

<template>
<h1>Список ближайших матчей...</h1>
  <DataTable :value="matches" tableStyle="min-width: 50rem">
    <Column field="tournament" header="Tournament" />
    <Column field="team1" header="Команда 1"></Column>
    <Column field="team2" header="Команда 2"></Column>
    <Column field="score" header="Счёт"></Column>
  </DataTable>
</template>