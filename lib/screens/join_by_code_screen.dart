import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/question_bank_provider.dart';
import '../providers/quiz_provider.dart';
import '../repositories/question_set_repository.dart';
import '../widgets/big_button.dart';
import 'quiz_screen.dart';

class JoinByCodeScreen extends StatefulWidget {
  const JoinByCodeScreen({super.key});

  @override
  State<JoinByCodeScreen> createState() => _JoinByCodeScreenState();
}

class _JoinByCodeScreenState extends State<JoinByCodeScreen> {
  final _codeController = TextEditingController();
  final _setRepository = SqfliteQuestionSetRepository();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _join() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final code = _codeController.text.trim();
    final set = await _setRepository.getByShareCode(code);
    if (!mounted) return;
    if (set == null) {
      setState(() {
        _loading = false;
        _error = '해당 코드의 문제 세트를 찾을 수 없습니다.';
      });
      return;
    }
    final bank = context.read<QuestionBankProvider>();
    final questions = await bank.getByCategories([]);
    final map = {for (final q in questions) q.id: q};
    final picked = set.questionIds.where(map.containsKey).map((id) => map[id]!).toList();
    setState(() => _loading = false);
    if (picked.isEmpty) {
      setState(() => _error = '문제 세트에 포함된 문제를 찾을 수 없습니다.');
      return;
    }
    if (!mounted) return;
    context.read<QuizProvider>().startSession(picked);
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const QuizScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('코드로 참여')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('공유받은 문제 세트 코드를 입력하세요.', textAlign: TextAlign.center),
                const SizedBox(height: 24),
                TextField(
                  controller: _codeController,
                  textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(
                    labelText: '공유 코드',
                    border: OutlineInputBorder(),
                  ),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  Text(_error!, style: const TextStyle(color: Colors.red)),
                ],
                const SizedBox(height: 24),
                _loading
                    ? const CircularProgressIndicator()
                    : BigButton(label: '참여하기', icon: Icons.login, onPressed: _join),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
