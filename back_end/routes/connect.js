
const express = require('express')
const router = express.Router()
var crypto = require("crypto");

let temp = {}

router.get("/", (req,res) => {

    var id = crypto.randomBytes(26).toString('hex');
    res.setHeader("Content-Type", "text/event-stream")
    res.setHeader("Access-Control-Allow-Origin", "*")
    temp[id] = res;
    console.log("hello")
    res.write("data: " + JSON.stringify({id:id})+"\n\n")
    console.log("done")
})


function getStream(id){
    var stream = temp[id];
    delete temp[id];
    return stream;
}


module.exports = { 
    router:router,
    getStream:getStream
  }