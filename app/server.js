const express = require('express')
const app = express()


// REST endpoint that sends a message and timestamp
app.get('/', (req, res) => {
  res.json({"message": "Automate all the things!",
  "timestamp": Math.floor(Date.now() / 1000)})
})

app.get('/new-feature', (req, res) => {
  res.json({"message": "Look at this shiny new feature Liatrio friends!"})
})

module.exports = app
