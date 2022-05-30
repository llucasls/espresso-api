# Espresso API

The Espresso API. An API written in CoffeeScript using Express.js and MongoDB.

This API has five endpoints that reference a drinks entity. Those endpoints are:

<details>
  <summary>POST /drinks</summary>
  <p>
    This endpoint takes the request body and inserts a new document in the drinks
    collection. It accepts data formatted as JSON, YAML or URL encoded forms.
  </p>
</details>
<details>
  <summary>GET /drinks</summary>
  <p>
    This endpoint returns all the documents from the drinks collection.
    It accepts query parameters to filter data (e.g. /drinks?price=500).
    It also uses a special parameter format, to change the format of the data returned.
    The accepted values are json (default) and yaml (e.g. /drinks?price=500&format=yaml).
  </p>
</details>
<details>
  <summary>GET /drinks/:id</summary>
  <p>
    This endpoint returns one document from the drinks collection, selected by its id.
  </p>
</details>
<details>
  <summary>PUT /drinks/:id</summary>
  <p>
    This endpoint searches for a specific document by its id and updates all the
    attributes.
  </p>
</details>
<details>
  <summary>DELETE /drinks/:id</summary>
  <p>
    This endpoint searches for a specific document by its id and removes it from the
    drinks collection.
  </p>
</details>
