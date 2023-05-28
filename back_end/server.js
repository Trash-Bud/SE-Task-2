
const express = require('express')
const app = express()

let clients = [];

module.exports = {clients}

app.listen(3000)

app.use(express.json())

app.get("/",(req,res) => {
  res.status(200).send("Hi, I'm online!")
})

const diceRouter = require("./routes/dice.js")
const teamRouter = require("./routes/team.js")
const questionRouter = require("./routes/question.js")
const gameRouter = require("./routes/game.js")

app.use("/dice",diceRouter)
app.use("/team",teamRouter)
app.use("/question",questionRouter)
app.use("/game",gameRouter)