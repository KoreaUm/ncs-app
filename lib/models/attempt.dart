class Attempt {
  final String id;
  final String? userId;
  final List<String> questionIds;
  final DateTime startedAt;
  final DateTime? finishedAt;
  final int totalTimeSeconds;

  const Attempt({
    required this.id,
    required this.userId,
    required this.questionIds,
    required this.startedAt,
    required this.finishedAt,
    required this.totalTimeSeconds,
  });

  Attempt copyWith({
    DateTime? finishedAt,
    int? totalTimeSeconds,
  }) {
    return Attempt(
      id: id,
      userId: userId,
      questionIds: questionIds,
      startedAt: startedAt,
      finishedAt: finishedAt ?? this.finishedAt,
      totalTimeSeconds: totalTimeSeconds ?? this.totalTimeSeconds,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'userId': userId,
      'questionIds': questionIds.join(','),
      'startedAt': startedAt.toIso8601String(),
      'finishedAt': finishedAt?.toIso8601String(),
      'totalTimeSeconds': totalTimeSeconds,
    };
  }

  factory Attempt.fromMap(Map<String, Object?> map) {
    return Attempt(
      id: map['id'] as String,
      userId: map['userId'] as String?,
      questionIds: (map['questionIds'] as String)
          .split(',')
          .where((e) => e.isNotEmpty)
          .toList(),
      startedAt: DateTime.parse(map['startedAt'] as String),
      finishedAt: map['finishedAt'] == null
          ? null
          : DateTime.parse(map['finishedAt'] as String),
      totalTimeSeconds: map['totalTimeSeconds'] as int,
    );
  }
}

class AttemptItem {
  final String id;
  final String attemptId;
  final String questionId;
  final int? answerIndex;
  final bool isCorrect;
  final int timeSpentSeconds;

  const AttemptItem({
    required this.id,
    required this.attemptId,
    required this.questionId,
    required this.answerIndex,
    required this.isCorrect,
    required this.timeSpentSeconds,
  });

  AttemptItem copyWith({
    int? answerIndex,
    bool? isCorrect,
    int? timeSpentSeconds,
  }) {
    return AttemptItem(
      id: id,
      attemptId: attemptId,
      questionId: questionId,
      answerIndex: answerIndex ?? this.answerIndex,
      isCorrect: isCorrect ?? this.isCorrect,
      timeSpentSeconds: timeSpentSeconds ?? this.timeSpentSeconds,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'attemptId': attemptId,
      'questionId': questionId,
      'answerIndex': answerIndex,
      'isCorrect': isCorrect ? 1 : 0,
      'timeSpentSeconds': timeSpentSeconds,
    };
  }

  factory AttemptItem.fromMap(Map<String, Object?> map) {
    return AttemptItem(
      id: map['id'] as String,
      attemptId: map['attemptId'] as String,
      questionId: map['questionId'] as String,
      answerIndex: map['answerIndex'] as int?,
      isCorrect: (map['isCorrect'] as int) == 1,
      timeSpentSeconds: map['timeSpentSeconds'] as int,
    );
  }
}
