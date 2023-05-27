var crypto = require("crypto");

class Player {
    constructor(name, picture){
        this.id = crypto.randomBytes(26).toString('hex');
        this.name = name;
        this.picture = picture;
        this.players = [];
    }
}

module.exports = Player