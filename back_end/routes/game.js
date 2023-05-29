
const express = require('express')
const router = express.Router()
var Game = require("../models/game")
var fs = require('fs');
const Player = require('../models/player');
var { closeGame, notifyGame, addPlayerGameStream, addGameStream, notifyPlayers} = require('../update');

router.post("/create", (req,res) => {

    // Verifying request
    if (!req.body.hasOwnProperty("teamNumber") ||
    !req.body.hasOwnProperty("year") ||
    !req.body.hasOwnProperty("playersPerTeam")||
    !req.body.hasOwnProperty("theme")
    ){
        res.status(400).send({error: "O pedido tem de ter o seguinte formato: {teamNumber: int, year: int, playersPerTeam:int, theme:bool}"})
    }

    if (!Number.isInteger(req.body["teamNumber"]) ||
    !Number.isInteger(req.body["year"]) ||
    !Number.isInteger(req.body["playersPerTeam"]||
    !typeof req.body["theme"] == "boolean")
    ){
        res.status(400).send({error: "O pedido tem de ter o seguinte formato: {teamNumber: int, year: int, playersPerTeam:int, theme:bool}"})
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
        const game = new Game(req.body["teamNumber"],req.body["playersPerTeam"],req.body["year"],req.body["theme"])

        addGameStream(game.code,res)
        
        req.on('close', () => {
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
        if (found == undefined){
            res.status(404).send({error:"O código do jogo que enviou não existe"})
        }else{
            if (found.locked){
                res.status(403).send({error:"Este jogo já não está a aceitar participantes"})
            }
            else{
                res.status(200).send({exists:true, theme:found.theme, year: found.year})
            }
        }
        
    }})
})


// Just checks if game exists

router.post("/join", (req,res) => {
    // Verifying request
    if (!req.body.hasOwnProperty("code") || !req.body.hasOwnProperty("name") || !req.body.hasOwnProperty("pic") || !req.body.hasOwnProperty("color")){
        res.status(400).send({error: "O pedido tem de ter o seguinte formato: {code: string, name: string, pic:string, color:string}"})
    }

    if ((!typeof req.body["code"] === 'string' && !req.body["code"] instanceof String) ||
    (!typeof req.body["name"] === 'string' && !req.body["name"] instanceof String) ||
    (!typeof req.body["pic"] === 'string' && !req.body["pic"] instanceof String) ||
    (!typeof req.body["color"] === 'string' && !req.body["color"] instanceof String)){
        res.status(400).send({error: "O pedido tem de ter o seguinte formato: {code: string, name: string, pic:string, color:string}"})
    }

    // Checking if game exists

    fs.readFile('games.json', 'utf8', function readFileCallback(err, data){
        if (err){
            res.status(500).send({error:"Erro Interno do Servidor"})
        } else {
        obj = JSON.parse(data); 
        var found = obj.games.find(element => element["code"] == req.body["code"]);
        if (found == undefined){
            res.status(404).send({error:"O código do jogo que enviou não existe"})
        }else{
            if (found.locked){
                res.status(403).send({error:"Este jogo já não está a aceitar participantes"})
            }
            else{
    
                // Setting up stream
                res.setHeader("Content-Type", "text/event-stream")
    
                var player = new Player(req.body["name"],req.body["pic"],req.body["color"])
                var index = obj.games.indexOf(found)
                found["pendingTeamPlayers"].push((player))
                obj.games[index] = found
    
                
                addPlayerGameStream(req.body["code"],res,player.id)
    
                notifyGame(JSON.stringify({pendingPlayers:found.pendingTeamPlayers, teams:found.teams}), req.body["code"])
                
                json = JSON.stringify(obj); 
                fs.writeFile('games.json', json, 'utf8', () =>{res.write("data: " + JSON.stringify({id: player.id, teams: found.teams}) +"\n\n")}); 
            
            }
        }
    }})
})


router.post("/lock", (req,res) => {
    // Verifying request
    if (!req.body.hasOwnProperty("code")){
        res.status(400).send({error: "O pedido tem de ter o seguinte formato: {code: string}"})
    }

    if ((!typeof req.body["code"] === 'string' && !req.body["code"] instanceof String)){
        res.status(400).send({error: "O pedido tem de ter o seguinte formato: {code: string}"})
    }

    // Checking if game exists

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

                if (found.pendingTeamPlayers.length != 0){
                    res.status(403).send({error:"Ainda há jogadores sem equipa"})
                }else{
                    var index = obj.games.indexOf(found)
                    found.locked = true
                    obj.games[index] = found
        
                        
                    notifyPlayers(JSON.stringify({locked:true}), req.body["code"])
                    
                    json = JSON.stringify(obj); 
                    fs.writeFile('games.json', json, 'utf8', () =>{res.send({locked:true})}); 
                }
    
            }
        
 
    }})
})


// send winner
router.post("/winner", (req,res) => {

})


module.exports = router