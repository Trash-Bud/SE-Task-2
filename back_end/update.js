

var GameStream = require("./models/game_streams")

let clients = [];

module.exports = {notifyGameAndPlayers,notifyGame,notifyPlayers,notifyPlayer,notifyTeam, closeGame,addGameStream ,addPlayerGameStream, addTeamToPlayerStream, removeTeamFromPlayerStream}


function addGameStream(code,res){

    const gameStream =  new GameStream(code,res)
    clients.push(gameStream);
    
}

function addPlayerGameStream(code,res,playerId){

    var gameStream = clients.find(element => element.id == code);
    var indexStream = clients.indexOf(gameStream)
    gameStream.addPlayer(playerId,res)
    clients[indexStream] = gameStream
    
}

function addTeamToPlayerStream(code,playerId, team_id){

    var gameStream = clients.find(element => element.id == code);
    var indexStream = clients.indexOf(gameStream)
    gameStream.changePlayerTeam(playerId,team_id)
    clients[indexStream] = gameStream
    
}


function removeTeamFromPlayerStream(code,playerId){

    var gameStream = clients.find(element => element.id == code);
    var indexStream = clients.indexOf(gameStream)
    gameStream.changePlayerTeam(playerId,"")
    clients[indexStream] = gameStream
    
}

function notifyGameAndPlayers(message, id){

    notifyGame(message,id)
    notifyPlayers(message,id)
}

function notifyGame(message, id){

    var gameStream = clients.find(element => element.id == id);
    gameStream.stream.write("data: " + message + "\n\n")

}

function notifyPlayers(message, id){

    var gameStream = clients.find(element => element.id == id);
    gameStream.players.forEach(element => {
        element.stream.write("data: " + message + "\n\n")
    });

}

function notifyPlayer(message, id, playerId){
    var gameStream = clients.find(element => element.id == id);
    var playerStream = gameStream.players.find(element => element.id == playerId)
    playerStream.stream.write("data: " + message + "\n\n")

}

function notifyTeam(message, id, teamId){
    var gameStream = clients.find(element => element.id == id);


    var playerStreamList = gameStream.players.filter(element => element.team_id == teamId)

    playerStreamList.forEach(element => {
        element.stream.write("data: " + message + "\n\n")
    })
}


function closeGame(code){
    var gameStream = clients.find(element => element.id == code);

    gameStream.stream.end()
    gameStream.players.forEach(element => {
        element.stream.end()
    });

    clients = clients.filter(function(el) { return el.id != gameStream.id; })
}