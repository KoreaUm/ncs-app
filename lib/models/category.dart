enum NcsCategory {
  communication,
  numeracy,
  problemSolving,
  selfDevelopment,
  resourceManagement,
  interpersonal,
  information,
  technology,
  organization,
  ethics,
}

extension NcsCategoryX on NcsCategory {
  String get label => switch (this) {
        NcsCategory.communication => '의사소통능력',
        NcsCategory.numeracy => '수리능력',
        NcsCategory.problemSolving => '문제해결능력',
        NcsCategory.selfDevelopment => '자기개발능력',
        NcsCategory.resourceManagement => '자원관리능력',
        NcsCategory.interpersonal => '대인관계능력',
        NcsCategory.information => '정보능력',
        NcsCategory.technology => '기술능력',
        NcsCategory.organization => '조직이해능력',
        NcsCategory.ethics => '직업윤리',
      };

  String get code => name;

  static NcsCategory fromCode(String code) {
    return NcsCategory.values.firstWhere(
      (e) => e.name == code,
      orElse: () => throw ArgumentError('Unknown category code: $code'),
    );
  }

  static NcsCategory? fromLabel(String label) {
    for (final c in NcsCategory.values) {
      if (c.label == label) return c;
    }
    return null;
  }
}

enum Difficulty { low, mid, high }

extension DifficultyX on Difficulty {
  String get label => switch (this) {
        Difficulty.low => '하',
        Difficulty.mid => '중',
        Difficulty.high => '상',
      };

  String get code => name;

  static Difficulty fromCode(String code) {
    return Difficulty.values.firstWhere(
      (e) => e.name == code,
      orElse: () => throw ArgumentError('Unknown difficulty code: $code'),
    );
  }

  static Difficulty? fromLabel(String label) {
    for (final d in Difficulty.values) {
      if (d.label == label) return d;
    }
    return null;
  }
}
