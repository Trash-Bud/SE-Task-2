var crypto = require("crypto");

class Team {
    constructor(number, picture, maxPlayers){
        this.id = crypto.randomBytes(26).toString('hex');
        this.name = "Equipa " + number;
        this.picture = picture;
        this.players = [];
        this.maxPlayers = maxPlayers
    }

    addPlayer(player){
        if (this.players.length > this.maxPlayers){
            throw Error("Esta equipa já está cheia")
        }
        if (this.players.length == 0){
            this.leader = player
        }
        this.players.push(player)
    }

    changeName(name){
        this.name = name
    }

    changePicture(picture){
        this.picture = picture
    }

    changeLeader(){
        var newLeaderIndex = Math.floor(Math.random() * this.players.length);
        this.leader = this.players[newLeaderIndex]
    }

}

module.exports = Team