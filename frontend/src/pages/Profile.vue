<script setup>

</script>

<script>
import axios from "axios"
import {ref} from "vue";

export function roleName(role){
  switch(role){
    case "Ref":
      return 'Судья'
    case "GameRef":
      return "Главный судья дисциплины"
    case "GroupRef":
      return "Ответственный за группу дисциплин"
    case "MainRef":
      return "Глава отдела турниров Киберзоны"
    case "BOSS":
      return "Глава Киберспортивного центра РТУ МИРЭА"
    case "DemoGuest":
      return "Гость"
    default:
      return "Пользователь"
  }
}

export default {
  data() {
    return {
      profile_info: ref({}),
      role_name: "",
    }
  },
  methods: {
    getProfileInfo() {
      // todo use env url
      const path = 'http://localhost:5000/profile';
      axios.get(path)
        .then((res) => {
          this.profile_info = res.data.profile_info;
        })
        .catch((error) => {
          console.error(error);
        });
    }
  },
  created() {
    this.role_name = this.profile_info
    this.getProfileInfo();
  }
}
</script>

<template>
<p>{{ profile_info }}</p>
</template>

<style scoped>

</style>