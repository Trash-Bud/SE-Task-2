const express = require('express')
const router = express.Router()
var { notifyGame, notifyPlayers, notifyPlayer, notifyTeam, notifyTeam} = require('../update');
var fs = require('fs');


// Choose who will roll
router.post("/chooseRoll", (req,res) => {
    // Verifying request
    if (!req.body.hasOwnProperty("code") || !req.body.hasOwnProperty("team")){
        return res.status(400).send({error: "O pedido tem de ter o seguinte formato: {code: string, team: string}"})
    }

    if ((!typeof req.body["code"] === 'string' && !req.body["code"] instanceof String) ||
    (!typeof req.body["team"] === 'string' && !req.body["team"] instanceof String)){
        return res.status(400).send({error: "O pedido tem de ter o seguinte formato: {code: string, team: string}"})
    }


    fs.readFile('games.json', 'utf8', function readFileCallback(err, data){
        if (err){
            res.status(500).send({error:"Erro Interno do Servidor"})
        } else {
        obj = JSON.parse(data); 
        var found = obj.games.find(element => element["code"] == req.body["code"]);
        if (found == undefined){
            res.status(404).send({error:"O código do jogo que enviou não existe"})
        }else{
            if (!found.locked){
                res.status(403).send({error:"Este jogo ainda não começou"})
            }
            else{
    
                var foundTeam = found.teams.find(element => element.id == req.body["team"])
                if (foundTeam == undefined){
                    return res.status(403).send({error:"A equipa que enviou não existe ou não faz parte deste jogo"})
                }

                var index = obj.games.indexOf(found)
                found.currentTeam = req.body["team"]
                

                var rand = Math.floor(Math.random() * foundTeam.players.length)
                var choosePlayer = foundTeam.players[rand]
    
                
                found.currentPlayer = choosePlayer.id
                obj.games[index] = found

                notifyGame(JSON.stringify({activity:"roll",team:req.body["team"], player:choosePlayer.id,}), req.body["code"])
                notifyPlayers(JSON.stringify({activity:"roll", me: false, team:req.body["team"]}), req.body["code"],[choosePlayer.id])
                notifyPlayer(JSON.stringify({activity:"roll",me: true, team:req.body["team"]}), req.body["code"],choosePlayer.id)

                json = JSON.stringify(obj); 
                fs.writeFile('games.json', json, 'utf8', () =>{res.send("Jogador escolhido")}); 
            
            }
        }
    }})

})

// Roll dice
router.post("/roll", (req,res) => {
    if (!req.body.hasOwnProperty("code") || !req.body.hasOwnProperty("team") || !req.body.hasOwnProperty("player")){
        return res.status(400).send({error: "O pedido tem de ter o seguinte formato: {code: string, team: string, player:string}"})
    }

    if ((!typeof req.body["code"] === 'string' && !req.body["code"] instanceof String) ||
    (!typeof req.body["team"] === 'string' && !req.body["team"] instanceof String)||
    (!typeof req.body["player"] === 'string' && !req.body["player"] instanceof String)){
        return res.status(400).send({error: "O pedido tem de ter o seguinte formato: {code: string, team: string, player:string}"})
    }

    fs.readFile('games.json', 'utf8', function readFileCallback(err, data){
        if (err){
            res.status(500).send({error:"Erro Interno do Servidor"})
        } else {
        obj = JSON.parse(data); 
        var found = obj.games.find(element => element["code"] == req.body["code"]);
        if (found == undefined){
            res.status(404).send({error:"O código do jogo que enviou não existe"})
        }else{
            if (!found.locked){
                res.status(403).send({error:"Este jogo ainda não começou"})
            }
            else{

                if (found.currentTeam != req.body["team"]){
                    return res.status(403).send({error:"Não é a vez desta equipa rolar o dado"})
                }
                if (found.currentPlayer != req.body["player"]){
                    return res.status(403).send({error:"Não é a vez deste jogador rolar o dado"})
                }

                var foundTeam = found.teams.find(element => element.id == req.body["team"])
                if (foundTeam == undefined){
                    return res.status(403).send({error:"A equipa que enviou não existe ou não faz parte deste jogo"})
                }

                var rand = Math.floor(Math.random() * 6) + 1
    
                notifyGame(JSON.stringify({activity:"roll_result",result:rand}), req.body["code"])
                notifyTeam(JSON.stringify({activity:"roll_result", result:rand}), req.body["code"],req.body["team"])

                json = JSON.stringify(obj); 
                fs.writeFile('games.json', json, 'utf8', () =>{res.send("Dado rolado")}); 
            
            }
        }
    }})

})

module.exports = router