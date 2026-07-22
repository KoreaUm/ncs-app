import 'package:flutter/foundation.dart';

import '../models/category.dart';
import '../models/question.dart';
import '../repositories/question_repository.dart';

class QuestionBankProvider extends ChangeNotifier {
  final QuestionRepository _repository;
  QuestionBankProvider({QuestionRepository? repository})
      : _repository = repository ?? SqfliteQuestionRepository();

  List<Question> _all = [];
  bool _loading = false;

  List<Question> get all => _all;
  bool get loading => _loading;

  Future<void> load() async {
    _loading = true;
    notifyListeners();
    await _repository.ensureSeeded();
    _all = await _repository.getAll();
    _loading = false;
    notifyListeners();
  }

  List<Question> filter({NcsCategory? category, Difficulty? difficulty, String? query}) {
    return _all.where((q) {
      if (category != null && q.category != category) return false;
      if (difficulty != null && q.difficulty != difficulty) return false;
      if (query != null && query.trim().isNotEmpty) {
        final needle = query.trim().toLowerCase();
        if (!q.stem.toLowerCase().contains(needle) &&
            !q.tags.any((t) => t.toLowerCase().contains(needle))) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  Map<NcsCategory, int> get countByCategory {
    final result = {for (final c in NcsCategory.values) c: 0};
    for (final q in _all) {
      result[q.category] = (result[q.category] ?? 0) + 1;
    }
    return result;
  }

  Future<void> addQuestion(Question question) async {
    await _repository.insert(question);
    await load();
  }

  Future<void> updateQuestion(Question question) async {
    await _repository.update(question);
    await load();
  }

  Future<void> deleteQuestion(String id) async {
    await _repository.delete(id);
    await load();
  }

  Future<void> addQuestions(List<Question> questions) async {
    await _repository.insertAll(questions);
    await load();
  }

  Future<List<Question>> getByCategories(List<NcsCategory> categories) {
    return _repository.getByCategories(categories);
  }
}
