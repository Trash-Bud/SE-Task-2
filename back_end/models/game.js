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
            this.teams.push(new Team(i+1,"pfp"+(i+1)+".png",playersPerTeam))
        }
        this.code = crypto.randomBytes(3).toString('hex');
        this.locked = false;
        this.question = null;
        this.currentTeam = this.teams[0].id
        this.currentPlayer = ""
        this.results = {}
        this.answers = 0

        this.teams.forEach(element => {
            this.results[element.id] = {
                questions: 0,
                correct: 0,
                moves: 0
            }
        })
      }
}

module.exports = Game
