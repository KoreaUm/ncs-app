import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../models/category.dart';
import '../../models/question_set.dart';
import '../../pdf/pdf_generator.dart';
import '../../providers/question_bank_provider.dart';
import '../../repositories/question_set_repository.dart';
import '../../widgets/big_button.dart';

class AdminSetShareScreen extends StatefulWidget {
  const AdminSetShareScreen({super.key});

  @override
  State<AdminSetShareScreen> createState() => _AdminSetShareScreenState();
}

class _AdminSetShareScreenState extends State<AdminSetShareScreen> {
  final _titleController = TextEditingController(text: '나의 문제 세트');
  final _setRepository = SqfliteQuestionSetRepository();
  final Set<NcsCategory> _selected = {};
  int _count = 10;
  bool _saving = false;
  QuestionSet? _created;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _createSet() async {
    if (_selected.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('영역을 하나 이상 선택해 주세요')));
      return;
    }
    setState(() => _saving = true);
    final bank = context.read<QuestionBankProvider>();
    final questions = await bank.getByCategories(_selected.toList());
    questions.shuffle();
    final picked = questions.take(_count).toList();
    if (picked.isEmpty) {
      setState(() => _saving = false);
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('선택한 조건에 맞는 문제가 없습니다')));
      return;
    }
    final set = QuestionSet(
      id: const Uuid().v4(),
      title: _titleController.text.trim().isEmpty ? '문제 세트' : _titleController.text.trim(),
      categoryFilter: _selected.toList(),
      count: picked.length,
      questionIds: picked.map((q) => q.id).toList(),
      shareCode: SqfliteQuestionSetRepository.generateShareCode(),
    );
    await _setRepository.create(set);
    setState(() {
      _created = set;
      _saving = false;
    });
  }

  Future<void> _exportPdf(bool withAnswers) async {
    final bank = context.read<QuestionBankProvider>();
    final ids = _created!.questionIds;
    final questions =
        ids.map((id) => bank.all.firstWhere((q) => q.id == id)).toList();
    final bytes = withAnswers
        ? await PdfGenerator.buildAnswerSheet(questions)
        : await PdfGenerator.buildQuestionPaper(questions);
    await Printing.sharePdf(
      bytes: bytes,
      filename: withAnswers ? 'ncs_answer_sheet.pdf' : 'ncs_question_paper.pdf',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('문제 세트 공유 / PDF')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: '세트 이름', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              Text('영역 선택', style: Theme.of(context).textTheme.titleMedium),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: NcsCategory.values.map((c) {
                  final selected = _selected.contains(c);
                  return FilterChip(
                    label: Text(c.label),
                    selected: selected,
                    onSelected: (v) => setState(() {
                      if (v) {
                        _selected.add(c);
                      } else {
                        _selected.remove(c);
                      }
                    }),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('문항 수: '),
                  Expanded(
                    child: Slider(
                      value: _count.toDouble(),
                      min: 5,
                      max: 30,
                      divisions: 25,
                      label: '$_count',
                      onChanged: (v) => setState(() => _count = v.round()),
                    ),
                  ),
                  Text('$_count문항'),
                ],
              ),
              const SizedBox(height: 16),
              _saving
                  ? const Center(child: CircularProgressIndicator())
                  : BigButton(label: '문제 세트 생성', icon: Icons.add_box, onPressed: _createSet),
              if (_created != null) ...[
                const SizedBox(height: 24),
                Card(
                  color: Colors.indigo.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('생성 완료: ${_created!.title}', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 8),
                        Text('공유 코드', style: Theme.of(context).textTheme.bodyMedium),
                        SelectableText(
                          _created!.shareCode,
                          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 4),
                        ),
                        const SizedBox(height: 4),
                        Text('${_created!.count}문항 포함'),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () => _exportPdf(false),
                                icon: const Icon(Icons.description),
                                label: const Text('문제지 PDF'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () => _exportPdf(true),
                                icon: const Icon(Icons.checklist),
                                label: const Text('정답지 PDF'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
