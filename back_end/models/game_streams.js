
class GameStream {
    constructor(id, stream) {
        this.id = id
        this.stream = stream
        this.players = []
    }

    addPlayer(id, stream){
        this.players.push(new PlayerStream(id,stream))
    }

    changePlayerTeam(player_id, team_id){
        var player = this.players.find(element => element.id == player_id)
        player.team_id = team_id
    }

}

class PlayerStream {
    constructor(id, stream) {
        this.id = id
        this.stream = stream
        this.team_id = ""
    }
}

module.exports = GameStream
