import 'category.dart';

class Question {
  final String id;
  final NcsCategory category;
  final Difficulty difficulty;
  final String stem;
  final List<String> choices;
  final int correctIndex;
  final String explanation;
  final List<String> tags;

  const Question({
    required this.id,
    required this.category,
    required this.difficulty,
    required this.stem,
    required this.choices,
    required this.correctIndex,
    required this.explanation,
    required this.tags,
  });

  Question copyWith({
    String? id,
    NcsCategory? category,
    Difficulty? difficulty,
    String? stem,
    List<String>? choices,
    int? correctIndex,
    String? explanation,
    List<String>? tags,
  }) {
    return Question(
      id: id ?? this.id,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      stem: stem ?? this.stem,
      choices: choices ?? this.choices,
      correctIndex: correctIndex ?? this.correctIndex,
      explanation: explanation ?? this.explanation,
      tags: tags ?? this.tags,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'category': category.code,
      'difficulty': difficulty.code,
      'stem': stem,
      'choices': choices.join('|||'),
      'correctIndex': correctIndex,
      'explanation': explanation,
      'tags': tags.join(','),
    };
  }

  factory Question.fromMap(Map<String, Object?> map) {
    return Question(
      id: map['id'] as String,
      category: NcsCategoryX.fromCode(map['category'] as String),
      difficulty: DifficultyX.fromCode(map['difficulty'] as String),
      stem: map['stem'] as String,
      choices: (map['choices'] as String).split('|||'),
      correctIndex: map['correctIndex'] as int,
      explanation: map['explanation'] as String,
      tags: (map['tags'] as String).isEmpty
          ? <String>[]
          : (map['tags'] as String).split(','),
    );
  }
}
