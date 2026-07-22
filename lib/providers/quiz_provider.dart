import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../models/attempt.dart';
import '../models/question.dart';
import '../repositories/attempt_repository.dart';

class QuizProvider extends ChangeNotifier {
  final AttemptRepository _attemptRepository;
  QuizProvider({AttemptRepository? attemptRepository})
      : _attemptRepository = attemptRepository ?? SqfliteAttemptRepository();

  static const _uuid = Uuid();

  List<Question> _questions = [];
  final Map<String, int> _answers = {};
  final Map<String, int> _timeSpent = {};
  int _currentIndex = 0;
  DateTime? _sessionStart;
  DateTime? _questionStart;
  bool _submitted = false;
  Attempt? _lastAttempt;

  List<Question> get questions => _questions;
  int get currentIndex => _currentIndex;
  Question get currentQuestion => _questions[_currentIndex];
  bool get submitted => _submitted;
  Attempt? get lastAttempt => _lastAttempt;
  int get totalCount => _questions.length;
  int get answeredCount => _answers.length;

  int? answerFor(String questionId) => _answers[questionId];
  bool isAnswered(String questionId) => _answers.containsKey(questionId);

  void startSession(List<Question> questions) {
    _questions = questions;
    _answers.clear();
    _timeSpent.clear();
    _currentIndex = 0;
    _submitted = false;
    _lastAttempt = null;
    _sessionStart = DateTime.now();
    _questionStart = DateTime.now();
    notifyListeners();
  }

  void _recordElapsed() {
    if (_questionStart == null || _questions.isEmpty) return;
    final qid = currentQuestion.id;
    final elapsed = DateTime.now().difference(_questionStart!).inSeconds;
    _timeSpent[qid] = (_timeSpent[qid] ?? 0) + elapsed;
  }

  void answerCurrent(int choiceIndex) {
    _answers[currentQuestion.id] = choiceIndex;
    notifyListeners();
  }

  void goTo(int index) {
    if (index < 0 || index >= _questions.length) return;
    _recordElapsed();
    _currentIndex = index;
    _questionStart = DateTime.now();
    notifyListeners();
  }

  void next() {
    if (_currentIndex < _questions.length - 1) {
      goTo(_currentIndex + 1);
    }
  }

  void previous() {
    if (_currentIndex > 0) {
      goTo(_currentIndex - 1);
    }
  }

  int get correctCount {
    var count = 0;
    for (final q in _questions) {
      if (_answers[q.id] == q.correctIndex) count++;
    }
    return count;
  }

  int get wrongCount => totalCount - correctCount;

  List<Question> get wrongQuestions =>
      _questions.where((q) => _answers[q.id] != q.correctIndex).toList();

  Future<Attempt> submit(String? userId) async {
    _recordElapsed();
    final totalTime = _sessionStart == null
        ? 0
        : DateTime.now().difference(_sessionStart!).inSeconds;
    final attemptId = _uuid.v4();
    final attempt = Attempt(
      id: attemptId,
      userId: userId,
      questionIds: _questions.map((q) => q.id).toList(),
      startedAt: _sessionStart ?? DateTime.now(),
      finishedAt: DateTime.now(),
      totalTimeSeconds: totalTime,
    );
    final items = _questions.map((q) {
      final answer = _answers[q.id];
      return AttemptItem(
        id: _uuid.v4(),
        attemptId: attemptId,
        questionId: q.id,
        answerIndex: answer,
        isCorrect: answer != null && answer == q.correctIndex,
        timeSpentSeconds: _timeSpent[q.id] ?? 0,
      );
    }).toList();
    await _attemptRepository.saveAttempt(attempt, items);
    _lastAttempt = attempt;
    _submitted = true;
    notifyListeners();
    return attempt;
  }
}
