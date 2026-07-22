import 'package:flutter/material.dart';

import '../models/question.dart';

class QuestionListPane extends StatelessWidget {
  final List<Question> questions;
  final int currentIndex;
  final bool Function(String questionId) isAnswered;
  final void Function(int index) onSelect;

  const QuestionListPane({
    super.key,
    required this.questions,
    required this.currentIndex,
    required this.isAnswered,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final answeredCount = questions.where((q) => isAnswered(q.id)).length;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('진행 상황', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: questions.isEmpty ? 0 : answeredCount / questions.length,
                minHeight: 8,
                borderRadius: BorderRadius.circular(4),
              ),
              const SizedBox(height: 4),
              Text('$answeredCount / ${questions.length} 문항 풀이 완료'),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: ListView.builder(
            itemCount: questions.length,
            itemBuilder: (context, index) {
              final q = questions[index];
              final answered = isAnswered(q.id);
              final isCurrent = index == currentIndex;
              return Material(
                color: isCurrent
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Colors.transparent,
                child: InkWell(
                  onTap: () => onSelect(index),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 56),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: answered
                                ? Colors.green
                                : Theme.of(context).colorScheme.surfaceContainerHighest,
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                color: answered ? Colors.white : null,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              q.stem,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (answered) const Icon(Icons.check, color: Colors.green, size: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
