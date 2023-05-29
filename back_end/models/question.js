
class Question {
    constructor(question, options, answer){
        this.question = question;
        // {"option" : [players who chose it]}
        this.options = {}
        options.forEach(element => {
            options[element] = []
        });
        this.answer = answer
    }
}

module.exports = Question