import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/category.dart';
import '../providers/quiz_provider.dart';
import '../widgets/big_button.dart';
import 'question_review_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final total = quiz.totalCount;
    final correct = quiz.correctCount;
    final wrong = quiz.wrongCount;
    final accuracy = total == 0 ? 0.0 : correct / total;

    final Map<NcsCategory, List<bool>> byCategory = {};
    for (final q in quiz.questions) {
      final answer = quiz.answerFor(q.id);
      final isCorrect = answer != null && answer == q.correctIndex;
      byCategory.putIfAbsent(q.category, () => []).add(isCorrect);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('채점 결과'), automaticallyImplyLeading: false),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Column(
                  children: [
                    Text('${(accuracy * 100).round()}점',
                        style: Theme.of(context).textTheme.displayMedium),
                    const SizedBox(height: 8),
                    Text('총 $total문항 중 정답 $correct / 오답 $wrong',
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Text('영역별 정답률', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              ...byCategory.entries.map((entry) {
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
                          Text('${results.where((e) => e).length}/${results.length}'),
                        ],
                      ),
                      const SizedBox(height: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: rate,
                          minHeight: 12,
                          color: rate >= 0.6 ? Colors.green : Colors.redAccent,
                          backgroundColor: Colors.grey.shade300,
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 24),
              if (wrong > 0)
                BigButton(
                  label: '오답 문제 바로가기 ($wrong개)',
                  icon: Icons.error_outline,
                  color: Colors.orange,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => QuestionReviewScreen(questions: quiz.wrongQuestions),
                    ));
                  },
                ),
              const SizedBox(height: 16),
              BigButton(
                label: '홈으로 돌아가기',
                icon: Icons.home,
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
