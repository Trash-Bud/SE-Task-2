var crypto = require("crypto");
var Team = require("./team")

class Game {
    constructor(teamsNumber, playersPerTeam, year) {
        this.year = year;
        this.playersPerTeam = playersPerTeam;
        this.teams = [];
        for (var i = 0; i < teamsNumber; i++){
            this.teams.push(new Team(i+1,"sss",playersPerTeam))
        }
        this.code = crypto.randomBytes(3).toString('hex');
      }
}

module.exports = Game
