var crypto = require("crypto");

class Player {
    constructor(name, picture, color){
        this.id = crypto.randomBytes(26).toString('hex');
        this.name = name;
        this.color = color;
        this.picture = picture;
    }
}

module.exports = Player