
import 'Player.dart';

class Question{
  final String question;
  final Map<String,List<Player>> answers;
  late int correctAnswer;

  Question(this.question, this.answers);
  Question.withAnswer(this.question, this.answers, this.correctAnswer);

  @override
  String toString() {
    return 'Question{question: $question, answers: $answers}';
  }
}