
const express = require('express')
const router = express.Router()

// get question
router.post("/get", (req,res) => {

})

// answer question
router.post("/answer", (req,res) => {

})

// send results (needs a send new or something if players want to switch questions which should not notify with results
// but with a new question)
router.post("/timeOut", (req,res) => {

})

module.exports = router