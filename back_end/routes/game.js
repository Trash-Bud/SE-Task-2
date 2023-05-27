
const express = require('express')
const router = express.Router()
var Game = require("../models/game")
var fs = require('fs');

router.post("/create", (req,res) => {

    // Verifying request
    if (!req.body.hasOwnProperty("teamNumber") ||
    !req.body.hasOwnProperty("year") ||
    !req.body.hasOwnProperty("playersPerTeam")
    ){
        res.status(400).send({error: "O pedido tem de ter o seguinte formato: {teamNumber: int, year: int, playersPerTeam:int}"})
    }

    if (!Number.isInteger(req.body["teamNumber"]) ||
    !Number.isInteger(req.body["year"]) ||
    !Number.isInteger(req.body["playersPerTeam"])
    ){
        res.status(400).send({error: "O pedido tem de ter o seguinte formato: {teamNumber: int, year: int, playersPerTeam:int}"})
    }

    // Creating game
    
    const game = new Game(req.body["teamNumber"],req.body["year"],req.body["playersPerTeam"])
    
    // Saving new game

    fs.readFile('games.json', 'utf8', function readFileCallback(err, data){
        if (err){
            res.status(500).send({error:"Erro Interno do Servidor"})
        } else {
        obj = JSON.parse(data); 
        obj.games.push(game); 
        json = JSON.stringify(obj); 
        console.log(json)
        fs.writeFile('games.json', json, 'utf8', () =>{console.log("New game stores successfully"), res.status(201).send({code: game.code})}); 
    }});

})


router.post("/end", (req,res) => {

    // Verifying request
    if (!req.body.hasOwnProperty("code")){
        res.status(400).send({error: "O pedido tem de ter o seguinte formato: {code: string}"})
    }

    if (!typeof req.body["code"] === 'string' && !req.body["code"] instanceof String){
        res.status(400).send({error: "O pedido tem de ter o seguinte formato: {code: string}"})
    }

    // Checking if game exists

    fs.readFile('games.json', 'utf8', function readFileCallback(err, data){
        if (err){
            res.status(500).send({error:"Erro Interno do Servidor"})
        } else {
        obj = JSON.parse(data); 
        var found = obj.games.find(element => element["code"] == req.body["code"]);
        console.log(found)
        if (found == undefined){
            
            res.status(404).send({error:"O código do jogo que enviou não existe"})
        }
        else{
            var filtered = obj.games.filter(function(el) { return el != found; }); 
            obj.games = filtered;
            json = JSON.stringify(obj); 
            console.log(json)
            fs.writeFile('games.json', json, 'utf8', () =>{console.log("Game successfully deleted"), res.send("O jogo foi terminado com sucesso")}); 
        }
    }})

})

router.post("/join", (req,res) => {

})

module.exports = router