const express = require('express')
const app = express()

// Delete me to trigger a deploy!

// REST endpoint that sends a message and timestamp
app.get('/', (req, res) => {
  res.json({"message": "Automate all the things!",
  "timestamp": Math.floor(Date.now() / 1000)})
})

// Required for Jest test
module.exports = app