<template>
  <v-layout
    column
    justify-center
    align-center
  >
    <v-flex
      xs12
      sm8
      md6
    >
      
    </v-flex>
 
     <v-data-table
      :headers="headers"
      :items="data"
    ></v-data-table>
  </v-layout>
</template>

<script>

export default {
  data() {
    return {
      headers: [
        { text: 'ID', value: 'id' },
        { text: 'Company', value: 'company' },
        { text: 'Place', value: 'place' },
        { text: 'Price', value: 'price' },
        { text: 'Date', value: 'date' },
      ],
      data: []
    }
  },
  async created() {
    let response = await this.$axios.get("http://localhost:5000/api/v1/vol");
    this.data = response.data


  },
}
</script>
