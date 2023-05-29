var crypto = require("crypto");
var Team = require("./team")

class Game {
    constructor(teamsNumber, playersPerTeam, year, theme) {
        this.year = year;
        this.playersPerTeam = playersPerTeam;
        this.pendingTeamPlayers = [];
        this.theme = theme;
        this.teams = [];
        for (var i = 0; i < teamsNumber; i++){
            this.teams.push(new Team(i+1,"sss",playersPerTeam))
        }
        this.code = crypto.randomBytes(3).toString('hex');
        this.locked = false;
        this.question = null;
        this.currentTeam = this.teams[0].id
        this.currentPlayer = ""
        this.results = {}

        this.teams.forEach(element => {
            this.results[element] = {
                questions: 0,
                correct: 0,
                moves: 0
            }
        })
      }
}

module.exports = Game
