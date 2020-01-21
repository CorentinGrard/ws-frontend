<template>
  <v-layout column justify-center align-center>
    <h2>{{ username }}</h2>
    <v-data-table :headers="headers" :items="data"></v-data-table>
  </v-layout>
</template>

<script>
export default {
  data() {
    return {
      headers: [
        { text: "ID", value: "id" },
        { text: "Company", value: "company" },
        { text: "Place", value: "place" },
        { text: "Price", value: "price" },
        { text: "Date", value: "date" }
      ],
      username: "",
      data: []
    };
  },
  async created() {
    const Keycloak= require('keycloak-js')
    var keycloak = new Keycloak();
      keycloak
        .init({
          onLoad: "login-required",
          promiseType: "native"
        })
        .then(function(authenticated) {
          alert(authenticated ? "authenticated" : "not authenticated");
          if (authenticated) {
            loadData();
          }
        })
        .catch(function() {
          alert("failed to initialize");
        });

      var loadData = async function() {
          this.username =
          keycloak.idTokenParsed.preferred_username;
      myheaders = new Headers();
      myheaders.append("Authorization","Bearer " + keycloak.token)
        let body = {
          method: "GET",
          headers:myheaders,
          cache: "default"
        };

        let response = await fetch("http://127.0.0.1:5000/api/v1/vol", body);
        this.data = await response.json()
        console.log(this.data);
      };
  }
};
</script>
