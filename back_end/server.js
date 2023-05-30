
const express = require('express')
const app = express()

app.listen(3000)

const cors = require('cors');
app.use(cors({
  origin: '*'
}));
app.use(express.json())

app.get("/",(req,res) => {
  res.status(200).send("Hi, I'm online!")
})

const diceRouter = require("./routes/dice.js")
const teamRouter = require("./routes/team.js")
const questionRouter = require("./routes/question.js")
const gameRouter = require("./routes/game.js")
const connect = require("./routes/connect.js")

app.use("/dice",diceRouter)
app.use("/team",teamRouter)
app.use("/question",questionRouter)
app.use("/game",gameRouter)
app.use("/connect",connect.router)