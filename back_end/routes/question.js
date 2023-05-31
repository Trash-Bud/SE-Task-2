
const express = require('express')
const router = express.Router()
var Question = require("../models/question")
var { notifyGame,notifyTeam } = require('../update');
var fs = require('fs');

var {temp} =  require('./connect');

// get question
router.post("/get", (req,res) => {
    if (!req.body.hasOwnProperty("code") || !req.body.hasOwnProperty("team")){
        return res.status(400).send({error: "O pedido tem de ter o seguinte formato: {code: string, team: string}"})
    }

    if ((!typeof req.body["code"] === 'string' && !req.body["code"] instanceof String) ||
    (!typeof req.body["team"] === 'string' && !req.body["team"] instanceof String)){
        return res.status(400).send({error: "O pedido tem de ter o seguinte formato: {code: string, team: string}"})
    }

    console.log(req.body)

    getNewQuestion(req.body["code"],req.body["team"],res)

})



// answer question
router.post("/answer", (req,res) => {
    if (!req.body.hasOwnProperty("code")  || !req.body.hasOwnProperty("player")|| !req.body.hasOwnProperty("answer")){
        return res.status(400).send({error: "O pedido tem de ter o seguinte formato: {code: string, team: string, answer:int}"})
    }

    if ((!typeof req.body["code"] === 'string' && !req.body["code"] instanceof String) ||
    (!typeof req.body["player"] === 'string' && !req.body["player"] instanceof String) ||
    !Number.isInteger(req.body["answer"])){
        return res.status(400).send({error: "O pedido tem de ter o seguinte formato: {code: string, team: string, answer:int}"})
    }

    fs.readFile('games.json', 'utf8', function readFileCallback(err, data){
        if (err){
            res.status(500).send({error:"Erro Interno do Servidor"})
        } else {
            obj = JSON.parse(data); 
            var found = obj.games.find(element => element["code"] == req.body["code"]);
            if (found == undefined){
                res.status(404).send({error:"O código do jogo que enviou não existe"})
            }
            else{
                var team = found.teams.find(element => element.id == found.currentTeam)
        
                if (team == undefined){
                    return res.status(500).send({error:"Erro interno do server, não existe nenhuma equipa a jogar"})
                }

                var player = team.players.find(element => element.id == req.body["player"])
                if (player == undefined){
                    return res.status(404).send({error:"O jogador ou não existe ou não está na equipa que está a jogar"})
                }

                var index = obj.games.indexOf(found)
                var counter = 0;
                for (const option of Object.keys(found.question.options)) {
                    if(req.body["answer"] == counter){
                        found.question.options[option].push(req.body["player"])
                        break
                    }
                    counter ++;
                }

                found.answers ++;

                obj.games[index] = found

                if(found.answers == team.players.length){
                    notifyGame(JSON.stringify({activity:"early_timeout"}),req.body["code"])
                }
                
                json = JSON.stringify(obj); 
                fs.writeFile('games.json', json, 'utf8', () =>{res.send({answered:true})}); 
            }
        }
    })


})

// send results (needs a send new or something if players want to switch questions which should not notify with results
// but with a new question)
router.post("/timeOut", (req,res) => {
    if (!req.body.hasOwnProperty("code")  || !req.body.hasOwnProperty("special")){
        return res.status(400).send({error: "O pedido tem de ter o seguinte formato: {code: string, special: string}"})
    }

    if ((!typeof req.body["code"] === 'string' && !req.body["code"] instanceof String) ||
    (req.body["special"] != 'doubleQuestion' && req.body["special"] != 'doubleChance' && req.body["special"] != 'replace' && req.body["special"] != '')){
        return res.status(400).send({error: "O pedido tem de ter o seguinte formato: {code: string, special: string}"})
    }

    console.log(req.body);

    fs.readFile('games.json', 'utf8', function readFileCallback(err, data){
        if (err){
            res.status(500).send({error:"Erro Interno do Servidor"})
        } else {
            obj = JSON.parse(data); 
            var found = obj.games.find(element => element["code"] == req.body["code"]);
            if (found == undefined){
                res.status(404).send({error:"O código do jogo que enviou não existe"})
            }
            else{

                var index = obj.games.indexOf(found)

                if (req.body["special"] == "replace"){
                    getNewQuestion(req.body["code"],found.currentTeam,res)
                }else{
                    var question = found.question;
    
                    var responses = [];
                    for (const option of Object.keys(question.options)) {
                        responses.push(question.options[option].length)
                    }
                    var correct = (responses[question.answer] == Math.max(...responses) && Math.max(...responses) != 0)
                    if (correct ){
                        found.results[found.currentTeam]["correct"] += 1
                    }

                    switch(req.body["special"]){
                        case 'doubleQuestion':
                            if (correct){
                                notifyGame(JSON.stringify({activity:"question_end",result:"won", results:found.question, newQuestion:true}), req.body["code"])
                                notifyTeam(JSON.stringify({activity:"question_end",result:"won", results:found.question}), req.body["code"],found.currentTeam)
                            }else{
                                notifyGame(JSON.stringify({activity:"question_end",result:"lost", results:found.question, newQuestion:false}), req.body["code"])
                                notifyTeam(JSON.stringify({activity:"question_end",result:"lost", results:found.question}), req.body["code"],found.currentTeam)
                            }
                            break;
                        case 'doubleChance':
                            if (correct){
                                found.results[found.currentTeam]["moves"] += 1
                                notifyGame(JSON.stringify({activity:"question_end",result:"won", results:found.question, newQuestion:false}), req.body["code"])
                                notifyTeam(JSON.stringify({activity:"question_end",result:"won",results:found.question}), req.body["code"],found.currentTeam)

                            }else{
                                notifyGame(JSON.stringify({activity:"question_end",result:"lost", results:found.question, newQuestion:true}), req.body["code"])
                                notifyTeam(JSON.stringify({activity:"question_end",result:"lost",results:found.question}), req.body["code"],found.currentTeam)
                            }
                            break
                        default:
                            if (correct){
                                found.results[found.currentTeam]["moves"] += 1
                                notifyGame(JSON.stringify({activity:"question_end",result:"won", results:found.question, newQuestion:false}), req.body["code"])
                                notifyTeam(JSON.stringify({activity:"question_end",result:"won",results:found.question}), req.body["code"],found.currentTeam)
                            }else{
                                notifyGame(JSON.stringify({activity:"question_end",result:"lost", results:found.question, newQuestion:false}), req.body["code"])
                                notifyTeam(JSON.stringify({activity:"question_end",result:"lost",results:found.question}), req.body["code"],found.currentTeam)
                            }
                            break;
                    }

                    obj.games[index] = found
                    
                    json = JSON.stringify(obj); 
                    fs.writeFile('games.json', json, 'utf8', () =>{res.send("Resultados Enviados")}); 
                }
            }
        }
    })
})


function getNewQuestion(code, team, res){
    fs.readFile('questions.json', 'utf8', function readFileCallback(err, data){
        if (err){
            res.status(500).send({error:"Erro Interno do Servidor"})
        } else {
            obj = JSON.parse(data); 
            var length = Math.floor(Math.random() * obj.questions.length)
            var question = obj.questions[length]

            fs.readFile('games.json', 'utf8', function readFileCallback(err, data){
                if (err){
                    res.status(500).send({error:"Erro Interno do Servidor"})
                } else {
                    obj = JSON.parse(data); 
                    var found = obj.games.find(element => element.code == code);
                    if (found == undefined){
                        res.status(404).send({error:"O código do jogo que enviou não existe"})
                    }
                    else{
                        var index = obj.games.indexOf(found)
                        found.question = new Question(question.question,question.options,question.correct)
                        found.results[team]["questions"] += 1
                        found.answers = 0
                        obj.games[index] = found
                        
                        json = JSON.stringify(obj); 
                        fs.writeFile('games.json', json, 'utf8', () =>{notifyGame(JSON.stringify({activity:"question",question:found.question.question,options:found.question.options}), code), notifyTeam(JSON.stringify({activity:"question",question:question.question,options:question.options}), code,team), res.send("Questão enviada")}); 
                    }
                }
            })
            
        }
    })
}

module.exports = router