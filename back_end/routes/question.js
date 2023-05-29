
const express = require('express')
const router = express.Router()
var Question = require("../models/question")
var { notifyGame,notifyTeam } = require('../update');
var fs = require('fs');

// get question
router.post("/get", (req,res) => {

    if (!req.body.hasOwnProperty("code") || !req.body.hasOwnProperty("team")){
        return res.status(400).send({error: "O pedido tem de ter o seguinte formato: {code: string, team: string}"})
    }

    if ((!typeof req.body["code"] === 'string' && !req.body["code"] instanceof String) ||
    (!typeof req.body["team"] === 'string' && !req.body["team"] instanceof String)){
        return res.status(400).send({error: "O pedido tem de ter o seguinte formato: {code: string, team: string}"})
    }

    fs.readFile('questions.json', 'utf8', function readFileCallback(err, data){
        if (err){
            res.status(500).send({error:"Erro Interno do Servidor"})
        } else {
            obj = JSON.parse(data); 
            var length = Math.floor(Math.random() * obj.questions.length)
            var question = obj.questions[length]

            fs.readFile('games.json', 'utf8', function readFileCallback(err, data){
                if (err){
                    res.status(500).send({error:"Erro Interno do Servidor"})
                } else {
                    obj = JSON.parse(data); 
                    var found = obj.games.find(element => element["code"] == req.body["code"]);
                    if (found == undefined){
                        res.status(404).send({error:"O código do jogo que enviou não existe"})
                    }
                    else{
                        var index = obj.games.indexOf(found)
                        found.question = new Question(question.question,question.options,question.correct)
                        
                        obj.games[index] = found
                        
                        json = JSON.stringify(obj); 
                        fs.writeFile('games.json', json, 'utf8', () =>{notifyGame(JSON.stringify({question:question.question,options:question.options}), req.body["code"]), notifyTeam(JSON.stringify({question:question.question,options:question.options}), req.body["code"],req.body["team"]), res.send("Questão enviada")}); 
                    }
                }
            })
            
        }
    })

})

// answer question
router.post("/answer", (req,res) => {

})

// send results (needs a send new or something if players want to switch questions which should not notify with results
// but with a new question)
router.post("/timeOut", (req,res) => {

})

module.exports = router