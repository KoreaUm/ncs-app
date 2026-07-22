import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/question.dart';
import '../providers/question_bank_provider.dart';
import '../providers/session_provider.dart';
import '../repositories/attempt_repository.dart';
import 'question_review_screen.dart';

class WrongNotesScreen extends StatefulWidget {
  const WrongNotesScreen({super.key});

  @override
  State<WrongNotesScreen> createState() => _WrongNotesScreenState();
}

class _WrongNotesScreenState extends State<WrongNotesScreen> {
  final _attemptRepository = SqfliteAttemptRepository();
  bool _loading = true;
  List<Question> _wrongQuestions = [];
  Map<String, int> _answers = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final session = context.read<SessionProvider>();
    final bank = context.read<QuestionBankProvider>();
    final wrongItems = await _attemptRepository.getAllWrongItems(session.userId);
    final seen = <String>{};
    final answers = <String, int>{};
    final ids = <String>[];
    for (final item in wrongItems) {
      if (seen.add(item.questionId)) {
        ids.add(item.questionId);
      }
      if (item.answerIndex != null) {
        answers[item.questionId] = item.answerIndex!;
      }
    }
    final all = bank.all;
    final map = {for (final q in all) q.id: q};
    setState(() {
      _wrongQuestions = ids.where(map.containsKey).map((id) => map[id]!).toList();
      _answers = answers;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: const Text('오답노트')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return QuestionReviewScreen(questions: _wrongQuestions, answers: _answers);
  }
}
