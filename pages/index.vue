<template>
  <v-layout column justify-center align-center>
    <h2>Username : {{ username }}</h2>
    <h3>Vols</h3>
    <v-data-table :headers="headers_rest" :items="data_rest"></v-data-table>
    <h3>Hotels</h3>
    <v-data-table :headers="headers_soap" :items="data_soap"></v-data-table>
  </v-layout>
</template>

<script>
export default {
  data() {
    return {
      headers_rest: [
        { text: "ID", value: "id" },
        { text: "Company", value: "company" },
        { text: "Place", value: "place" },
        { text: "Price", value: "price" },
        { text: "Date", value: "date" }
      ],
      headers_soap: [
        { text: "Number", value: "number" },
        { text: "Prix", value: "prix" },
        { text: "Type", value: "type" },
        { text: "Occupe", value: "occupe" },
      ],
      username: "",
      data_rest: [],
      data_soap: []
    };
  },
  async created() {
    const Keycloak = require("keycloak-js");
    var keycloak = new Keycloak();
    let kc
    try {
      kc = await keycloak.init({
        onLoad: "login-required",
        promiseType: "native"
      });
    } catch (error) {
      console.error(error);
    }
    console.log(kc ? "authenticated" : "not authenticated");
    this.username = keycloak.idTokenParsed.preferred_username;
    let init = {
      method: "GET",
      headers: {
        "Authorization": "Bearer " + keycloak.token,
      }
    };
    let response_rest = await fetch("http://localhost:5000/api/v1/vol", init);
    if(response_rest.status == 200){
      this.data_rest = await response_rest.json();
    }else{
      console.error('erreur rest')
    }
    let response_soap = await fetch("http://localhost:5000/api/v1/hotel", init);
    if(response_soap.status == 200){
      this.data_soap = await response_soap.json();
    }else{
      console.error('erreur soap')
    }
  }
};
</script>
