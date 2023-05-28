var crypto = require("crypto");

class Player {
    constructor(name, picture){
        this.id = crypto.randomBytes(26).toString('hex');
        this.name = name;
        this.picture = picture;
    }
}

module.exports = Player