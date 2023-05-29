
class Question {
    constructor(question, options, answer){
        this.question = question;
        this.options = {}
        options.forEach(element => {
            this.options[element] = []
        });
        this.answer = answer
    }
}

module.exports = Question