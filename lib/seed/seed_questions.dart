import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/category.dart';
import '../models/question.dart';

/// Question content lives in `assets/questions/{category}.json` (one file
/// per NcsCategory, filename == NcsCategory.code) instead of hardcoded Dart
/// so the question bank can grow large without touching Dart source.
Future<List<Question>> buildSeedQuestions() async {
  final list = <Question>[];

  for (final category in NcsCategory.values) {
    final path = 'assets/questions/${category.code}.json';
    late final String raw;
    try {
      raw = await rootBundle.loadString(path);
    } catch (_) {
      continue;
    }
    final entries = jsonDecode(raw) as List<dynamic>;
    var seq = 0;
    for (final entry in entries) {
      final map = entry as Map<String, dynamic>;
      seq++;
      list.add(Question(
        id: '${category.code}_${seq.toString().padLeft(3, '0')}',
        category: category,
        difficulty: DifficultyX.fromCode(map['difficulty'] as String),
        stem: map['stem'] as String,
        choices: (map['choices'] as List<dynamic>).cast<String>(),
        correctIndex: map['correctIndex'] as int,
        explanation: map['explanation'] as String,
        tags: (map['tags'] as List<dynamic>).cast<String>(),
      ));
    }
  }

  return list;
}
