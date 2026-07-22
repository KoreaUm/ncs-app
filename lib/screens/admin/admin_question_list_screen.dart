import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/category.dart';
import '../../models/question.dart';
import '../../providers/question_bank_provider.dart';
import 'admin_question_form_screen.dart';

class AdminQuestionListScreen extends StatefulWidget {
  const AdminQuestionListScreen({super.key});

  @override
  State<AdminQuestionListScreen> createState() => _AdminQuestionListScreenState();
}

class _AdminQuestionListScreenState extends State<AdminQuestionListScreen> {
  NcsCategory? _category;
  Difficulty? _difficulty;
  String _query = '';

  Future<void> _confirmDelete(Question q) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('문제 삭제'),
        content: Text('다음 문제를 삭제하시겠습니까?\n\n${q.stem}'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('취소')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('삭제'),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      await context.read<QuestionBankProvider>().deleteQuestion(q.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bank = context.watch<QuestionBankProvider>();
    final filtered = bank.filter(category: _category, difficulty: _difficulty, query: _query);

    return Scaffold(
      appBar: AppBar(title: const Text('문제 목록')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AdminQuestionFormScreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('문제 등록'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: '검색어 (지문, 태그)',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (v) => setState(() => _query = v),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<NcsCategory?>(
                        initialValue: _category,
                        decoration: const InputDecoration(labelText: '영역', border: OutlineInputBorder()),
                        items: [
                          const DropdownMenuItem(value: null, child: Text('전체')),
                          ...NcsCategory.values.map(
                              (c) => DropdownMenuItem(value: c, child: Text(c.label))),
                        ],
                        onChanged: (v) => setState(() => _category = v),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<Difficulty?>(
                        initialValue: _difficulty,
                        decoration: const InputDecoration(labelText: '난이도', border: OutlineInputBorder()),
                        items: [
                          const DropdownMenuItem(value: null, child: Text('전체')),
                          ...Difficulty.values.map(
                              (d) => DropdownMenuItem(value: d, child: Text(d.label))),
                        ],
                        onChanged: (v) => setState(() => _difficulty = v),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('총 ${filtered.length}개 문항'),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: bank.loading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final q = filtered[index];
                      return Card(
                        child: ListTile(
                          title: Text(q.stem, maxLines: 2, overflow: TextOverflow.ellipsis),
                          subtitle: Text('${q.category.label} · 난이도 ${q.difficulty.label}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => AdminQuestionFormScreen(existing: q)));
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _confirmDelete(q),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
