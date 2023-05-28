
const express = require('express')
const router = express.Router()
var Game = require("../models/game")
var fs = require('fs');
const Player = require('../models/player');
const GameStream = require('../models/game_streams');
var { clients }  = require('../server');

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

    
    // Saving new game

    fs.readFile('games.json', 'utf8', function readFileCallback(err, data){
        if (err){
            res.status(500).send({error:"Erro Interno do Servidor"})
        } else {

        // Setting up stream
        const headers = {
            "Content-Type" : "text/event-stream",
            "Connection" : "keep-alive",
            "Cache-Control" : "no-cache"
        }
        res.writeHead(200, headers)
        

        // Creating game
        const game = new Game(req.body["teamNumber"],req.body["year"],req.body["playersPerTeam"])

        const gameStream =  new GameStream(game.code,res)
        
        clients.push(gameStream);
        
        req.on('end', () => {
            closeGame(game.code)
        });

        obj = JSON.parse(data); 
        obj.games.push(game); 
        json = JSON.stringify(obj); 
        
        fs.writeFile('games.json', json, 'utf8', () =>{
            console.log("Game ${game.code} - Created") 
            res.write("data: " +JSON.stringify({code: game.code})+"\n\n")
        }); 
    }});

})


function closeGame(code){
    var gameStream = clients.find(element => element.id == code);

    gameStream.stream.end()
    gameStream.players.forEach(element => {
        element.stream.end()
    });

    clients = clients.filter(function(el) { return el.id != gameStream.id; })
}


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

            closeGame(req.body["code"])
            fs.writeFile('games.json', json, 'utf8', () =>{console.log("Game successfully deleted"),  res.send("O jogo foi terminado com sucesso")}); 
        }
    }})

})


// Just checks if game exists

router.post("/checkJoin", (req,res) => {
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
            res.status(200).send("Game exists")
        }
    }})
})


// Just checks if game exists

router.post("/join", (req,res) => {
    // Verifying request
    if (!req.body.hasOwnProperty("code") || !req.body.hasOwnProperty("name") || !req.body.hasOwnProperty("pic")){
        res.status(400).send({error: "O pedido tem de ter o seguinte formato: {code: string, name: string, pic:string}"})
    }

    if ((!typeof req.body["code"] === 'string' && !req.body["code"] instanceof String) ||
    (!typeof req.body["name"] === 'string' && !req.body["name"] instanceof String) ||
    (!typeof req.body["pic"] === 'string' && !req.body["pic"] instanceof String) ){
        res.status(400).send({error: "O pedido tem de ter o seguinte formato: {code: string, name: string, pic:string}"})
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

            // Setting up stream
            res.setHeader("Content-Type", "text/event-stream")

            var player = new Player(req.body["name"],req.body["pic"])
            var index = obj.games.indexOf(found)
            found["pendingTeamPlayers"].push((player))
            obj.games[index] = found

            
            var gameStream = clients.find(element => element.id == req.body["code"]);
            var indexStream = clients.indexOf(gameStream)
            gameStream.addPlayer(player.id,res)
            clients[indexStream] = gameStream

            gameStream.stream.write("data: " + JSON.stringify({pendingPlayers:found.pendingTeamPlayers, teams:found.teams}) + "\n\n")
            
            json = JSON.stringify(obj); 
            fs.writeFile('games.json', json, 'utf8', () =>{res.write("data: " + JSON.stringify({id: player.id, teams: found.teams}) +"\n\n")}); 
        }
    }})
})

module.exports = router