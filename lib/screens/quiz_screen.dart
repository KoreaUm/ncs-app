import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../providers/session_provider.dart';
import '../widgets/question_detail_card.dart';
import '../widgets/question_list_pane.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final PageController _pageController;
  Timer? _ticker;
  Duration _elapsed = Duration.zero;
  final DateTime _startedAt = DateTime.now();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _elapsed = DateTime.now().difference(_startedAt));
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  Future<void> _confirmSubmit(BuildContext context, QuizProvider quiz) async {
    final unanswered = quiz.totalCount - quiz.answeredCount;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('제출 확인'),
        content: Text(
          unanswered > 0
              ? '아직 풀지 않은 문제가 $unanswered개 있습니다. 제출하시겠습니까?'
              : '모든 문제를 풀었습니다. 제출하시겠습니까?',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('취소')),
          FilledButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('제출')),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    final userId = context.read<SessionProvider>().userId;
    await quiz.submit(userId);
    if (!context.mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const ResultScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final leave = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('풀이 종료'),
            content: const Text('풀이를 중단하고 나가시겠습니까? 진행 상황은 저장되지 않습니다.'),
            actions: [
              TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('취소')),
              FilledButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('나가기')),
            ],
          ),
        );
        if (leave == true && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('문제 풀이 (${_formatDuration(_elapsed)})'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                minimumSize: const Size(48, 48),
              ),
              onPressed: () => _confirmSubmit(context, quiz),
              child: const Text('제출하기'),
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            return LayoutBuilder(builder: (context, constraints) {
              final wide = constraints.maxWidth >= 700;
              final pageView = PageView.builder(
                controller: _pageController,
                itemCount: quiz.totalCount,
                onPageChanged: (index) => quiz.goTo(index),
                itemBuilder: (context, index) {
                  final q = quiz.questions[index];
                  return QuestionDetailCard(
                    question: q,
                    index: index,
                    total: quiz.totalCount,
                    selectedIndex: quiz.answerFor(q.id),
                    onSelectChoice: (choice) async {
                      quiz.answerCurrent(choice);
                    },
                  );
                },
              );

              void jumpTo(int index) {
                quiz.goTo(index);
                _pageController.jumpToPage(index);
              }

              final navBar = Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: OutlinedButton.icon(
                          onPressed: quiz.currentIndex > 0
                              ? () => jumpTo(quiz.currentIndex - 1)
                              : null,
                          icon: const Icon(Icons.arrow_back),
                          label: const Text('이전'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: FilledButton.icon(
                          onPressed: quiz.currentIndex < quiz.totalCount - 1
                              ? () => jumpTo(quiz.currentIndex + 1)
                              : null,
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text('다음'),
                        ),
                      ),
                    ),
                  ],
                ),
              );

              if (wide) {
                return Row(
                  children: [
                    SizedBox(
                      width: 320,
                      child: QuestionListPane(
                        questions: quiz.questions,
                        currentIndex: quiz.currentIndex,
                        isAnswered: quiz.isAnswered,
                        onSelect: jumpTo,
                      ),
                    ),
                    const VerticalDivider(width: 1),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(child: pageView),
                          navBar,
                        ],
                      ),
                    ),
                  ],
                );
              }

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: LinearProgressIndicator(
                      value: quiz.totalCount == 0 ? 0 : quiz.answeredCount / quiz.totalCount,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Expanded(child: pageView),
                  navBar,
                ],
              );
            });
          },
        ),
      ),
    );
  }
}
