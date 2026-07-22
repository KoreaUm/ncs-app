// CSV 컬럼 형식(헤더 포함, 첫 줄은 헤더로 간주):
// category,difficulty,stem,choice1,choice2,choice3,choice4,choice5,correctIndex,explanation,tags
//
// category: communication/numeracy/problemSolving/selfDevelopment/resourceManagement/
//           interpersonal/information/technology/organization/ethics 중 하나
//           (또는 의사소통능력 등 한글 라벨도 허용)
// difficulty: low/mid/high 또는 하/중/상
// choice5는 4지선다인 경우 빈 칸으로 둘 수 있음
// correctIndex: 0부터 시작하는 정답 보기 번호
// tags: 세미콜론(;)으로 구분한 태그 목록

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../models/category.dart';
import '../../models/question.dart';
import '../../providers/question_bank_provider.dart';
import '../../widgets/big_button.dart';

class AdminCsvUploadScreen extends StatefulWidget {
  const AdminCsvUploadScreen({super.key});

  @override
  State<AdminCsvUploadScreen> createState() => _AdminCsvUploadScreenState();
}

class _AdminCsvUploadScreenState extends State<AdminCsvUploadScreen> {
  List<Question> _parsed = [];
  List<String> _errors = [];
  String? _fileName;
  bool _loading = false;

  NcsCategory? _parseCategory(String raw) {
    final trimmed = raw.trim();
    try {
      return NcsCategoryX.fromCode(trimmed);
    } catch (_) {
      return NcsCategoryX.fromLabel(trimmed);
    }
  }

  Difficulty? _parseDifficulty(String raw) {
    final trimmed = raw.trim();
    try {
      return DifficultyX.fromCode(trimmed);
    } catch (_) {
      return DifficultyX.fromLabel(trimmed);
    }
  }

  Future<void> _pickFile() async {
    setState(() {
      _loading = true;
      _errors = [];
      _parsed = [];
    });
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
      withData: true,
    );
    if (result == null || result.files.single.bytes == null) {
      setState(() => _loading = false);
      return;
    }
    final content = String.fromCharCodes(result.files.single.bytes!);
    final rows = const CsvToListConverter(eol: '\n').convert(content, shouldParseNumbers: false);
    final errors = <String>[];
    final questions = <Question>[];
    for (var i = 0; i < rows.length; i++) {
      if (i == 0) continue; // header row
      final row = rows[i];
      if (row.isEmpty || (row.length == 1 && row.first.toString().trim().isEmpty)) continue;
      if (row.length < 10) {
        errors.add('${i + 1}행: 컬럼 수가 부족합니다 (최소 10개 필요)');
        continue;
      }
      final category = _parseCategory(row[0].toString());
      final difficulty = _parseDifficulty(row[1].toString());
      final stem = row[2].toString().trim();
      final choices = [
        row[3].toString().trim(),
        row[4].toString().trim(),
        row[5].toString().trim(),
        row[6].toString().trim(),
        if (row.length > 7) row[7].toString().trim(),
      ].where((c) => c.isNotEmpty).toList();
      final correctIndex = int.tryParse(row.length > 8 ? row[8].toString().trim() : '');
      final explanation = row.length > 9 ? row[9].toString().trim() : '';
      final tags = row.length > 10
          ? row[10].toString().split(';').map((e) => e.trim()).where((e) => e.isNotEmpty).toList()
          : <String>[];

      if (category == null) {
        errors.add('${i + 1}행: 알 수 없는 영역(category) 값입니다');
        continue;
      }
      if (difficulty == null) {
        errors.add('${i + 1}행: 알 수 없는 난이도(difficulty) 값입니다');
        continue;
      }
      if (stem.isEmpty) {
        errors.add('${i + 1}행: 지문(stem)이 비어 있습니다');
        continue;
      }
      if (choices.length < 4) {
        errors.add('${i + 1}행: 보기가 4개 미만입니다');
        continue;
      }
      if (correctIndex == null || correctIndex < 0 || correctIndex >= choices.length) {
        errors.add('${i + 1}행: correctIndex가 보기 범위를 벗어났습니다');
        continue;
      }
      if (explanation.isEmpty) {
        errors.add('${i + 1}행: 해설(explanation)이 비어 있습니다');
        continue;
      }
      questions.add(Question(
        id: const Uuid().v4(),
        category: category,
        difficulty: difficulty,
        stem: stem,
        choices: choices,
        correctIndex: correctIndex,
        explanation: explanation,
        tags: tags,
      ));
    }
    setState(() {
      _fileName = result.files.single.name;
      _parsed = questions;
      _errors = errors;
      _loading = false;
    });
  }

  Future<void> _confirmImport() async {
    if (_parsed.isEmpty) return;
    await context.read<QuestionBankProvider>().addQuestions(_parsed);
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('${_parsed.length}개 문제를 등록했습니다')));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CSV 일괄 업로드')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'CSV 형식: category,difficulty,stem,choice1,choice2,choice3,choice4,choice5,correctIndex,explanation,tags\n'
              '(choice5와 tags는 생략 가능, tags는 세미콜론으로 구분)',
            ),
            const SizedBox(height: 16),
            BigButton(label: 'CSV 파일 선택', icon: Icons.upload_file, onPressed: _pickFile),
            const SizedBox(height: 16),
            if (_loading) const Center(child: CircularProgressIndicator()),
            if (_fileName != null) Text('선택한 파일: $_fileName'),
            if (_errors.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text('오류 ${_errors.length}건', style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 120,
                child: ListView(
                  children: _errors.map((e) => Text('- $e', style: const TextStyle(color: Colors.red))).toList(),
                ),
              ),
            ],
            if (_parsed.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text('정상 파싱된 문제: ${_parsed.length}개'),
              Expanded(
                child: ListView.builder(
                  itemCount: _parsed.length,
                  itemBuilder: (context, index) {
                    final q = _parsed[index];
                    return ListTile(
                      dense: true,
                      title: Text(q.stem, maxLines: 1, overflow: TextOverflow.ellipsis),
                      subtitle: Text('${q.category.label} · ${q.difficulty.label}'),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              BigButton(
                label: '${_parsed.length}개 문제 등록하기',
                icon: Icons.check,
                color: Colors.green,
                onPressed: _confirmImport,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
