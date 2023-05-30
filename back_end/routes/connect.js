
const express = require('express')
const router = express.Router()
var crypto = require("crypto");

let temp = {}

router.get("/", (req,res) => {

    var id = crypto.randomBytes(26).toString('hex');
    res.setHeader("Content-Type", "text/event-stream")
    temp[id] = res;

    res.write("data: " + JSON.stringify({activity:"connect",id:id})+"\n\n")

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