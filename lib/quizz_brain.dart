import 'package:quizzler/question.dart';

class QuizzBrain {
  int _questionNumber = 0;
  List<Question> _questions = [
    Question(
        'Les abeilles mâles meurent généralement après s’être reproduites avec une reine vierge.',
        true),
    Question('Le requin-marteau mange ses semblables.', true),
    Question(
        'Herman Melville, l’auteur de Moby Dick, n’a jamais mis les pieds sur un bateau.',
        false),
    Question(
        'La phrase suivante est fautive : « Peu importent leurs avis, nous ferons à notre tête. »',
        false),
    Question(
        'La phrase suivante est fautive : « Il y aura dégustation de vins, fromages, chocolats, bières et pâtés. ».',
        true),
    Question('La Cité du Vatican est le plus petit pays du monde.', true),
    Question('Shanghai est la capitale de la Chine.', false),
    Question(
        'Nagasaki a été la première ville détruite par une bombe atomique.',
        false),
    Question('Winston Churchill a remporté le prix Nobel de la paix de 1953.',
        false),
    Question('Louis Pasteur est l’inventeur de la vaccination.', false),
  ];

  void nextQuestion() {
    if (_questionNumber <= _questions.length - 1) {
      _questionNumber++;
    }
  }

  void reset() {
    _questionNumber = 0;
  }

  bool isFinished() {
    if (_questionNumber == _questions.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  String getQuestionText() {
    return _questions[_questionNumber].questionText;
  }

  bool getQuestionAnswer() {
    return _questions[_questionNumber].questionAnswer;
  }
}
