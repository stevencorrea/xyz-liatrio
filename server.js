const express = require('express')
const app = express()
const port = 3001

app.get('/', (req, res) => {
  res.json({"message": "Automate all the things!",
  "timestamp": Math.floor(Date.now() / 1000)})
})

app.listen(port, () => {
  console.log(`xyz app listening on port ${port}`)
})