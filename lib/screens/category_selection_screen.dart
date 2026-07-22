import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/category.dart';
import '../providers/question_bank_provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/big_button.dart';
import 'quiz_screen.dart';

class CategorySelectionScreen extends StatefulWidget {
  const CategorySelectionScreen({super.key});

  @override
  State<CategorySelectionScreen> createState() => _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  final Set<NcsCategory> _selected = {};
  int _count = 10;

  @override
  Widget build(BuildContext context) {
    final bank = context.watch<QuestionBankProvider>();
    final counts = bank.countByCategory;
    final availableForSelection =
        _selected.fold<int>(0, (sum, c) => sum + (counts[c] ?? 0));

    return Scaffold(
      appBar: AppBar(title: const Text('영역 선택')),
      body: bank.loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: LayoutBuilder(builder: (context, constraints) {
                    final columns = constraints.maxWidth >= 900
                        ? 4
                        : constraints.maxWidth >= 600
                            ? 3
                            : 2;
                    return GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        childAspectRatio: 1.5,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: NcsCategory.values.length,
                      itemBuilder: (context, index) {
                        final category = NcsCategory.values[index];
                        final selected = _selected.contains(category);
                        final questionCount = counts[category] ?? 0;
                        return _CategoryCard(
                          category: category,
                          selected: selected,
                          questionCount: questionCount,
                          onTap: () {
                            setState(() {
                              if (selected) {
                                _selected.remove(category);
                              } else {
                                _selected.add(category);
                              }
                            });
                          },
                        );
                      },
                    );
                  }),
                ),
                SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Text('문항 수: ', style: TextStyle(fontSize: 16)),
                        Expanded(
                          child: Slider(
                            value: _count.toDouble(),
                            min: 5,
                            max: 30,
                            divisions: 25,
                            label: '$_count문항',
                            onChanged: (v) => setState(() => _count = v.round()),
                          ),
                        ),
                        SizedBox(
                          width: 56,
                          child: Text('$_count문항', style: const TextStyle(fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  child: BigButton(
                    label: _selected.isEmpty
                        ? '하나 이상의 영역을 선택하세요'
                        : '문제 풀기 시작 (선택 가능 $availableForSelection문항)',
                    icon: Icons.play_arrow,
                    onPressed: _selected.isEmpty
                        ? () {}
                        : () async {
                            final questions = await bank.getByCategories(_selected.toList());
                            questions.shuffle();
                            final picked = questions.take(_count).toList();
                            if (!context.mounted) return;
                            if (picked.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('선택한 영역에 문제가 없습니다')),
                              );
                              return;
                            }
                            context.read<QuizProvider>().startSession(picked);
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const QuizScreen()),
                            );
                          },
                  ),
                ),
              ],
            ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final NcsCategory category;
  final bool selected;
  final int questionCount;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.category,
    required this.selected,
    required this.questionCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: selected ? scheme.primaryContainer : scheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    selected ? Icons.check_circle : Icons.circle_outlined,
                    color: selected ? scheme.primary : scheme.outline,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      category.label,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Text('$questionCount문항 보유', style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
