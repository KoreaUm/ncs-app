import '../models/category.dart';
import '../models/question.dart';

List<Question> buildSeedQuestions() {
  final list = <Question>[];
  int seq = 0;
  String nextId(String prefix) {
    seq++;
    return '${prefix}_${seq.toString().padLeft(3, '0')}';
  }

  void add({
    required NcsCategory category,
    required Difficulty difficulty,
    required String stem,
    required List<String> choices,
    required int correctIndex,
    required String explanation,
    required List<String> tags,
  }) {
    list.add(Question(
      id: nextId(category.code),
      category: category,
      difficulty: difficulty,
      stem: stem,
      choices: choices,
      correctIndex: correctIndex,
      explanation: explanation,
      tags: tags,
    ));
  }

  // 의사소통능력
  add(
    category: NcsCategory.communication,
    difficulty: Difficulty.low,
    stem: '업무용 이메일 작성 시 유의사항으로 가장 적절한 것은?',
    choices: [
      '제목은 비워두고 본문에만 용건을 자세히 적는다',
      '제목에 핵심 용건을 간결하게 요약해서 적는다',
      '여러 용건은 구분 없이 한 문단에 몰아서 적는다',
      '받는 사람이 알아서 파악하도록 배경 설명은 생략한다',
    ],
    correctIndex: 1,
    explanation: '이메일 제목만으로도 용건을 파악할 수 있도록 핵심 내용을 간결하게 요약해서 적는 것이 좋다.',
    tags: ['문서작성'],
  );
  add(
    category: NcsCategory.communication,
    difficulty: Difficulty.low,
    stem: '상대방의 말을 경청할 때 바람직한 태도가 아닌 것은?',
    choices: [
      '말하는 사람과 시선을 맞춘다',
      '중간에 끊지 않고 끝까지 듣는다',
      '다음에 할 말을 미리 생각하느라 상대의 말을 흘려듣는다',
      '중요한 내용은 메모하며 듣는다',
    ],
    correctIndex: 2,
    explanation: '경청은 상대의 말에 온전히 집중하는 것이 핵심이며, 반박이나 다음 말을 준비하느라 흘려듣는 것은 바람직한 경청 태도가 아니다.',
    tags: ['경청능력'],
  );
  add(
    category: NcsCategory.communication,
    difficulty: Difficulty.mid,
    stem:
        '다음 공지문을 읽고 내용과 일치하는 것을 고르시오.\n\n[공지] 2026년 8월부터 전 직원은 주 2회까지 재택근무를 신청할 수 있습니다. 단, 신청은 근무 시작일 최소 3일 전까지 부서장의 승인을 받아야 하며, 고객 응대 부서는 월 4회로 제한합니다.',
    choices: [
      '모든 직원은 승인 없이 자유롭게 재택근무를 신청할 수 있다',
      '고객 응대 부서는 일반 부서보다 재택근무 가능 횟수가 더 적다',
      '재택근무는 근무 당일 신청해도 무방하다',
      '일반 부서의 재택근무 한도는 월 4회이다',
    ],
    correctIndex: 1,
    explanation:
        '일반 부서는 주 2회(월 약 8회)까지 가능하지만 고객 응대 부서는 월 4회로 더 제한적이므로, 고객 응대 부서의 재택근무 가능 횟수가 더 적다.',
    tags: ['문서이해'],
  );
  add(
    category: NcsCategory.communication,
    difficulty: Difficulty.mid,
    stem: '발표를 할 때 청중의 이해를 돕기 위한 방법으로 가장 적절하지 않은 것은?',
    choices: [
      '핵심 내용을 먼저 제시하고 세부사항을 설명한다',
      '전문용어는 최소화하거나 풀어서 설명한다',
      '시간 안에 모든 내용을 담기 위해 빠르게 말하기만 한다',
      '시각자료를 활용해 이해를 돕는다',
    ],
    correctIndex: 2,
    explanation: '내용을 빠르게 말하기만 하면 청중의 이해도가 떨어지므로, 핵심 위주로 속도를 조절하며 전달하는 것이 바람직하다.',
    tags: ['의사표현능력'],
  );
  add(
    category: NcsCategory.communication,
    difficulty: Difficulty.mid,
    stem: '보고서 작성 시 일반적인 구성 순서로 가장 적절한 것은?',
    choices: [
      '결론 → 본론 → 서론',
      '서론 → 본론 → 결론',
      '본론 → 서론 → 결론',
      '결론과 서론을 동시에 제시',
    ],
    correctIndex: 1,
    explanation: '일반적인 보고서는 배경과 목적을 밝히는 서론, 세부 내용을 다루는 본론, 요약과 제언을 담는 결론 순으로 구성한다.',
    tags: ['문서작성'],
  );
  add(
    category: NcsCategory.communication,
    difficulty: Difficulty.high,
    stem: '다음 중 거래처에 미팅 일정 변경을 정중하게 요청하는 영어 표현으로 가장 적절한 것은?',
    choices: [
      '"Change the meeting now."',
      '"I was wondering if we could reschedule our meeting to a later date."',
      '"Meeting time is wrong, fix it."',
      '"You must come at a different time."',
    ],
    correctIndex: 1,
    explanation: '비즈니스 상황에서는 완곡하고 정중한 요청 표현("I was wondering if...")을 사용하는 것이 적절하다.',
    tags: ['기초외국어능력'],
  );
  add(
    category: NcsCategory.communication,
    difficulty: Difficulty.high,
    stem:
        '다음 자료를 보고 올바르게 추론한 것은?\n\n[신입사원 만족도 조사] 응답자의 65%는 "업무 강도"를, 20%는 "보수 수준"을, 15%는 "조직문화"를 개선이 시급한 항목으로 꼽았다.',
    choices: [
      '응답자의 과반수 이상이 업무 강도 개선을 가장 시급하다고 답했다',
      '보수 수준을 꼽은 응답자가 가장 많다',
      '조직문화 개선을 요구한 응답자는 응답자의 절반이 넘는다',
      '세 항목의 응답 비율은 모두 같다',
    ],
    correctIndex: 0,
    explanation: '65%는 과반수(50%)를 넘으므로, 업무 강도 개선을 가장 시급하다고 답한 응답자가 과반수 이상이라는 진술이 옳다.',
    tags: ['문서이해', '도표해석'],
  );
  add(
    category: NcsCategory.communication,
    difficulty: Difficulty.high,
    stem: '동료가 감정적으로 항의할 때 가장 바람직한 대응은?',
    choices: [
      '즉시 맞받아 언성을 높인다',
      '상대의 말을 끊고 반박부터 한다',
      '우선 상대의 이야기를 끝까지 듣고 감정을 인정한 뒤 사실관계를 확인한다',
      '불편하니 대화를 피한다',
    ],
    correctIndex: 2,
    explanation: '감정적인 상황일수록 먼저 상대의 이야기를 경청하고 감정을 인정한 뒤, 사실관계를 차분히 확인하는 것이 바람직하다.',
    tags: ['의사표현능력', '경청능력'],
  );

  // 수리능력
  add(
    category: NcsCategory.numeracy,
    difficulty: Difficulty.low,
    stem: '어떤 두 자연수의 합은 48이고 차는 12이다. 두 수 중 큰 수는?',
    choices: ['30', '28', '32', '26'],
    correctIndex: 0,
    explanation: '두 수를 x, y(x>y)라 하면 x+y=48, x-y=12이므로 두 식을 더하면 2x=60, x=30이다.',
    tags: ['기초연산'],
  );
  add(
    category: NcsCategory.numeracy,
    difficulty: Difficulty.low,
    stem:
        '원가 8,000원인 물건에 25%의 이익을 붙여 정가를 매겼다가, 정가에서 20% 할인하여 판매하였다. 이 물건의 판매가는?',
    choices: ['7,000원', '7,500원', '8,000원', '8,500원'],
    correctIndex: 2,
    explanation: '정가는 8,000×1.25=10,000원이고, 판매가는 10,000×(1-0.2)=8,000원이다.',
    tags: ['기초연산', '퍼센트'],
  );
  add(
    category: NcsCategory.numeracy,
    difficulty: Difficulty.mid,
    stem:
        'A는 시속 60km로 목적지를 향해 출발했다. 30분 후 같은 경로로 B가 시속 90km로 A를 뒤따라 출발했다면, B가 출발한 시점을 기준으로 몇 시간 후에 A를 따라잡는가?',
    choices: ['45분', '1시간', '1시간 30분', '2시간'],
    correctIndex: 1,
    explanation:
        'A가 출발한 지 t시간 후 위치는 60t, B가 출발한 지 (t-0.5)시간 후 위치는 90(t-0.5)이다. 두 값을 같다고 놓으면 60t=90t-45, t=1.5시간이며, 이는 B가 출발한 시점(0.5시간)으로부터 1시간 후이다.',
    tags: ['응용수리', '거리속력시간'],
  );
  add(
    category: NcsCategory.numeracy,
    difficulty: Difficulty.mid,
    stem: '10%의 소금물 200g에 소금 20g을 추가로 넣으면 몇 %의 소금물이 되는가? (소수 둘째 자리에서 반올림)',
    choices: ['15.0%', '16.7%', '18.2%', '20.0%'],
    correctIndex: 2,
    explanation:
        '처음 소금의 양은 200×0.1=20g이고, 소금 20g을 추가하면 소금 40g, 전체 220g이 되어 농도는 40/220×100≈18.2%이다.',
    tags: ['응용수리', '농도'],
  );
  add(
    category: NcsCategory.numeracy,
    difficulty: Difficulty.mid,
    stem:
        '다음은 어느 회사의 최근 4년간 매출액이다.\n2022년 120억 원, 2023년 132억 원, 2024년 145억 원, 2025년 150억 원.\n2023년 대비 2024년의 매출 증가율은 약 얼마인가? (소수 둘째 자리에서 반올림)',
    choices: ['8.5%', '9.8%', '10.5%', '11.2%'],
    correctIndex: 1,
    explanation: '(145-132)/132×100 ≈ 9.8%이다.',
    tags: ['도표분석', '증감률'],
  );
  add(
    category: NcsCategory.numeracy,
    difficulty: Difficulty.high,
    stem: '혼자 하면 12일 걸리는 일을 A가, 혼자 하면 8일 걸리는 일을 B가 맡았다. 두 사람이 함께 일하면 며칠이 걸리는가?',
    choices: ['4.5일', '4.8일', '5.2일', '6일'],
    correctIndex: 1,
    explanation:
        'A의 하루 작업량은 1/12, B의 하루 작업량은 1/8이므로 합은 1/12+1/8=5/24이다. 전체 일을 마치는 데 24/5=4.8일이 걸린다.',
    tags: ['응용수리', '일률'],
  );
  add(
    category: NcsCategory.numeracy,
    difficulty: Difficulty.high,
    stem: '서로 다른 사무용품 5개 중 3개를 골라 순서 없이 묶어 배치하려 한다. 가능한 조합의 수는?',
    choices: ['10가지', '15가지', '20가지', '60가지'],
    correctIndex: 0,
    explanation: '순서를 고려하지 않는 조합이므로 5C3=10가지이다.',
    tags: ['경우의수'],
  );
  add(
    category: NcsCategory.numeracy,
    difficulty: Difficulty.high,
    stem: '자료를 막대그래프로 나타낼 때, 수치를 왜곡 없이 전달하기 위한 축 설정 방법으로 가장 적절한 것은?',
    choices: [
      'y축은 항상 0이 아닌 임의의 값에서 시작한다',
      'y축은 0부터 시작하고 눈금 간격을 일정하게 유지한다',
      '눈금 간격은 강조하고 싶은 항목만 다르게 설정한다',
      'y축의 단위는 표시하지 않아도 무방하다',
    ],
    correctIndex: 1,
    explanation: '막대그래프의 y축을 0부터 시작하고 일정한 간격을 유지해야 수치 차이가 실제 비율대로 왜곡 없이 전달된다.',
    tags: ['도표작성'],
  );

  // 문제해결능력
  add(
    category: NcsCategory.problemSolving,
    difficulty: Difficulty.low,
    stem: '"비가 오면 우산을 챙긴다"가 참일 때, 이 명제로부터 반드시 참이라고 할 수 있는 것은?',
    choices: [
      '우산을 챙기면 비가 온 것이다',
      '비가 오지 않으면 우산을 챙기지 않는다',
      '우산을 챙기지 않았다면 비가 오지 않은 것이다',
      '비가 오지 않아도 우산을 챙길 수 있다',
    ],
    correctIndex: 2,
    explanation: '원명제의 대우(우산을 챙기지 않았다면 비가 오지 않았다)는 원명제와 항상 참/거짓이 일치하므로 반드시 참이다.',
    tags: ['명제추론'],
  );
  add(
    category: NcsCategory.problemSolving,
    difficulty: Difficulty.low,
    stem: '문제를 "발생형, 탐색형, 설정형"으로 구분할 때, 이미 발생하여 원인 규명과 대책이 필요한 문제는?',
    choices: ['발생형 문제', '탐색형 문제', '설정형 문제', '미래형 문제'],
    correctIndex: 0,
    explanation: '발생형 문제는 이미 눈앞에 발생하여 원인을 분석하고 해결해야 하는 문제를 말한다.',
    tags: ['문제유형'],
  );
  add(
    category: NcsCategory.problemSolving,
    difficulty: Difficulty.mid,
    stem:
        'A, B, C, D 네 사람이 일렬로 줄을 선다. "C는 B 바로 앞에 선다"는 조건만 주어졌을 때, 이 조건으로부터 항상 참이라고 할 수 있는 것은?',
    choices: [
      'A는 항상 두 번째에 선다',
      'B는 절대 첫 번째에 설 수 없다',
      'D는 항상 C보다 앞에 선다',
      'A와 D는 항상 붙어 선다',
    ],
    correctIndex: 1,
    explanation: 'C가 B 바로 앞에 서려면 B 앞에 반드시 한 자리가 있어야 하므로, B는 첫 번째 자리에 설 수 없다. 나머지는 주어진 조건만으로는 확정할 수 없다.',
    tags: ['조건추리'],
  );
  add(
    category: NcsCategory.problemSolving,
    difficulty: Difficulty.mid,
    stem: 'SWOT 분석에서 "경쟁사의 신제품 출시"는 어느 항목에 해당하는가?',
    choices: ['강점(Strength)', '약점(Weakness)', '기회(Opportunity)', '위협(Threat)'],
    correctIndex: 3,
    explanation: '경쟁사의 신제품 출시는 외부 환경에서 비롯된 부정적 요인이므로 위협(Threat)에 해당한다.',
    tags: ['SWOT분석'],
  );
  add(
    category: NcsCategory.problemSolving,
    difficulty: Difficulty.mid,
    stem: '일반적인 문제해결 절차를 순서대로 나열한 것은?',
    choices: [
      '원인분석 → 문제인식 → 해결안개발 → 실행 및 평가',
      '문제인식 → 원인분석 → 해결안개발 → 실행 및 평가',
      '해결안개발 → 문제인식 → 원인분석 → 실행 및 평가',
      '실행 및 평가 → 문제인식 → 원인분석 → 해결안개발',
    ],
    correctIndex: 1,
    explanation: '문제해결은 일반적으로 문제를 인식하고, 원인을 분석한 뒤 해결안을 개발하여 실행하고 평가하는 순서로 진행된다.',
    tags: ['문제해결절차'],
  );
  add(
    category: NcsCategory.problemSolving,
    difficulty: Difficulty.high,
    stem:
        '"예산을 초과한 부서는 반드시 전월 대비 지출이 증가했다"는 전제가 참일 때, 이로부터 항상 참이라고 할 수 있는 것은?',
    choices: [
      '지출이 증가한 부서는 반드시 예산을 초과했다',
      '예산을 초과하지 않은 부서는 지출이 감소했다',
      '예산을 초과한 부서는 전월보다 지출이 증가했다',
      '모든 부서의 지출이 증가했다',
    ],
    correctIndex: 2,
    explanation: '주어진 전제를 그대로 재진술한 것이 항상 참이며, 나머지는 역이나 이에 해당해 전제만으로는 참이라고 확정할 수 없다.',
    tags: ['명제추론'],
  );
  add(
    category: NcsCategory.problemSolving,
    difficulty: Difficulty.high,
    stem: '브레인스토밍의 4대 원칙에 해당하지 않는 것은?',
    choices: [
      '자유로운 발상을 허용한다',
      '양보다 질을 우선하여 아이디어 수를 최소화한다',
      '타인의 아이디어에 대한 비판을 금지한다',
      '제시된 아이디어의 결합과 개선을 장려한다',
    ],
    correctIndex: 1,
    explanation: '브레인스토밍은 질보다 양을 우선하여 가능한 한 많은 아이디어를 자유롭게 내는 것을 원칙으로 한다.',
    tags: ['창의적사고'],
  );
  add(
    category: NcsCategory.problemSolving,
    difficulty: Difficulty.high,
    stem: '설비 고장의 근본 원인을 찾기 위해 "왜?"라는 질문을 반복해서 던지는 기법은?',
    choices: ['SWOT 분석', '5Whys 기법', '브레인스토밍', '벤치마킹'],
    correctIndex: 1,
    explanation: '5Whys 기법은 "왜?"를 반복해서 질문하며 근본 원인을 파고드는 문제해결 기법이다.',
    tags: ['문제처리능력'],
  );

  // 자기개발능력
  add(
    category: NcsCategory.selfDevelopment,
    difficulty: Difficulty.low,
    stem: '직업기초능력에서 "자아인식"이 의미하는 것으로 가장 적절한 것은?',
    choices: [
      '타인의 평가에만 의존해 자신을 판단하는 것',
      '자신의 흥미, 적성, 특성 등을 스스로 파악하는 것',
      '과거의 실수를 반복해서 회상하는 것',
      '자신의 단점을 무시하고 장점만 생각하는 것',
    ],
    correctIndex: 1,
    explanation: '자아인식은 자신의 흥미, 적성, 성격, 가치관 등을 스스로 정확히 파악하는 것을 의미한다.',
    tags: ['자아인식'],
  );
  add(
    category: NcsCategory.selfDevelopment,
    difficulty: Difficulty.low,
    stem: '자기관리 절차 중 가장 먼저 이루어져야 하는 단계는?',
    choices: ['실행 및 수행', '과제 발견', '비전 및 목표 수립', '반성 및 평가'],
    correctIndex: 2,
    explanation: '자기관리는 비전과 목표를 수립하는 것에서 시작하여 과제 발견, 일정 수립, 수행, 반성 및 평가 순으로 진행된다.',
    tags: ['자기관리'],
  );
  add(
    category: NcsCategory.selfDevelopment,
    difficulty: Difficulty.mid,
    stem: '일반적인 경력개발 단계를 순서대로 나열하면?',
    choices: [
      '경력말기 → 경력초기 → 경력중기 → 직업선택',
      '직업선택 → 조직입사 → 경력초기 → 경력중기 → 경력말기',
      '조직입사 → 직업선택 → 경력중기 → 경력초기',
      '경력중기 → 조직입사 → 직업선택 → 경력말기',
    ],
    correctIndex: 1,
    explanation: '경력개발은 일반적으로 직업선택, 조직입사, 경력초기, 경력중기, 경력말기의 순서로 진행된다.',
    tags: ['경력개발'],
  );
  add(
    category: NcsCategory.selfDevelopment,
    difficulty: Difficulty.mid,
    stem: '동료가 자신의 성과를 부풀려 상사에게 보고하는 것을 목격했다. 가장 바람직한 태도는?',
    choices: [
      '못 본 척 넘어간다',
      '똑같이 성과를 부풀려 보고한다',
      '사실관계를 확인하고 필요하다면 정직하게 문제를 제기한다',
      '동료를 즉시 상사에게 고발한다',
    ],
    correctIndex: 2,
    explanation: '감정적으로 대응하기보다 사실관계를 먼저 확인하고, 필요하다면 정직하고 신중하게 문제를 제기하는 것이 바람직하다.',
    tags: ['자기관리'],
  );
  add(
    category: NcsCategory.selfDevelopment,
    difficulty: Difficulty.mid,
    stem: '다음 중 자기개발을 방해하는 요인으로 가장 거리가 먼 것은?',
    choices: [
      '자신의 욕구와 감정에 대한 통제 부족',
      '제한적으로 사고하는 습관',
      '현재 익숙한 상황에 안주하려는 태도',
      '정기적으로 목표를 점검하고 수정하는 습관',
    ],
    correctIndex: 3,
    explanation: '정기적으로 목표를 점검하고 수정하는 것은 자기개발을 돕는 바람직한 습관이지 방해요인이 아니다.',
    tags: ['자기관리'],
  );
  add(
    category: NcsCategory.selfDevelopment,
    difficulty: Difficulty.high,
    stem: '"흥미"와 "적성"의 차이를 가장 올바르게 설명한 것은?',
    choices: [
      '흥미는 일을 잘 할 수 있는 능력이고, 적성은 좋아하는 마음이다',
      '흥미는 일에 대해 좋아하는 감정이며, 적성은 그 일을 잘 할 수 있는 재능이다',
      '둘은 완전히 같은 개념이다',
      '적성은 타고나는 것이므로 절대 개발할 수 없다',
    ],
    correctIndex: 1,
    explanation: '흥미는 어떤 일에 대해 좋아하거나 즐거움을 느끼는 감정이고, 적성은 그 일을 잘 수행할 수 있는 재능이나 능력을 의미한다.',
    tags: ['자아인식'],
  );
  add(
    category: NcsCategory.selfDevelopment,
    difficulty: Difficulty.high,
    stem: '목표 설정 시 SMART 원칙에 해당하지 않는 것은?',
    choices: ['구체적(Specific)', '측정 가능한(Measurable)', '모호하고 추상적인(Ambiguous)', '기한이 있는(Time-bound)'],
    correctIndex: 2,
    explanation: 'SMART 원칙은 구체적, 측정가능, 달성가능, 관련성 있는, 기한이 있는 목표를 의미하며 모호하고 추상적인 것과는 반대된다.',
    tags: ['경력개발'],
  );
  add(
    category: NcsCategory.selfDevelopment,
    difficulty: Difficulty.high,
    stem: '업무 수행 후 "성찰"이 중요한 이유로 가장 적절한 것은?',
    choices: [
      '잘못을 감추기 위해서',
      '동일한 실수를 반복하지 않고 지속적으로 성장하기 위해서',
      '타인에게 책임을 전가하기 위해서',
      '업무 속도를 늦추기 위해서',
    ],
    correctIndex: 1,
    explanation: '성찰을 통해 자신의 업무 수행 과정을 돌아보면 동일한 실수를 반복하지 않고 지속적으로 성장할 수 있다.',
    tags: ['자기관리'],
  );

  // 자원관리능력
  add(
    category: NcsCategory.resourceManagement,
    difficulty: Difficulty.low,
    stem: '자원관리의 기본 과정을 순서대로 나열하면?',
    choices: [
      '자원 확보 → 필요자원 파악 → 활용계획 수립 → 계획에 따른 수행',
      '필요자원 파악 → 확보 → 활용계획 수립 → 수행',
      '수행 → 필요자원 파악 → 확보 → 활용계획',
      '활용계획 수립 → 필요자원 파악 → 확보 → 수행',
    ],
    correctIndex: 1,
    explanation: '자원관리는 필요한 자원이 무엇인지 파악하고, 이를 확보한 뒤 활용계획을 세워 수행하는 순서로 이루어진다.',
    tags: ['자원관리기본'],
  );
  add(
    category: NcsCategory.resourceManagement,
    difficulty: Difficulty.low,
    stem: '"중요하지만 긴급하지 않은 일"은 시간관리 매트릭스에서 어디에 해당하는가?',
    choices: ['1사분면(긴급/중요)', '2사분면(중요/비긴급)', '3사분면(긴급/비중요)', '4사분면(비긴급/비중요)'],
    correctIndex: 1,
    explanation: '중요하지만 긴급하지 않은 일은 2사분면에 해당하며, 장기적 계획을 위해 꾸준히 시간을 투자해야 하는 영역이다.',
    tags: ['시간관리'],
  );
  add(
    category: NcsCategory.resourceManagement,
    difficulty: Difficulty.mid,
    stem:
        '출장 예산 100만 원 중 항공료 45만 원, 숙박비 30만 원을 지출했다. 남은 예산에서 하루 3만 원씩 5일치 식비를 사용하면 남는 금액은?',
    choices: ['5만 원', '10만 원', '15만 원', '20만 원'],
    correctIndex: 1,
    explanation: '100-45-30=25만 원이 남고, 식비로 3×5=15만 원을 사용하면 25-15=10만 원이 남는다.',
    tags: ['예산관리'],
  );
  add(
    category: NcsCategory.resourceManagement,
    difficulty: Difficulty.mid,
    stem: '물품을 효과적으로 관리하기 위한 원칙으로 가장 거리가 먼 것은?',
    choices: [
      '동일 및 유사 물품을 같은 장소에 보관한다',
      '회전율이 높은 물품은 접근이 쉬운 곳에 둔다',
      '보관 장소를 수시로 바꿔 위치를 예측할 수 없게 한다',
      '물품의 특성을 고려하여 보관 방법을 정한다',
    ],
    correctIndex: 2,
    explanation: '보관 장소가 수시로 바뀌면 필요할 때 물품을 찾기 어려워지므로, 일정한 위치에 체계적으로 보관해야 한다.',
    tags: ['물적자원관리'],
  );
  add(
    category: NcsCategory.resourceManagement,
    difficulty: Difficulty.mid,
    stem:
        '회의 장소까지 가는 경로가 두 가지 있다. A경로는 25km 구간을 시속 50km로, B경로는 32km 구간을 시속 80km로 이동한다. 어느 경로가 얼마나 더 빠른가?',
    choices: ['A경로가 6분 더 빠르다', 'B경로가 6분 더 빠르다', '두 경로의 소요시간은 같다', 'A경로가 10분 더 빠르다'],
    correctIndex: 1,
    explanation: 'A경로는 25/50=0.5시간(30분), B경로는 32/80=0.4시간(24분)이 걸리므로 B경로가 6분 더 빠르다.',
    tags: ['시간관리', '응용수리'],
  );
  add(
    category: NcsCategory.resourceManagement,
    difficulty: Difficulty.high,
    stem: '인적자원관리에서 "적재적소 배치"의 의미로 가장 적절한 것은?',
    choices: [
      '모든 직원을 동일한 업무에 배치한다',
      '개인의 능력과 성격에 맞는 자리에 배치하여 성과를 높인다',
      '직급이 높은 사람을 우선적으로 좋은 자리에 배치한다',
      '배치는 한 번 정해지면 변경하지 않는다',
    ],
    correctIndex: 1,
    explanation: '적재적소 배치란 개인의 능력, 적성, 성격 등을 고려해 가장 적합한 자리에 배치함으로써 성과를 극대화하는 것을 말한다.',
    tags: ['인적자원관리'],
  );
  add(
    category: NcsCategory.resourceManagement,
    difficulty: Difficulty.high,
    stem: '부서 예산 900만 원을 인원수 비율(A부서 3명, B부서 2명, C부서 4명)로 나눈다면 C부서가 받는 금액은?',
    choices: ['300만 원', '350만 원', '400만 원', '450만 원'],
    correctIndex: 2,
    explanation: '전체 인원은 9명이므로 1인당 900/9=100만 원이 배정되고, C부서(4명)는 100×4=400만 원을 받는다.',
    tags: ['예산관리', '응용수리'],
  );
  add(
    category: NcsCategory.resourceManagement,
    difficulty: Difficulty.high,
    stem: '다음 중 효과적인 시간관리 원칙으로 가장 적절하지 않은 것은?',
    choices: [
      '우선순위에 따라 일을 계획한다',
      '여유 시간을 전혀 남기지 않고 일정을 꽉 채운다',
      '유사한 성격의 업무는 묶어서 처리한다',
      '정기적으로 계획을 점검하고 조정한다',
    ],
    correctIndex: 1,
    explanation: '돌발 상황에 대비할 수 있도록 일정에 어느 정도 여유 시간을 두는 것이 효과적인 시간관리 원칙이다.',
    tags: ['시간관리'],
  );

  // 대인관계능력
  add(
    category: NcsCategory.interpersonal,
    difficulty: Difficulty.low,
    stem: '"팀워크"에 대한 설명으로 가장 적절한 것은?',
    choices: [
      '팀원 개개인이 독립적으로만 일하는 것',
      '팀원들이 공동의 목표를 위해 협력하여 시너지를 내는 것',
      '팀장의 지시를 무조건 따르는 것',
      '팀원 간 경쟁을 최우선으로 하는 것',
    ],
    correctIndex: 1,
    explanation: '팀워크는 팀원들이 공동의 목표 달성을 위해 서로 협력하여 개인의 합보다 큰 성과(시너지)를 내는 것을 의미한다.',
    tags: ['팀워크'],
  );
  add(
    category: NcsCategory.interpersonal,
    difficulty: Difficulty.low,
    stem: '구성원의 의견을 적극 반영하며 함께 의사결정을 하는 리더십 유형은?',
    choices: ['독재형 리더십', '민주형(참여적) 리더십', '방임형 리더십', '카리스마 리더십'],
    correctIndex: 1,
    explanation: '민주형(참여적) 리더십은 구성원의 의견을 적극적으로 반영하여 함께 의사결정을 내리는 방식이다.',
    tags: ['리더십'],
  );
  add(
    category: NcsCategory.interpersonal,
    difficulty: Difficulty.mid,
    stem: '팀 내 갈등이 발생했을 때 가장 바람직한 초기 대응은?',
    choices: [
      '갈등 당사자들을 즉시 다른 팀으로 분리한다',
      '갈등의 원인을 파악하고 당사자들의 입장을 각각 경청한다',
      '다수의 의견을 따르는 쪽으로 즉시 결정한다',
      '갈등을 무시하고 시간이 해결하도록 둔다',
    ],
    correctIndex: 1,
    explanation: '갈등 상황에서는 먼저 원인을 파악하고 당사자들의 입장을 충분히 경청하는 것이 바람직한 초기 대응이다.',
    tags: ['갈등관리'],
  );
  add(
    category: NcsCategory.interpersonal,
    difficulty: Difficulty.mid,
    stem: '협상에서 "윈-윈(Win-Win)" 전략에 대한 설명으로 가장 적절한 것은?',
    choices: [
      '한쪽이 모든 것을 얻고 다른 쪽은 전혀 얻지 못하는 전략',
      '양측 모두 만족할 수 있는 대안을 찾는 전략',
      '협상을 최대한 지연시키는 전략',
      '상대방의 요구를 무조건 수용하는 전략',
    ],
    correctIndex: 1,
    explanation: '윈-윈 전략은 협상 당사자 양측이 모두 만족할 수 있는 대안을 찾아내는 것을 목표로 한다.',
    tags: ['협상능력'],
  );
  add(
    category: NcsCategory.interpersonal,
    difficulty: Difficulty.mid,
    stem: '고객이 강하게 불만을 제기할 때 가장 적절한 초기 대응은?',
    choices: [
      '회사 규정을 먼저 나열하며 반박한다',
      '고객의 말을 끝까지 경청하고 불편함에 공감을 표현한다',
      '다른 직원에게 즉시 미룬다',
      '고객의 감정이 가라앉을 때까지 응답을 미룬다',
    ],
    correctIndex: 1,
    explanation: '불만 고객을 응대할 때는 먼저 이야기를 끝까지 경청하고 불편함에 공감을 표현한 뒤 해결 방안을 제시하는 것이 바람직하다.',
    tags: ['고객서비스능력'],
  );
  add(
    category: NcsCategory.interpersonal,
    difficulty: Difficulty.high,
    stem: '리더십에서 "임파워먼트(empowerment)"의 의미로 가장 적절한 것은?',
    choices: [
      '구성원에게 권한과 책임을 위임하여 자율적으로 일하게 하는 것',
      '모든 의사결정을 리더가 독점하는 것',
      '구성원의 실수를 철저히 통제하는 것',
      '성과가 낮은 직원을 조직에서 배제하는 것',
    ],
    correctIndex: 0,
    explanation: '임파워먼트는 구성원에게 적절한 권한과 책임을 위임하여 자율적이고 주도적으로 업무를 수행하게 하는 것을 의미한다.',
    tags: ['리더십'],
  );
  add(
    category: NcsCategory.interpersonal,
    difficulty: Difficulty.high,
    stem: '조직에 대한 헌신도와 비판적 사고 모두 높은 멤버십 유형은?',
    choices: ['소외형', '순응형', '실무형', '주도형'],
    correctIndex: 3,
    explanation: '주도형 멤버십은 조직에 대한 헌신도와 독립적·비판적 사고 수준이 모두 높은 이상적인 멤버십 유형이다.',
    tags: ['팀워크'],
  );
  add(
    category: NcsCategory.interpersonal,
    difficulty: Difficulty.high,
    stem: '협상 과정에서 신뢰를 구축하기 위한 방법으로 가장 거리가 먼 것은?',
    choices: [
      '상대방의 입장을 이해하려 노력한다',
      '약속한 사항은 반드시 지킨다',
      '상황에 따라 근거 없이 말을 자주 바꾼다',
      '정직하고 일관된 태도를 유지한다',
    ],
    correctIndex: 2,
    explanation: '근거 없이 말을 자주 바꾸는 태도는 신뢰를 무너뜨리므로 협상 시 지양해야 한다.',
    tags: ['협상능력'],
  );

  // 정보능력
  add(
    category: NcsCategory.information,
    difficulty: Difficulty.low,
    stem: '정보처리의 일반적 절차를 순서대로 나열한 것은?',
    choices: [
      '정보 활용 → 기획 → 수집 → 관리',
      '기획 → 수집 → 관리 → 활용',
      '수집 → 활용 → 기획 → 관리',
      '관리 → 기획 → 수집 → 활용',
    ],
    correctIndex: 1,
    explanation: '정보처리는 필요한 정보를 기획하고 수집한 뒤, 이를 관리하여 활용하는 순서로 이루어진다.',
    tags: ['정보처리능력'],
  );
  add(
    category: NcsCategory.information,
    difficulty: Difficulty.low,
    stem: '엑셀에서 특정 범위의 합계를 구하는 함수는?',
    choices: ['=AVERAGE()', '=SUM()', '=COUNT()', '=IF()'],
    correctIndex: 1,
    explanation: '=SUM() 함수는 지정한 범위의 값을 모두 더하는 함수이다.',
    tags: ['컴퓨터활용능력'],
  );
  add(
    category: NcsCategory.information,
    difficulty: Difficulty.mid,
    stem: '셀 A1에 =IF(B1>=80,"합격","불합격")이 입력되어 있고 B1의 값이 75일 때, A1에 표시되는 값은?',
    choices: ['합격', '불합격', '75', '오류'],
    correctIndex: 1,
    explanation: 'B1(75)이 80 이상이 아니므로 조건이 거짓이 되어 "불합격"이 표시된다.',
    tags: ['컴퓨터활용능력', '엑셀함수'],
  );
  add(
    category: NcsCategory.information,
    difficulty: Difficulty.mid,
    stem: '인터넷 검색 시 정확도를 높이는 방법으로 가장 적절한 것은?',
    choices: [
      '최대한 짧고 모호한 단어 하나만 입력한다',
      '따옴표를 사용해 정확한 문구를 지정하여 검색한다',
      '광고성 링크를 우선적으로 신뢰한다',
      '검색 결과의 출처를 확인하지 않는다',
    ],
    correctIndex: 1,
    explanation: '따옴표를 사용해 정확한 문구를 지정하면 검색 결과의 정확도를 높일 수 있다.',
    tags: ['정보처리능력'],
  );
  add(
    category: NcsCategory.information,
    difficulty: Difficulty.mid,
    stem: '엑셀에서 다른 표의 값을 참조하여 원하는 데이터를 가져올 때 주로 사용하는 함수는?',
    choices: ['=VLOOKUP()', '=SUM()', '=TODAY()', '=LEN()'],
    correctIndex: 0,
    explanation: '=VLOOKUP() 함수는 지정한 값을 기준으로 다른 표에서 원하는 데이터를 찾아오는 함수이다.',
    tags: ['컴퓨터활용능력', '엑셀함수'],
  );
  add(
    category: NcsCategory.information,
    difficulty: Difficulty.high,
    stem: '다음 중 정보윤리에 어긋나는 행동은?',
    choices: [
      '출처를 명시하고 자료를 인용한다',
      '타인의 저작물을 허락 없이 그대로 복제하여 배포한다',
      '개인정보를 다룰 때 최소한의 정보만 수집한다',
      '공유 자료의 라이선스를 확인 후 사용한다',
    ],
    correctIndex: 1,
    explanation: '타인의 저작물을 허락 없이 복제하고 배포하는 행위는 저작권을 침해하는 정보윤리 위반 행위이다.',
    tags: ['정보처리능력'],
  );
  add(
    category: NcsCategory.information,
    difficulty: Difficulty.high,
    stem: '"입력값이 짝수이면 2로 나누고, 홀수이면 3을 곱한다"는 규칙을 15에 적용했을 때 결과는?',
    choices: ['45', '7.5', '30', '5'],
    correctIndex: 0,
    explanation: '15는 홀수이므로 3을 곱하는 규칙이 적용되어 15×3=45가 된다.',
    tags: ['정보처리능력', '알고리즘'],
  );
  add(
    category: NcsCategory.information,
    difficulty: Difficulty.high,
    stem: '여러 사용자가 데이터를 공유하며 중복을 최소화하도록 체계적으로 통합 관리하는 데이터 집합을 무엇이라 하는가?',
    choices: ['스프레드시트', '데이터베이스', '텍스트파일', '이메일'],
    correctIndex: 1,
    explanation: '데이터베이스는 여러 사용자가 공유하며 중복을 최소화하도록 체계적으로 통합 관리되는 데이터의 집합이다.',
    tags: ['컴퓨터활용능력'],
  );

  // 기술능력
  add(
    category: NcsCategory.technology,
    difficulty: Difficulty.low,
    stem: '"기술능력"에 대한 설명으로 가장 적절한 것은?',
    choices: [
      '전문 기술자만 필요한 능력이다',
      '직업인이 업무 수행에 필요한 기술을 이해하고 선택, 적용하는 능력이다',
      '최신 기술을 무조건 도입하는 능력이다',
      '기술 매뉴얼을 암기하는 능력이다',
    ],
    correctIndex: 1,
    explanation: '기술능력은 전문 기술자뿐 아니라 모든 직업인이 업무에 필요한 기술을 이해하고 적절히 선택, 적용하는 능력을 의미한다.',
    tags: ['기술이해'],
  );
  add(
    category: NcsCategory.technology,
    difficulty: Difficulty.low,
    stem: '제품 매뉴얼을 활용할 때 가장 바람직한 태도는?',
    choices: [
      '문제가 생겨도 매뉴얼을 보지 않고 임의로 조치한다',
      '사용 전 안전 수칙과 주의사항을 먼저 확인한다',
      '매뉴얼은 참고용일 뿐이므로 무시해도 된다',
      '매뉴얼의 경고 표시는 중요하지 않다',
    ],
    correctIndex: 1,
    explanation: '제품을 사용하기 전 매뉴얼의 안전 수칙과 주의사항을 먼저 확인하는 것이 안전사고를 예방하는 바람직한 태도이다.',
    tags: ['기술적용'],
  );
  add(
    category: NcsCategory.technology,
    difficulty: Difficulty.mid,
    stem: '새로운 설비 도입 시 기술 선택 기준으로 가장 거리가 먼 것은?',
    choices: [
      '설비의 성능과 안전성',
      '유지보수 비용과 편의성',
      '주변 동료의 개인적 취향',
      '설치 및 운영에 필요한 비용',
    ],
    correctIndex: 2,
    explanation: '기술 선택은 성능, 안전성, 비용, 유지보수 등 객관적 기준으로 이루어져야 하며 개인적 취향은 합리적 기준이 아니다.',
    tags: ['기술선택'],
  );
  add(
    category: NcsCategory.technology,
    difficulty: Difficulty.mid,
    stem: '산업재해의 원인을 "기본적 원인"과 "직접적 원인"으로 나눌 때, 직접적 원인에 해당하는 것은?',
    choices: ['교육적 원인(안전교육 부족)', '기술적 원인(설비 결함)', '작업자의 불안전한 행동', '관리적 원인(안전관리 조직 미비)'],
    correctIndex: 2,
    explanation: '직접적 원인은 재해로 바로 이어지는 불안전한 행동이나 불안전한 상태를 말하며, 나머지는 그 배경이 되는 기본적 원인에 해당한다.',
    tags: ['기술이해', '산업재해'],
  );
  add(
    category: NcsCategory.technology,
    difficulty: Difficulty.mid,
    stem: '다음은 기기 설치 순서이다: ① 전원 연결 ② 받침대 고정 ③ 수평 확인 ④ 전원 On. 올바른 순서는?',
    choices: ['①-②-③-④', '②-③-①-④', '②-①-③-④', '③-②-①-④'],
    correctIndex: 1,
    explanation: '받침대를 먼저 고정하고 수평을 확인한 뒤 전원을 연결하고 마지막에 전원을 켜는 것이 안전한 순서이다.',
    tags: ['기술적용'],
  );
  add(
    category: NcsCategory.technology,
    difficulty: Difficulty.high,
    stem: '새로운 기술을 도입할 때 실패 가능성을 낮추기 위한 방법으로 가장 적절한 것은?',
    choices: [
      '검증 없이 전면 도입한다',
      '소규모로 시범 적용 후 문제점을 개선하여 확대한다',
      '타 업체의 실패 사례는 참고하지 않는다',
      '도입 비용만을 유일한 기준으로 삼는다',
    ],
    correctIndex: 1,
    explanation: '소규모로 시범 적용하여 문제점을 파악하고 개선한 뒤 점진적으로 확대하면 실패 가능성을 낮출 수 있다.',
    tags: ['기술적용'],
  );
  add(
    category: NcsCategory.technology,
    difficulty: Difficulty.high,
    stem: '지속가능한 발전을 위한 기술의 특성으로 가장 적절한 것은?',
    choices: [
      '자원을 최대한 많이 소모하는 기술',
      '오염을 저감하고 자원을 절약하는 방향의 기술',
      '단기적 이익만을 고려한 기술',
      '폐기물 처리를 고려하지 않는 기술',
    ],
    correctIndex: 1,
    explanation: '지속가능한 기술은 자원을 절약하고 오염을 줄이며 환경과 미래 세대를 고려하는 방향으로 발전해야 한다.',
    tags: ['기술이해'],
  );
  add(
    category: NcsCategory.technology,
    difficulty: Difficulty.high,
    stem: '타사의 우수한 기술이나 프로세스를 분석하여 자사에 맞게 개선, 적용하는 활동은?',
    choices: ['벤치마킹', '브레인스토밍', 'SWOT분석', 'PDCA'],
    correctIndex: 0,
    explanation: '벤치마킹은 타사의 우수 사례를 분석하여 자사에 맞게 개선, 적용하는 경영·기술 혁신 기법이다.',
    tags: ['기술선택'],
  );

  // 조직이해능력
  add(
    category: NcsCategory.organization,
    difficulty: Difficulty.low,
    stem: '경영의 4대 구성요소에 해당하지 않는 것은?',
    choices: ['경영목적', '인적자원', '자금', '개인 취미'],
    correctIndex: 3,
    explanation: '경영의 구성요소는 일반적으로 경영목적, 인적자원, 자금, 경영전략으로 구성되며 개인 취미는 해당하지 않는다.',
    tags: ['경영이해'],
  );
  add(
    category: NcsCategory.organization,
    difficulty: Difficulty.low,
    stem: '조직도에서 "직계 조직"과 "참모 조직"에 대한 설명으로 가장 적절한 것은?',
    choices: [
      '직계 조직은 명령체계이며, 참모 조직은 전문적 자문과 지원을 담당한다',
      '참모 조직만 실질적인 의사결정 권한을 가진다',
      '직계와 참모 조직은 동일한 개념이다',
      '참모 조직은 명령을 내릴 수 있는 유일한 조직이다',
    ],
    correctIndex: 0,
    explanation: '직계 조직은 지휘 명령 체계를 담당하고, 참모 조직은 전문 지식으로 직계 조직을 자문·지원하는 역할을 한다.',
    tags: ['체제이해'],
  );
  add(
    category: NcsCategory.organization,
    difficulty: Difficulty.mid,
    stem: '결재라인에서 "전결"의 의미로 가장 적절한 것은?',
    choices: [
      '최종 결재권자가 항상 직접 서명해야 한다는 뜻이다',
      '일정 사항에 대해 위임받은 자가 최종 결정권을 행사하는 것이다',
      '결재가 보류된 상태를 의미한다',
      '결재 절차를 생략해도 된다는 뜻이다',
    ],
    correctIndex: 1,
    explanation: '전결은 결재권자로부터 특정 사항에 대한 결정 권한을 위임받은 자가 최종 결재를 대신 행사하는 것을 말한다.',
    tags: ['업무이해'],
  );
  add(
    category: NcsCategory.organization,
    difficulty: Difficulty.mid,
    stem: '포터(Porter)의 본원적 경쟁전략에 해당하지 않는 것은?',
    choices: ['원가우위 전략', '차별화 전략', '집중화 전략', '다각화 전략'],
    correctIndex: 3,
    explanation: '포터의 본원적 경쟁전략은 원가우위, 차별화, 집중화 전략으로 구성되며 다각화 전략은 해당하지 않는다.',
    tags: ['경영이해'],
  );
  add(
    category: NcsCategory.organization,
    difficulty: Difficulty.mid,
    stem: '업무수행 계획을 수립할 때 가장 먼저 해야 할 일은?',
    choices: [
      '업무 관련 정보를 수집한다',
      '업무 지침을 확인하고 자신에게 주어진 업무를 파악한다',
      '일의 우선순위를 정한다',
      '구체적인 수행 계획을 수립한다',
    ],
    correctIndex: 1,
    explanation: '업무수행 계획 수립에 앞서 먼저 업무 지침을 확인하고 자신에게 주어진 업무가 무엇인지 파악해야 한다.',
    tags: ['업무이해'],
  );
  add(
    category: NcsCategory.organization,
    difficulty: Difficulty.high,
    stem: '해외 바이어와의 첫 미팅에서 유의해야 할 국제 매너로 가장 적절한 것은?',
    choices: [
      '상대국의 문화와 관습을 사전에 파악한다',
      '모든 국가에서 통용되는 매너는 동일하므로 따로 준비할 필요가 없다',
      '명함은 한 손으로 아무렇게나 건넨다',
      '시간 약속은 크게 중요하지 않다',
    ],
    correctIndex: 0,
    explanation: '국가마다 비즈니스 매너와 문화가 다르므로 사전에 상대국의 문화와 관습을 파악하고 준비하는 것이 바람직하다.',
    tags: ['국제감각'],
  );
  add(
    category: NcsCategory.organization,
    difficulty: Difficulty.high,
    stem: '조직 구성원들이 공유하는 가치관, 신념, 행동양식을 의미하는 것은?',
    choices: ['조직구조', '조직문화', '조직목표', '조직전략'],
    correctIndex: 1,
    explanation: '조직문화는 구성원들이 공유하는 가치관, 신념, 행동양식 등을 의미하며 조직의 정체성을 형성한다.',
    tags: ['체제이해'],
  );
  add(
    category: NcsCategory.organization,
    difficulty: Difficulty.high,
    stem: '조직목표의 특징으로 가장 적절하지 않은 것은?',
    choices: [
      '다수의 목표를 동시에 추구할 수 있다',
      '한번 수립되면 절대 변경되지 않는다',
      '조직의 존재 이유를 나타낸다',
      '조직 구성원의 행동에 방향을 제시한다',
    ],
    correctIndex: 1,
    explanation: '조직목표는 환경 변화에 따라 수정되거나 새롭게 설정될 수 있으며, 한번 정해지면 절대 변경되지 않는 것은 아니다.',
    tags: ['체제이해'],
  );

  // 직업윤리
  add(
    category: NcsCategory.ethics,
    difficulty: Difficulty.low,
    stem: '"근면"한 태도에 대한 설명으로 가장 적절한 것은?',
    choices: [
      '남이 시킬 때만 어쩔 수 없이 일하는 태도',
      '스스로 자발적이고 능동적으로 성실하게 일하는 태도',
      '최소한의 노력으로 일을 빨리 끝내려는 태도',
      '업무 시간에만 겉으로 바쁜 척하는 태도',
    ],
    correctIndex: 1,
    explanation: '근면은 외부의 강요가 아니라 스스로 자발적이고 능동적으로 성실하게 일하는 태도를 의미한다.',
    tags: ['근로윤리'],
  );
  add(
    category: NcsCategory.ethics,
    difficulty: Difficulty.low,
    stem: '직장 생활에서 "정직"이 중요한 이유로 가장 적절한 것은?',
    choices: [
      '정직하면 항상 손해를 본다',
      '신뢰를 바탕으로 한 원활한 협업과 조직 운영이 가능해진다',
      '정직은 개인 생활에서만 중요하다',
      '정직은 법적으로 강제되지 않으므로 중요하지 않다',
    ],
    correctIndex: 1,
    explanation: '정직은 구성원 간 신뢰를 형성하여 원활한 협업과 건강한 조직 운영을 가능하게 하는 중요한 가치이다.',
    tags: ['근로윤리'],
  );
  add(
    category: NcsCategory.ethics,
    difficulty: Difficulty.mid,
    stem: '직장 내 괴롭힘에 해당할 가능성이 높은 상황은?',
    choices: [
      '정당한 업무 지시에 따라 마감을 요청하는 것',
      '우월적 지위를 이용해 반복적으로 특정 직원에게 모욕적인 언행을 하는 것',
      '업무 성과에 대해 공정하게 피드백하는 것',
      '합리적인 범위에서 업무를 분담하는 것',
    ],
    correctIndex: 1,
    explanation: '우월적 지위를 이용해 반복적으로 모욕적인 언행을 하는 것은 직장 내 괴롭힘에 해당할 가능성이 높다.',
    tags: ['공동체윤리'],
  );
  add(
    category: NcsCategory.ethics,
    difficulty: Difficulty.mid,
    stem: '직장 내 성희롱 예방을 위한 태도로 가장 적절하지 않은 것은?',
    choices: [
      '상대방이 불쾌감을 느낄 수 있는 언행은 삼간다',
      '성희롱 여부는 행위자의 의도만으로 판단한다',
      '피해자가 문제를 제기하기 쉬운 조직문화를 만든다',
      '관련 예방 교육을 정기적으로 실시한다',
    ],
    correctIndex: 1,
    explanation: '성희롱 여부는 행위자의 의도가 아니라 상대방이 느끼는 불쾌감 등 피해자 관점을 중요하게 고려하여 판단해야 한다.',
    tags: ['공동체윤리'],
  );
  add(
    category: NcsCategory.ethics,
    difficulty: Difficulty.mid,
    stem: '직업윤리에서 "책임의식"에 대한 설명으로 가장 적절한 것은?',
    choices: [
      '문제가 생기면 즉시 남에게 책임을 전가한다',
      '자신이 맡은 일의 결과에 대해 스스로 책임지려는 자세이다',
      '책임은 상사에게만 있다',
      '책임의식은 직위가 높을수록 필요 없다',
    ],
    correctIndex: 1,
    explanation: '책임의식은 자신이 맡은 업무와 그 결과에 대해 스스로 책임을 지려는 태도를 의미한다.',
    tags: ['근로윤리'],
  );
  add(
    category: NcsCategory.ethics,
    difficulty: Difficulty.high,
    stem: '공정한 직무수행을 저해하는 행위로 가장 거리가 먼 것은?',
    choices: [
      '직무와 관련하여 금품을 수수하는 행위',
      '부정한 청탁을 받고 편의를 제공하는 행위',
      '규정에 따라 공개적으로 진행되는 정상적인 계약 절차',
      '지인의 부당한 채용 청탁을 들어주는 행위',
    ],
    correctIndex: 2,
    explanation: '규정에 따라 공개적으로 진행되는 정상적인 계약 절차는 공정한 직무수행에 해당하며 저해 행위가 아니다.',
    tags: ['공동체윤리'],
  );
  add(
    category: NcsCategory.ethics,
    difficulty: Difficulty.high,
    stem: '준법의식이 조직에서 중요한 이유로 가장 적절한 것은?',
    choices: [
      '법과 규정을 지키면 오히려 조직의 경쟁력이 떨어지기 때문에',
      '사회 구성원으로서 신뢰를 유지하고 예측 가능한 조직 운영을 가능하게 하기 때문에',
      '준법은 형식적인 절차일 뿐 실질적 의미가 없기 때문에',
      '법은 상황에 따라 무시해도 되는 것이기 때문에',
    ],
    correctIndex: 1,
    explanation: '준법의식은 사회적 신뢰를 유지하고 예측 가능하고 안정적인 조직 운영을 가능하게 하므로 중요하다.',
    tags: ['근로윤리'],
  );
  add(
    category: NcsCategory.ethics,
    difficulty: Difficulty.high,
    stem: '다음 중 바람직한 직업관으로 가장 적절한 것은?',
    choices: [
      '직업은 개인의 생계만을 위한 수단일 뿐이다',
      '자신의 직업이 사회에 기여하는 의미를 이해하고 소명의식을 갖는다',
      '타인의 직업을 귀천으로 평가한다',
      '직업 선택 시 적성보다 타인의 시선을 최우선으로 고려한다',
    ],
    correctIndex: 1,
    explanation: '바람직한 직업관은 자신의 직업이 사회에 기여하는 의미를 이해하고 소명의식과 책임감을 갖는 것이다.',
    tags: ['근로윤리'],
  );

  return list;
}
