import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../models/category.dart';
import '../../models/question.dart';
import '../../providers/question_bank_provider.dart';
import '../../widgets/big_button.dart';

class AdminQuestionFormScreen extends StatefulWidget {
  final Question? existing;
  const AdminQuestionFormScreen({super.key, this.existing});

  @override
  State<AdminQuestionFormScreen> createState() => _AdminQuestionFormScreenState();
}

class _AdminQuestionFormScreenState extends State<AdminQuestionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late NcsCategory _category;
  late Difficulty _difficulty;
  late TextEditingController _stemController;
  late TextEditingController _explanationController;
  late TextEditingController _tagsController;
  late List<TextEditingController> _choiceControllers;
  int _correctIndex = 0;
  int _choiceCount = 4;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _category = existing?.category ?? NcsCategory.communication;
    _difficulty = existing?.difficulty ?? Difficulty.mid;
    _stemController = TextEditingController(text: existing?.stem ?? '');
    _explanationController = TextEditingController(text: existing?.explanation ?? '');
    _tagsController = TextEditingController(text: existing?.tags.join(', ') ?? '');
    _choiceCount = existing?.choices.length ?? 4;
    _correctIndex = existing?.correctIndex ?? 0;
    _choiceControllers = List.generate(
      5,
      (i) => TextEditingController(
          text: existing != null && i < existing.choices.length ? existing.choices[i] : ''),
    );
  }

  @override
  void dispose() {
    _stemController.dispose();
    _explanationController.dispose();
    _tagsController.dispose();
    for (final c in _choiceControllers) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final choices = _choiceControllers.take(_choiceCount).map((c) => c.text.trim()).toList();
    if (_correctIndex >= choices.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('정답 번호가 보기 개수를 벗어났습니다')),
      );
      return;
    }
    final tags = _tagsController.text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    final question = Question(
      id: widget.existing?.id ?? const Uuid().v4(),
      category: _category,
      difficulty: _difficulty,
      stem: _stemController.text.trim(),
      choices: choices,
      correctIndex: _correctIndex,
      explanation: _explanationController.text.trim(),
      tags: tags,
    );
    final bank = context.read<QuestionBankProvider>();
    if (widget.existing == null) {
      await bank.addQuestion(question);
    } else {
      await bank.updateQuestion(question);
    }
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.existing == null ? '문제 등록' : '문제 수정')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<NcsCategory>(
                        initialValue: _category,
                        decoration: const InputDecoration(labelText: '영역', border: OutlineInputBorder()),
                        items: NcsCategory.values
                            .map((c) => DropdownMenuItem(value: c, child: Text(c.label)))
                            .toList(),
                        onChanged: (v) => setState(() => _category = v!),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<Difficulty>(
                        initialValue: _difficulty,
                        decoration: const InputDecoration(labelText: '난이도', border: OutlineInputBorder()),
                        items: Difficulty.values
                            .map((d) => DropdownMenuItem(value: d, child: Text(d.label)))
                            .toList(),
                        onChanged: (v) => setState(() => _difficulty = v!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _stemController,
                  maxLines: 4,
                  decoration: const InputDecoration(labelText: '지문(문제)', border: OutlineInputBorder()),
                  validator: (v) => (v == null || v.trim().isEmpty) ? '지문을 입력해 주세요' : null,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('보기 개수'),
                    SegmentedButton<int>(
                      segments: const [
                        ButtonSegment(value: 4, label: Text('4지선다')),
                        ButtonSegment(value: 5, label: Text('5지선다')),
                      ],
                      selected: {_choiceCount},
                      onSelectionChanged: (s) => setState(() {
                        _choiceCount = s.first;
                        if (_correctIndex >= _choiceCount) _correctIndex = 0;
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                RadioGroup<int>(
                  groupValue: _correctIndex,
                  onChanged: (v) => setState(() => _correctIndex = v!),
                  child: Column(
                    children: List.generate(_choiceCount, (i) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            Radio<int>(value: i),
                            Expanded(
                              child: TextFormField(
                                controller: _choiceControllers[i],
                                decoration: InputDecoration(
                                  labelText:
                                      '보기 ${String.fromCharCode(65 + i)}${_correctIndex == i ? " (정답)" : ""}',
                                  border: const OutlineInputBorder(),
                                ),
                                validator: (v) =>
                                    (v == null || v.trim().isEmpty) ? '보기를 입력해 주세요' : null,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _explanationController,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: '해설', border: OutlineInputBorder()),
                  validator: (v) => (v == null || v.trim().isEmpty) ? '해설을 입력해 주세요' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _tagsController,
                  decoration: const InputDecoration(
                    labelText: '태그 (쉼표로 구분)',
                    border: OutlineInputBorder(),
                    hintText: '예: 문서작성, 기초',
                  ),
                ),
                const SizedBox(height: 24),
                BigButton(label: '저장', icon: Icons.save, onPressed: _save),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
