import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/attempt.dart';
import '../models/category.dart';
import '../providers/question_bank_provider.dart';
import '../providers/session_provider.dart';
import '../repositories/attempt_repository.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  final _attemptRepository = SqfliteAttemptRepository();
  bool _loading = true;
  List<Attempt> _attempts = [];
  final Map<NcsCategory, List<bool>> _categoryResults = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final session = context.read<SessionProvider>();
    final bank = context.read<QuestionBankProvider>();
    final attempts = await _attemptRepository.getAttemptsForUser(session.userId);
    final questionMap = {for (final q in bank.all) q.id: q};
    final results = <NcsCategory, List<bool>>{};
    for (final attempt in attempts) {
      final items = await _attemptRepository.getItemsForAttempt(attempt.id);
      for (final item in items) {
        final question = questionMap[item.questionId];
        if (question == null) continue;
        results.putIfAbsent(question.category, () => []).add(item.isCorrect);
      }
    }
    setState(() {
      _attempts = attempts;
      _categoryResults
        ..clear()
        ..addAll(results);
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('통계')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Text('영역별 누적 정답률', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),
                if (_categoryResults.isEmpty) const Text('아직 풀이 기록이 없습니다.'),
                ..._categoryResults.entries.map((entry) {
                  final results = entry.value;
                  final rate = results.where((e) => e).length / results.length;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(entry.key.label),
                            Text('${(rate * 100).round()}% (${results.length}문항)'),
                          ],
                        ),
                        const SizedBox(height: 4),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: rate,
                            minHeight: 12,
                            backgroundColor: Colors.grey.shade300,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 32),
                Text('최근 풀이 기록', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),
                if (_attempts.isEmpty) const Text('최근 풀이 기록이 없습니다.'),
                ..._attempts.take(20).map((attempt) {
                  final formatted = DateFormat('yyyy-MM-dd HH:mm').format(attempt.startedAt);
                  return Card(
                    child: ListTile(
                      title: Text('$formatted 풀이'),
                      subtitle: Text(
                          '${attempt.questionIds.length}문항 · 소요시간 ${attempt.totalTimeSeconds ~/ 60}분 ${attempt.totalTimeSeconds % 60}초'),
                      leading: const Icon(Icons.assignment_turned_in),
                    ),
                  );
                }),
              ],
            ),
    );
  }
}
