const express = require('express')
const router = express.Router()
var { notifyGame, notifyPlayers, addTeamToPlayerStream,removeTeamFromPlayerStream } = require('../update');

var fs = require('fs');

router.post("/join", (req,res) => {
 // Verifying request
 if (!req.body.hasOwnProperty("code") || !req.body.hasOwnProperty("player") || !req.body.hasOwnProperty("team")){
    return res.status(400).send({error: "O pedido tem de ter o seguinte formato: {code: string, playerId: string, teamsId:string}"})
    }

    if ((!typeof req.body["code"] === 'string' && !req.body["code"] instanceof String) ||
    (!typeof req.body["player"] === 'string' && !req.body["player"] instanceof String) ||
    (!typeof req.body["team"] === 'string' && !req.body["team"] instanceof String) ){
        return res.status(400).send({error: "O pedido tem de ter o seguinte formato: {code: string, playerId: string, teamsId:string}"})
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
        var player = found.pendingTeamPlayers.find(element => element["id"] == req.body["player"])
        var team = found.teams.find(element => element["id"] == req.body["team"])
        if (player == undefined){
            res.status(404).send({error:"O jogador que enviou não existe, não se juntou a este jogo ou já se encontra numa equipa"})
        }
        else if (team == undefined){
            res.status(404).send({error:"A equipa que enviou não existe ou não faz parte deste jogo"})
        }
        else{

            if (team.players.length >= team.maxPlayers){
                res.status(400).send({error:"O jogador não se pode juntar a uma equipa cheia"})
            }else{
                var index = obj.games.indexOf(found)
                var indexTeam = found.teams.indexOf(team)
                var teamLeader = false;
                
                team.players.push(player)
                if (team.players.length == 1 ){
                    team.leader = player
                    teamLeader = true
                }
                var newPending = found.pendingTeamPlayers.filter(function(el) { return el != player; }); 
                found.pendingTeamPlayers = newPending
                found.teams[indexTeam] = team
                obj.games[index] = found        
                json = JSON.stringify(obj); 

                addTeamToPlayerStream(req.body["code"],player.id,team.id)
                notifyGame(JSON.stringify({activity:"change_team",pendingPlayers:found.pendingTeamPlayers, teams:found.teams}), req.body["code"])
                notifyPlayers(JSON.stringify({activity:"change_team",teams: found.teams}),req.body["code"])

                fs.writeFile('games.json', json, 'utf8', () =>{res.status(200).send({teamLeader: teamLeader})}); 
            }
        }
    }
}})
})

router.post("/leave", (req,res) => {
    // Verifying request
    if (!req.body.hasOwnProperty("code") || !req.body.hasOwnProperty("playerId") || !req.body.hasOwnProperty("teamsId")){
        return res.status(400).send({error: "O pedido tem de ter o seguinte formato: {code: string, playerId: string, teamsId:string}"})
       }
   
   if ((!typeof req.body["code"] === 'string' && !req.body["code"] instanceof String) ||
   (!typeof req.body["playerId"] === 'string' && !req.body["playerId"] instanceof String) ||
   (!typeof req.body["teamsId"] === 'string' && !req.body["teamsId"] instanceof String) ){
    return res.status(400).send({error: "O pedido tem de ter o seguinte formato: {code: string, playerId: string, teamsId:string}"})
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
           var team = found.teams.find(element => element["id"] == req.body["teamsId"])
        
           if (team == undefined){
               res.status(404).send({error:"A equipa que enviou não existe ou não faz parte deste jogo"})
           }else{
            var player = team.players.find(element => element["id"] == req.body["playerId"])

            if (player == undefined){
                res.status(404).send({error:"O jogador que enviou não se encontra na equipa enviada"})
            }
            else{
                var index = obj.games.indexOf(found)
                var indexTeam = found.teams.indexOf(team)
                
                
                var newPlayers = team.players.filter(function(el) { return el != player; })
                team.players = newPlayers
                if (team.leader == player){
                    if (team.players.length == 0 ){
                        team.leader = null
                    }else{
                        var newLeaderIndex = Math.floor(Math.random() * team.players);
                        team.leader = team.players[newLeaderIndex]
                    }
                }
                found.pendingTeamPlayers.push(player); 
                found.teams[indexTeam] = team
                obj.games[index] = found

                removeTeamFromPlayerStream(req.body["code"],player.id,team.id)
                notifyGame(JSON.stringify({activity:"change_team",pendingPlayers:found.pendingTeamPlayers, teams:found.teams}), req.body["code"])
                notifyPlayers(JSON.stringify({activity:"change_team",teams: found.teams}),req.body["code"])
        
                json = JSON.stringify(obj); 
                fs.writeFile('games.json', json, 'utf8', () =>{res.status(200).send("Jogador removido com sucesso")}); 
            }
           }
       }
   }})
   })

// Change team name
router.post("/changeName", (req,res) => {
  

    
})

// Change team picture
router.post("/changePicture", (req,res) => {




})

// Change team leader
router.post("/changeLeader", (req,res) => {




})

module.exports = router