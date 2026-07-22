import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/question.dart';

class QuestionDetailCard extends StatelessWidget {
  final Question question;
  final int index;
  final int total;
  final int? selectedIndex;
  final Future<void> Function(int choiceIndex) onSelectChoice;

  const QuestionDetailCard({
    super.key,
    required this.question,
    required this.index,
    required this.total,
    required this.selectedIndex,
    required this.onSelectChoice,
  });

  Future<void> _confirmChoice(BuildContext context, int choiceIndex) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('답안 확정'),
        content: Text('"${question.choices[choiceIndex]}" 를(을) 답으로 선택하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('취소'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('확정'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await onSelectChoice(choiceIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Chip(label: Text(question.category.label)),
              const SizedBox(width: 8),
              Chip(label: Text('난이도: ${question.difficulty.label}')),
              const Spacer(),
              Text('${index + 1} / $total', style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            question.stem,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 24),
          ...List.generate(question.choices.length, (i) {
            final isSelected = selectedIndex == i;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SizedBox(
                width: double.infinity,
                child: Material(
                  color: isSelected ? scheme.primaryContainer : scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => _confirmChoice(context, i),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 56),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 14,
                              backgroundColor: isSelected ? scheme.primary : scheme.surface,
                              child: Text(
                                String.fromCharCode(65 + i),
                                style: TextStyle(
                                  color: isSelected ? scheme.onPrimary : null,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(question.choices[i], style: const TextStyle(fontSize: 16)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
