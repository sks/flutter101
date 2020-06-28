class Answer {
  final String answer;
  final int score;
  const Answer(this.answer, {this.score = 0});
}

class QuestionAnswer {
  final String question;
  final List<Answer> answers;
  const QuestionAnswer(this.question, this.answers);
}
