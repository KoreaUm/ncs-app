import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/question.dart';

class QuestionReviewScreen extends StatelessWidget {
  final List<Question> questions;
  final Map<String, int>? answers;

  const QuestionReviewScreen({super.key, required this.questions, this.answers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('오답 복습 (${questions.length}문항)')),
      body: questions.isEmpty
          ? const Center(child: Text('복습할 문제가 없습니다'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: questions.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final q = questions[index];
                final userAnswer = answers?[q.id];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Chip(label: Text(q.category.label)),
                            const SizedBox(width: 8),
                            Chip(label: Text('난이도: ${q.difficulty.label}')),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(q.stem, style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 12),
                        ...List.generate(q.choices.length, (i) {
                          final isCorrectChoice = i == q.correctIndex;
                          final isUserChoice = userAnswer == i;
                          Color? color;
                          if (isCorrectChoice) color = Colors.green.withValues(alpha: 0.15);
                          if (isUserChoice && !isCorrectChoice) {
                            color = Colors.red.withValues(alpha: 0.15);
                          }
                          return Container(
                            margin: const EdgeInsets.only(bottom: 6),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Text('${String.fromCharCode(65 + i)}. '),
                                Expanded(child: Text(q.choices[i])),
                                if (isCorrectChoice)
                                  const Icon(Icons.check, color: Colors.green, size: 18),
                                if (isUserChoice && !isCorrectChoice)
                                  const Icon(Icons.close, color: Colors.red, size: 18),
                              ],
                            ),
                          );
                        }),
                        const Divider(),
                        Text('해설', style: Theme.of(context).textTheme.titleSmall),
                        const SizedBox(height: 4),
                        Text(q.explanation),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
