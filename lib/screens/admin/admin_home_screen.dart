import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/category.dart';
import '../../providers/question_bank_provider.dart';
import '../../widgets/big_button.dart';
import 'admin_csv_upload_screen.dart';
import 'admin_question_list_screen.dart';
import 'admin_set_share_screen.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bank = context.watch<QuestionBankProvider>();
    final counts = bank.countByCategory;
    final total = counts.values.fold<int>(0, (a, b) => a + b);

    return Scaffold(
      appBar: AppBar(title: const Text('관리자 모드')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('문제 은행 현황', style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 12),
                        Text('총 문항 수: $total개'),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: counts.entries
                              .map((e) => Chip(label: Text('${e.key.label} ${e.value}')))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                BigButton(
                  label: '문제 목록 / 등록 / 수정',
                  icon: Icons.list_alt,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const AdminQuestionListScreen()),
                    );
                  },
                ),
                const SizedBox(height: 16),
                BigButton(
                  label: 'CSV 일괄 업로드',
                  icon: Icons.upload_file,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const AdminCsvUploadScreen()),
                    );
                  },
                ),
                const SizedBox(height: 16),
                BigButton(
                  label: '문제 세트 공유 만들기 / PDF 출력',
                  icon: Icons.share,
                  color: Colors.deepPurple,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const AdminSetShareScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
