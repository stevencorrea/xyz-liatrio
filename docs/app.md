# Application Documentation

This is a simple app that satisfies the following requirement:
> REST endpoint that returns a JSON payload of current timestamp and a message

This will be a Node app using the express framework to create an endpoint. We will serve the JSON payload upon a GET to the endpoint.

We will construct the message object by declaring a variable with the timestamp value invoking the Date.now() method.

### Steps
1. Node and npm are already installed in Codespaces. If you're in a different environment, [install node for your platform](https://nodejs.org/en/download/)
1. Grab Hello World server code from the Getting Started documentation, save as server.js
1. Run `npm init` to create a `package.json`, specify `server.js` as the _entry point_ in the interactive script
1. Install express `npm install express`
1. Change `res.send('Hello World!')` on Line 6 to `res.json(message)`
1. Change port to `3001` becuase port `3000` is too common for us ;p 
1. Define `message` by adding the following snippet as a variable, between Line 3 and Line 5:
```javascript
const message = {
    "message": "Automate all the things!",
    "timestamp": Date.now()
}
```
1. Save our changes and test using `npm start`
1. Curl the endpoint and get the response:
```shell
@stevencorrea ➜ /workspaces/xyz-liatrio (main) $ curl localhost:3001
{"message":"Automate all the things!","timestamp":1676927495699}
```

1. Let's use [jq](https://stedolan.github.io/jq/download/) to view the response in the format listed in the problem statement. We can also use curl's silent flag `-s` to hide the verbose output of the command:
```shell
@stevencorrea ➜ /workspaces/xyz-liatrio (main) $ curl localhost:3001 -s | jq .
{
  "message": "Automate all the things!",
  "timestamp": 1676927495699
}
```
Looks good to me 

### Resources Used
[Express Documentation – Getting Started](https://expressjs.com/en/starter/hello-world.html)

[Express Documentation – express.json()](https://expressjs.com/en/4x/api.html#express.json)
