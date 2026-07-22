import 'category.dart';

class QuestionSet {
  final String id;
  final String title;
  final List<NcsCategory> categoryFilter;
  final int count;
  final List<String> questionIds;
  final String shareCode;

  const QuestionSet({
    required this.id,
    required this.title,
    required this.categoryFilter,
    required this.count,
    required this.questionIds,
    required this.shareCode,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'categoryFilter': categoryFilter.map((e) => e.code).join(','),
      'count': count,
      'questionIds': questionIds.join(','),
      'shareCode': shareCode,
    };
  }

  factory QuestionSet.fromMap(Map<String, Object?> map) {
    return QuestionSet(
      id: map['id'] as String,
      title: map['title'] as String,
      categoryFilter: (map['categoryFilter'] as String)
          .split(',')
          .where((e) => e.isNotEmpty)
          .map(NcsCategoryX.fromCode)
          .toList(),
      count: map['count'] as int,
      questionIds: (map['questionIds'] as String)
          .split(',')
          .where((e) => e.isNotEmpty)
          .toList(),
      shareCode: map['shareCode'] as String,
    );
  }
}
