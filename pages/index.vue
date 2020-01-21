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
    const Keycloak = require("keycloak-js");
    let initOptions = {
      'auth-server-url': "http://localhost:8080/auth",
      realm: "ws",
      clientId: "webapp",
      onLoad: "check-sso",
      'public-client' : true,
      'confidential-port ' : 0
    };
    var keycloak = new Keycloak(initOptions);
    let kc = await keycloak.init({
      promiseType: "native",
      onLoad: "login-required"
    });
    if (kc) {
      /*let response = await this.$axios.get("http://localhost:5000/api/v1/vol", {
        headers: {
          Accept: "application/json",
          Authorization: "Bearer" + keycloak.token
        }
      });
      this.data = response.data;*/

      var req = new XMLHttpRequest();
      req.open("GET", "http://localhost:5000/api/v1/vol", true);
      req.setRequestHeader("Accept", "application/json");
      req.setRequestHeader("Authorization", "Bearer " + keycloak.token);

      req.onreadystatechange = function() {
        if (req.readyState == 4) {
          if (req.status == 200) {
            alert("Success");
          } else if (req.status == 403) {
            alert("Forbidden");
          }
        }
      };

      req.send();
    }
  }
};
</script>
