
class GameStream {
    constructor(id, stream) {
        this.id = id
        this.stream = stream
        this.players = []
    }

    addPlayer(id, stream){
        this.players.push(new PlayerStream(id,stream))
    }

}

class PlayerStream {
    constructor(id, stream) {
        this.id = id
        this.stream = stream
    }
}

module.exports = GameStream
