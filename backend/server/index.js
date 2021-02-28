const express = require("express");
const bodyParser = require("body-parser");
const bcrypt = require("bcrypt");
const fetch = require("node-fetch");

const app = express();
app.use(bodyParser.urlencoded({ extended: true }));

const port = 3000;

app.post("/signup", (req, res) => {
  bcrypt.hash(req.body.password, 10, function (err, hash) {
    const password = hash;
    const username = req.body.username;
    const name = req.body.name;

    async function fetchGraphQL(operationsDoc, operationName, variables) {
      const result = await fetch("http://localhost:8080/v1/graphql", {
        method: "POST",
        body: JSON.stringify({
          query: operationsDoc,
          variables: variables,
          operationName: operationName,
        }),
      });

      return await result.json();
    }

    const operationsDoc = `
    mutation MyMutation {
      insert_user(objects: {name: "${name}", password: "${password}", username: "${username}"}) {
        returning {
          id
        }
      }
    }
  `;

    function executeMyMutation() {
      return fetchGraphQL(operationsDoc, "MyMutation", {});
    }

    async function startExecuteMyMutation() {
      const { errors, data } = await executeMyMutation();

      if (errors) {
        // handle those errors like a pro
        console.error(errors);
      }

      // do something great with this precious data
      res.send(data);
    }

    startExecuteMyMutation();
  });
});

app.post("/login", (req, res) => {
  clientUsername = req.body.username;
  clientPassword = req.body.password;

  /*
This is an example snippet - you should consider tailoring it
to your service.
*/

  async function fetchGraphQL(operationsDoc, operationName, variables) {
    const result = await fetch("http://localhost:8080/v1/graphql", {
      method: "POST",
      body: JSON.stringify({
        query: operationsDoc,
        variables: variables,
        operationName: operationName,
      }),
    });

    return await result.json();
  }

  const operationsDoc = `
    query MyQuery {
      user(where: {username: {_eq: "${clientUsername}", _is_null: false}}) {
        password
      }
    }
  `;

  function fetchMyQuery() {
    return fetchGraphQL(operationsDoc, "MyQuery", {});
  }

  async function startFetchMyQuery() {
    const { errors, data } = await fetchMyQuery();

    if (errors) {
      res.send("Username or password not found");
      // handle those errors like a pro
      console.error(errors);
    }

    // do something great with this precious data
    var userinfo = data["user"];
    var password = userinfo[0]["password"];

    bcrypt.compare(clientPassword, password, function (err, result) {
      result == true ? res.send("authorized") : res.send("password inncorrect");
    });
  }

  startFetchMyQuery();
});

app.post("/createfriend", (req, res) => {
  /*
This is an example snippet - you should consider tailoring it
to your service.
*/
  const friendId = req.body.friendId;
  const userId = req.body.userId;

  async function fetchGraphQL(operationsDoc, operationName, variables) {
    const result = await fetch("http://localhost:8080/v1/graphql", {
      method: "POST",
      body: JSON.stringify({
        query: operationsDoc,
        variables: variables,
        operationName: operationName,
      }),
    });

    return await result.json();
  }

  const operationsDoc = `
    mutation MyMutation {
      insert_friends(objects: {friend_id: "${friendId}", user_id: "${userId}"}) {
        returning {
          friend {
            name
            id
          }
          user {
            name
            id
          }
        }
      }
    }
  `;

  function executeMyMutation() {
    return fetchGraphQL(operationsDoc, "MyMutation", {});
  }

  async function startExecuteMyMutation() {
    const { errors, data } = await executeMyMutation();

    if (errors) {
      // handle those errors like a pro
      console.error(errors);
    }

    // do something great with this precious data
    res.send(data);
  }

  startExecuteMyMutation();
});
app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`);
});
