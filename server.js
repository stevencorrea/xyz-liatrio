const express = require('express')
const app = express()

app.get('/', (req, res) => {
  res.json({"message": "Automate all the things!",
  "timestamp": Math.floor(Date.now() / 1000)})
})

module.exports = app