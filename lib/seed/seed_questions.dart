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
    stem: '다음 중 공문서 작성 원칙으로 가장 적절하지 않은 것은?',
    choices: [
      '육하원칙에 따라 명확하게 작성한다',
      '가능한 한 문장을 짧고 간결하게 작성한다',
      '읽는 사람의 이해를 돕기 위해 전문 용어와 비유적 표현을 최대한 많이 사용한다',
      '날짜 표기는 연-월-일 형식을 사용하고 마지막에 마침표를 찍는다',
    ],
    correctIndex: 2,
    explanation:
        '공문서는 정확성과 명료성이 중요하므로 불필요한 전문 용어나 비유적 표현은 오히려 의미 전달을 방해할 수 있어 지양해야 한다.',
    tags: ['문서작성', '기초'],
  );
  add(
    category: NcsCategory.communication,
    difficulty: Difficulty.low,
    stem:
        '팀장이 "이 자료 오늘 중으로 정리해서 보내주세요"라고 말했을 때, 가장 바람직한 경청 태도는?',
    choices: [
      '지시를 듣자마자 바로 자리를 떠나 작업을 시작한다',
      '마감 기한과 자료의 범위, 형식 등을 되물어 명확히 확인한다',
      '알겠다고만 대답하고 세부 사항은 나중에 임의로 판단한다',
      '다른 동료에게 지시 내용을 대신 확인해 달라고 부탁한다',
    ],
    correctIndex: 1,
    explanation:
        '경청은 단순히 듣는 것을 넘어 모호한 부분을 질문을 통해 명확히 확인하는 것을 포함한다.',
    tags: ['경청', '의사표현'],
  );
  add(
    category: NcsCategory.communication,
    difficulty: Difficulty.mid,
    stem:
        '다음 이메일 초안 중 비즈니스 문서로서 어색한 부분은?\n"안녕하세요! 다름이 아니라 지난번에 말씀드린 견적서를 빨리빨리 좀 보내주셨으면 좋겠어요ㅠㅠ 부탁드려요~"',
    choices: [
      '수신자에 대한 인사말을 포함한 점',
      '구어체 표현과 이모티콘, 반말투의 재촉 표현을 사용한 점',
      '요청 사항을 포함한 점',
      '문장이 존재한다는 점 자체',
    ],
    correctIndex: 1,
    explanation:
        '업무 이메일에서는 구어체, 이모티콘, 지나친 재촉 표현을 피하고 정중하고 명확한 문어체를 사용해야 한다.',
    tags: ['문서작성', '이메일'],
  );
  add(
    category: NcsCategory.communication,
    difficulty: Difficulty.mid,
    stem:
        '보고서에 "매출이 전분기 대비 소폭 상승하였다"라고 적혀 있다. 이 문장의 문제점으로 가장 적절한 것은?',
    choices: [
      '문장이 너무 길다',
      '구체적인 수치 없이 모호한 표현을 사용해 정보 전달력이 떨어진다',
      '한자어를 사용하지 않았다',
      '주어가 없다',
    ],
    correctIndex: 1,
    explanation:
        '"소폭 상승"과 같은 표현은 사람마다 다르게 해석될 수 있으므로 구체적인 수치를 함께 제시하는 것이 정확한 의사소통에 도움이 된다.',
    tags: ['보고서', '문서이해'],
  );
  add(
    category: NcsCategory.communication,
    difficulty: Difficulty.high,
    stem:
        '다음 중 회의에서 갈등 상황이 발생했을 때 의사소통 측면에서 가장 바람직한 대응은?',
    choices: [
      '상대방의 의견을 즉시 반박하여 회의 주도권을 잡는다',
      '상대방의 주장을 요약해 확인한 뒤 자신의 의견과 공통점 및 차이점을 구체적으로 제시한다',
      '갈등을 피하기 위해 이후 논의에서 침묵으로 일관한다',
      '회의 후 별도로 다른 사람에게 상대방을 비판한다',
    ],
    correctIndex: 1,
    explanation:
        '효과적인 의사소통은 상대방의 의견을 정확히 이해했음을 확인하고, 공통점과 차이점을 근거를 들어 제시하는 것이다.',
    tags: ['갈등관리', '회의'],
  );
  add(
    category: NcsCategory.communication,
    difficulty: Difficulty.high,
    stem:
        '외국인 바이어에게 보낼 영문 제안서를 작성할 때 고려해야 할 사항으로 가장 거리가 먼 것은?',
    choices: [
      '문화적 차이를 고려하여 오해의 소지가 있는 표현을 피한다',
      '숫자, 날짜, 단위 표기를 상대국 관습에 맞게 명확히 한다',
      '국내 관용구를 그대로 직역하여 친근감을 표현한다',
      '핵심 제안 내용을 앞부분에 명확히 제시한다',
    ],
    correctIndex: 2,
    explanation:
        '국내 관용구를 직역하면 의미가 왜곡되거나 전달되지 않을 수 있으므로 상대 문화권에서 통용되는 표현으로 바꾸어야 한다.',
    tags: ['국제비즈니스', '문서작성'],
  );

  // 수리능력
  add(
    category: NcsCategory.numeracy,
    difficulty: Difficulty.low,
    stem: '어떤 제품의 원가는 8,000원이고 20%의 이익을 붙여 판매하려 한다. 판매가는 얼마인가?',
    choices: ['8,200원', '9,000원', '9,600원', '10,000원'],
    correctIndex: 2,
    explanation: '8,000 × 1.2 = 9,600원.',
    tags: ['비율', '원가계산'],
  );
  add(
    category: NcsCategory.numeracy,
    difficulty: Difficulty.low,
    stem: '연속된 세 자연수의 합이 90일 때, 가장 작은 수는? (예: n, n+1, n+2)',
    choices: ['28', '29', '30', '31'],
    correctIndex: 1,
    explanation: '3n+3=90 이므로 n=29.',
    tags: ['방정식'],
  );
  add(
    category: NcsCategory.numeracy,
    difficulty: Difficulty.mid,
    stem:
        'A 지점에서 B 지점까지 거리는 120km이다. 갈 때는 시속 60km, 올 때는 시속 40km로 이동했다면 왕복 평균 속력은 얼마인가?',
    choices: ['48km/h', '50km/h', '52km/h', '54km/h'],
    correctIndex: 0,
    explanation:
        '총 거리 240km, 총 시간 = 120/60 + 120/40 = 2 + 3 = 5시간. 평균속력 = 240/5 = 48km/h.',
    tags: ['속력', '평균'],
  );
  add(
    category: NcsCategory.numeracy,
    difficulty: Difficulty.mid,
    stem:
        '어느 부서의 지난달 직원 수는 25명이었고 이번 달에 20% 증가했다. 이번 달 직원 수는 몇 명인가?',
    choices: ['28명', '29명', '30명', '32명'],
    correctIndex: 2,
    explanation: '25 × 1.2 = 30명.',
    tags: ['증가율'],
  );
  add(
    category: NcsCategory.numeracy,
    difficulty: Difficulty.high,
    stem:
        '어떤 프로젝트를 A가 혼자 하면 12일, B가 혼자 하면 18일 걸린다. 두 사람이 함께 3일을 작업한 후 나머지는 A 혼자 완료한다면 A가 추가로 며칠을 더 작업해야 하는가?',
    choices: ['5일', '6일', '6.5일', '7일'],
    correctIndex: 3,
    explanation:
        'A의 일률은 1/12, B의 일률은 1/18. 3일간 함께 작업한 일량 = 3×(1/12+1/18) = 3×(5/36) = 5/12. 남은 일량 = 1 - 5/12 = 7/12. A 혼자 이를 마치는 데 걸리는 일수 = (7/12) ÷ (1/12) = 7일.',
    tags: ['일량', '작업량'],
  );
  add(
    category: NcsCategory.numeracy,
    difficulty: Difficulty.high,
    stem:
        '작년 매출은 3억원이었고 올해는 전년 대비 15% 증가, 내년에는 올해 대비 10% 감소가 예상된다. 내년 예상 매출은 얼마인가? (백만원 단위, 소수점 반올림)',
    choices: ['300백만원', '310백만원', '311백만원', '345백만원'],
    correctIndex: 2,
    explanation:
        '올해 매출 = 300 × 1.15 = 345백만원. 내년 매출 = 345 × 0.9 = 310.5 ≈ 311백만원.',
    tags: ['증감률', '추정'],
  );

  // 문제해결능력
  add(
    category: NcsCategory.problemSolving,
    difficulty: Difficulty.low,
    stem: '문제 해결 절차 중 가장 먼저 수행해야 할 단계는?',
    choices: ['원인 분석', '문제 인식', '해결안 개발', '실행 및 평가'],
    correctIndex: 1,
    explanation:
        '일반적인 문제 해결 절차는 문제 인식 → 문제 도출 → 원인 분석 → 해결안 개발 → 실행 및 평가 순으로 진행된다.',
    tags: ['문제해결절차'],
  );
  add(
    category: NcsCategory.problemSolving,
    difficulty: Difficulty.low,
    stem:
        '다섯 명(A~E)이 한 줄로 나란히 서 있다. A는 B보다 왼쪽에 있고, C는 맨 오른쪽에 있다. 다음 중 반드시 참인 것은?',
    choices: [
      'A가 맨 왼쪽에 있다',
      'B가 C보다 왼쪽에 있다',
      'D가 E보다 왼쪽에 있다',
      'A는 C보다 왼쪽에 있다',
    ],
    correctIndex: 3,
    explanation:
        'C가 맨 오른쪽이므로 C를 제외한 모든 사람은 C보다 왼쪽에 있다. 따라서 A는 항상 C보다 왼쪽에 있다.',
    tags: ['논리추론', '순서'],
  );
  add(
    category: NcsCategory.problemSolving,
    difficulty: Difficulty.mid,
    stem:
        '공장에서 불량률이 갑자기 증가했다. 원인 분석을 위한 접근으로 가장 적절한 것은?',
    choices: [
      '즉시 담당자를 교체한다',
      '설비, 작업자, 원자재, 공정 방법 등 여러 관점에서 데이터를 수집해 원인을 체계적으로 분석한다',
      '불량품을 재검수 없이 폐기하고 넘어간다',
      '경쟁사의 공정을 그대로 복제한다',
    ],
    correctIndex: 1,
    explanation:
        '문제의 근본 원인을 찾기 위해서는 4M(Man, Machine, Material, Method) 등 다양한 요인을 체계적으로 분석해야 한다.',
    tags: ['원인분석'],
  );
  add(
    category: NcsCategory.problemSolving,
    difficulty: Difficulty.mid,
    stem:
        '세 부서(기획, 영업, 생산)의 예산 배분에 대해 갈등이 있다. 다음 중 창의적 문제해결에 가장 부합하는 접근은?',
    choices: [
      '가장 목소리가 큰 부서에 우선 배분한다',
      '각 부서의 요구사항과 데이터를 바탕으로 우선순위를 정하고 대안을 여러 개 도출해 비교한다',
      '항상 균등하게 3등분한다',
      '작년과 동일하게 배분한다',
    ],
    correctIndex: 1,
    explanation:
        '창의적 문제해결은 다양한 대안을 도출하고 객관적 기준으로 비교·평가하는 과정을 포함한다.',
    tags: ['의사결정'],
  );
  add(
    category: NcsCategory.problemSolving,
    difficulty: Difficulty.high,
    stem:
        '갑, 을, 병, 정 네 사람 중 한 명만 진실을 말하고 나머지는 거짓을 말한다.\n갑: "을이 범인이다"\n을: "정이 범인이다"\n병: "나는 범인이 아니다"\n정: "을은 거짓말을 하고 있다"\n범인은 누구인가? (범인은 거짓말쟁이라고 가정)',
    choices: ['갑', '을', '병', '정'],
    correctIndex: 2,
    explanation:
        '정이 진실이라고 가정하면 을은 거짓, 즉 정은 범인이 아니다. 그러면 갑도 거짓이므로 을은 범인이 아니고, 병도 거짓이므로 병이 범인이 된다. 이 경우 진실을 말한 사람은 정 한 명뿐이므로 조건이 성립한다. 따라서 범인은 병이다.',
    tags: ['논리추론', '진위판별'],
  );
  add(
    category: NcsCategory.problemSolving,
    difficulty: Difficulty.high,
    stem:
        '신제품 출시 후 매출이 예상보다 저조하다. SWOT 분석 결과 강점(고품질), 약점(높은 가격), 기회(친환경 트렌드 확산), 위협(경쟁사 저가 공세)이 도출되었다. 이때 가장 적절한 전략은?',
    choices: [
      '가격을 무조건 경쟁사보다 낮춘다',
      '고품질과 친환경 트렌드를 강조하는 마케팅으로 가격 저항을 상쇄하는 ST/SO 전략을 취한다',
      '신제품 생산을 즉시 중단한다',
      '약점과 위협만 고려해 사업을 축소한다',
    ],
    correctIndex: 1,
    explanation:
        'SWOT 분석에서 강점을 활용해 기회를 극대화하는 SO전략과 강점으로 위협을 상쇄하는 ST전략을 결합하는 것이 효과적이다.',
    tags: ['SWOT', '전략수립'],
  );

  // 자기개발능력
  add(
    category: NcsCategory.selfDevelopment,
    difficulty: Difficulty.low,
    stem: '자기개발 계획 수립 시 가장 먼저 해야 할 일은?',
    choices: ['목표 달성 보상 설정', '자신의 흥미, 적성, 강점과 약점 등 자기 이해', '동료와의 비교', '즉각적인 실행'],
    correctIndex: 1,
    explanation:
        '효과적인 자기개발은 자신의 흥미, 적성, 특성을 파악하는 자기 이해에서 출발한다.',
    tags: ['자기이해'],
  );
  add(
    category: NcsCategory.selfDevelopment,
    difficulty: Difficulty.low,
    stem:
        '다음 중 SMART 목표 설정 원칙에 해당하지 않는 것은?',
    choices: ['Specific(구체적)', 'Measurable(측정가능)', 'Sensitive(감정적)', 'Time-bound(기한설정)'],
    correctIndex: 2,
    explanation:
        'SMART는 Specific, Measurable, Achievable, Relevant, Time-bound의 약자이며 Sensitive는 포함되지 않는다.',
    tags: ['목표설정'],
  );
  add(
    category: NcsCategory.selfDevelopment,
    difficulty: Difficulty.mid,
    stem:
        '경력개발 3단계(직업 선택, 조직 입사, 경력 초기~말기)를 고려할 때, 입사 5년차 대리급 직원에게 가장 적절한 경력개발 활동은?',
    choices: [
      '직업 선택을 위한 적성검사 재실시',
      '전문성을 심화하고 후배 지도 역량을 함께 키우는 활동',
      '은퇴 이후 계획 수립에 집중',
      '입사 지원서 작성법 학습',
    ],
    correctIndex: 1,
    explanation:
        '경력 초기를 지나 중간 단계로 접어드는 시기에는 전문성 심화와 함께 리더십, 후배 지도 역량 개발이 중요하다.',
    tags: ['경력개발'],
  );
  add(
    category: NcsCategory.selfDevelopment,
    difficulty: Difficulty.mid,
    stem:
        '자아인식을 위한 방법으로 가장 거리가 먼 것은?',
    choices: [
      '표준화된 심리검사 활용',
      '동료나 상사로부터의 피드백 수용',
      '타인의 요구에 따라서만 자신의 목표를 설정',
      '일기 작성을 통한 자기 성찰',
    ],
    correctIndex: 2,
    explanation:
        '자아인식은 스스로의 특성을 파악하는 과정이며, 타인의 요구에만 전적으로 의존해 목표를 정하는 것은 바람직한 자아인식 방법이 아니다.',
    tags: ['자아인식'],
  );
  add(
    category: NcsCategory.selfDevelopment,
    difficulty: Difficulty.high,
    stem:
        '자기관리 절차(비전 및 목표 설정 → 과제 발견 → 일정 수립 → 수행 → 반성 및 피드백) 중 "과제 발견" 단계에서 수행할 활동으로 가장 적절한 것은?',
    choices: [
      '이미 완료한 업무를 재검토 없이 종료 처리',
      '현재 역할 및 능력을 분석해 우선적으로 수행해야 할 활동을 찾는다',
      '전체 일정표를 작성해 시간대별로 배분한다',
      '결과에 대한 보상 체계만 설계한다',
    ],
    correctIndex: 1,
    explanation:
        '과제 발견 단계는 현재 상황과 역할을 분석하여 수행해야 할 역할들을 구체적으로 도출하는 단계이다.',
    tags: ['자기관리'],
  );
  add(
    category: NcsCategory.selfDevelopment,
    difficulty: Difficulty.high,
    stem:
        '변화가 심한 업무 환경에서 지속적인 자기개발이 필요한 이유로 가장 거리가 먼 것은?',
    choices: [
      '급변하는 환경에 적응하기 위해',
      '자신이 달성하고자 하는 목표를 성취하기 위해',
      '한 번 습득한 능력은 평생 그대로 유지되기 때문에',
      '주변 사람과 긍정적인 인간관계를 형성하기 위해',
    ],
    correctIndex: 2,
    explanation:
        '지식과 기술은 시간이 지나면서 낡거나 변화하므로 지속적인 자기개발이 필요하며, 한 번 습득한 능력이 평생 유지된다는 것은 자기개발의 필요성과 배치되는 설명이다.',
    tags: ['자기개발필요성'],
  );

  // 자원관리능력
  add(
    category: NcsCategory.resourceManagement,
    difficulty: Difficulty.low,
    stem: '자원관리의 4대 자원에 해당하지 않는 것은?',
    choices: ['시간', '예산', '인적자원', '감정'],
    correctIndex: 3,
    explanation:
        '일반적으로 자원관리의 4대 자원은 시간, 예산(물적자원 포함), 인적자원, 물적자원으로 구분되며 감정은 포함되지 않는다.',
    tags: ['자원관리기초'],
  );
  add(
    category: NcsCategory.resourceManagement,
    difficulty: Difficulty.low,
    stem:
        '업무 우선순위를 정할 때 활용하는 "중요도-긴급도 매트릭스"에서 가장 먼저 처리해야 할 일은?',
    choices: [
      '중요하지 않고 긴급하지도 않은 일',
      '중요하지만 긴급하지 않은 일',
      '중요하고 긴급한 일',
      '중요하지 않지만 긴급한 일',
    ],
    correctIndex: 2,
    explanation:
        '중요하고 긴급한 일을 최우선으로 처리하는 것이 시간관리의 기본 원칙이다.',
    tags: ['시간관리'],
  );
  add(
    category: NcsCategory.resourceManagement,
    difficulty: Difficulty.mid,
    stem:
        '예산 100만원으로 세 가지 업무(A: 효과 90, 비용 50만원 / B: 효과 60, 비용 30만원 / C: 효과 40, 비용 40만원)를 선택할 때, 예산 안에서 총 효과를 최대화하는 조합은?',
    choices: ['A와 B', 'A와 C', 'B와 C', 'A, B, C 모두'],
    correctIndex: 0,
    explanation:
        'A+B = 비용 80만원(예산 이내), 효과 150. A+C = 비용 90만원, 효과 130. B+C = 비용 70만원, 효과 100. 세 개 모두는 120만원으로 예산 초과. 따라서 A와 B 조합이 예산 이내에서 효과가 가장 크다.',
    tags: ['예산관리', '최적화'],
  );
  add(
    category: NcsCategory.resourceManagement,
    difficulty: Difficulty.mid,
    stem:
        '물적자원 관리에서 "회전대응 보관의 원칙"이 의미하는 것은?',
    choices: [
      '유사한 물품은 가까운 장소에 보관한다',
      '입출고 빈도가 높은 물품을 출입구에서 가까운 곳에 보관한다',
      '무거운 물품을 아래쪽에 보관한다',
      '동일 물품은 한 곳에만 보관한다',
    ],
    correctIndex: 1,
    explanation:
        '회전대응 보관의 원칙은 물품의 활용 빈도, 즉 입출고 빈도에 따라 출입구와의 거리를 정하는 것을 말한다.',
    tags: ['물적자원관리'],
  );
  add(
    category: NcsCategory.resourceManagement,
    difficulty: Difficulty.high,
    stem:
        '세 명의 작업자를 세 가지 작업(갑, 을, 병)에 배정하려 한다. 각 작업자의 작업별 소요 시간(시간)이 아래와 같을 때, 총 소요 시간을 최소화하는 배정은?\n\n(작업자1: 갑=4, 을=6, 병=8) / (작업자2: 갑=6, 을=5, 병=7) / (작업자3: 갑=9, 을=8, 병=6)',
    choices: [
      '작업자1-갑, 작업자2-을, 작업자3-병',
      '작업자1-갑, 작업자2-병, 작업자3-을',
      '작업자1-을, 작업자2-갑, 작업자3-병',
      '작업자1-병, 작업자2-갑, 작업자3-을',
    ],
    correctIndex: 0,
    explanation:
        '작업자1-갑(4)+작업자2-을(5)+작업자3-병(6)=15시간으로 다른 조합(예: 4+7+8=19, 6+6+6=18, 8+6+8=22)보다 총 소요시간이 가장 짧다.',
    tags: ['인적자원관리', '최적화'],
  );
  add(
    category: NcsCategory.resourceManagement,
    difficulty: Difficulty.high,
    stem:
        '프로젝트 일정 관리에서 "임계경로(Critical Path)"에 대한 설명으로 가장 적절한 것은?',
    choices: [
      '가장 비용이 적게 드는 작업 경로',
      '프로젝트 전체 완료 기간을 결정하는, 여유시간이 없는 최장 작업 경로',
      '가장 많은 인력이 투입되는 경로',
      '품질 검수가 가장 까다로운 경로',
    ],
    correctIndex: 1,
    explanation:
        '임계경로는 프로젝트 내 여러 작업 경로 중 가장 긴 시간이 소요되며 지연 시 전체 일정에 직접 영향을 미치는 경로를 말한다.',
    tags: ['시간관리', '프로젝트관리'],
  );

  // 대인관계능력
  add(
    category: NcsCategory.interpersonal,
    difficulty: Difficulty.low,
    stem: '효과적인 팀워크를 위한 태도로 가장 적절한 것은?',
    choices: [
      '자신의 의견만을 관철시키려 한다',
      '팀 목표보다 개인의 성과를 우선시한다',
      '서로 신뢰하고 개방적으로 소통하며 공동 목표를 향해 협력한다',
      '문제가 생기면 책임을 다른 팀원에게 전가한다',
    ],
    correctIndex: 2,
    explanation:
        '효과적인 팀워크는 신뢰를 바탕으로 한 개방적 소통과 공동 목표 지향적 협력을 필요로 한다.',
    tags: ['팀워크'],
  );
  add(
    category: NcsCategory.interpersonal,
    difficulty: Difficulty.low,
    stem:
        '고객이 제품 불량에 대해 화를 내며 항의하고 있다. 가장 바람직한 첫 대응은?',
    choices: [
      '고객의 말을 끊고 회사 규정부터 설명한다',
      '먼저 고객의 불편함에 공감을 표현하고 상황을 경청한다',
      '문제가 없다고 즉시 반박한다',
      '다른 직원에게 응대를 미룬다',
    ],
    correctIndex: 1,
    explanation:
        '고객 불만 응대의 기본은 먼저 공감하고 경청하여 고객의 감정을 진정시킨 뒤 문제 해결에 나서는 것이다.',
    tags: ['고객서비스', '갈등관리'],
  );
  add(
    category: NcsCategory.interpersonal,
    difficulty: Difficulty.mid,
    stem:
        '팀원 간 의견 대립이 발생했을 때 "협력(collaborating)" 갈등 관리 방식에 해당하는 것은?',
    choices: [
      '한쪽이 전적으로 양보한다',
      '문제를 회피하고 언급하지 않는다',
      '양측의 관심사를 모두 충족시키는 win-win 대안을 함께 모색한다',
      '중간 지점에서 서로 절반씩 손해를 감수한다',
    ],
    correctIndex: 2,
    explanation:
        '협력형 갈등 관리는 양측의 요구를 모두 만족시킬 수 있는 창의적 대안을 함께 찾는 방식이다.',
    tags: ['갈등관리유형'],
  );
  add(
    category: NcsCategory.interpersonal,
    difficulty: Difficulty.mid,
    stem:
        '리더십 유형 중 "임파워먼트(empowerment)"에 대한 설명으로 가장 적절한 것은?',
    choices: [
      '모든 의사결정을 리더가 단독으로 수행하는 것',
      '구성원에게 권한과 책임을 위임하여 자율적으로 업무를 수행하게 하는 것',
      '구성원의 실수를 철저히 감시하고 처벌하는 것',
      '구성원의 의견을 전혀 반영하지 않는 것',
    ],
    correctIndex: 1,
    explanation:
        '임파워먼트는 구성원에게 실질적인 권한과 책임을 부여하여 자율성과 주인의식을 높이는 리더십 방식이다.',
    tags: ['리더십'],
  );
  add(
    category: NcsCategory.interpersonal,
    difficulty: Difficulty.high,
    stem:
        '협상 상황에서 "BATNA(협상 결렬 시 최선의 대안)"의 역할로 가장 적절한 것은?',
    choices: [
      '상대방을 위협하기 위한 수단으로만 사용된다',
      '자신이 받아들일 수 있는 최소 조건을 판단하는 기준이 되어 무리한 양보를 막아준다',
      '협상 자체를 무효화시키는 장치이다',
      '항상 상대방에게 먼저 공개해야 하는 정보이다',
    ],
    correctIndex: 1,
    explanation:
        'BATNA는 협상이 결렬될 경우의 대안으로, 이를 명확히 파악하고 있으면 불리한 조건에 대한 무리한 양보를 방지하는 기준이 된다.',
    tags: ['협상'],
  );
  add(
    category: NcsCategory.interpersonal,
    difficulty: Difficulty.high,
    stem:
        '다국적 팀 프로젝트에서 문화적 차이로 인한 갈등이 반복될 때, 가장 근본적인 해결 접근은?',
    choices: [
      '한 문화권의 방식으로 나머지를 일괄 통일한다',
      '서로의 문화적 배경과 커뮤니케이션 방식의 차이를 이해하고 합의된 공통 규칙을 마련한다',
      '문화 차이는 논의하지 않고 업무만 진행한다',
      '갈등이 생기면 즉시 팀을 해체한다',
    ],
    correctIndex: 1,
    explanation:
        '다문화 팀에서는 서로 다른 배경을 이해하고 존중하며, 팀 차원의 공통 규칙과 소통 방식을 합의하는 것이 근본적인 해결책이다.',
    tags: ['다문화', '팀워크'],
  );

  // 정보능력
  add(
    category: NcsCategory.information,
    difficulty: Difficulty.low,
    stem: '엑셀에서 셀 A1에 5, A2에 10이 입력되어 있을 때, A3에 "=A1+A2*2"를 입력하면 결과값은?',
    choices: ['20', '25', '30', '15'],
    correctIndex: 1,
    explanation: '연산자 우선순위에 따라 곱셈이 먼저 계산되어 5 + (10×2) = 25.',
    tags: ['스프레드시트', '연산순서'],
  );
  add(
    category: NcsCategory.information,
    difficulty: Difficulty.low,
    stem: '정보의 원천 중 "1차 자료"에 해당하는 것은?',
    choices: [
      '다른 사람이 정리한 요약 보고서',
      '연구자가 직접 수행한 설문조사 원자료',
      '백과사전 항목',
      '뉴스 기사에서 인용된 통계 요약',
    ],
    correctIndex: 1,
    explanation:
        '1차 자료는 연구자나 조사자가 직접 생성한 원본 데이터를 의미하며, 이를 가공·요약한 것은 2차 자료에 해당한다.',
    tags: ['정보원'],
  );
  add(
    category: NcsCategory.information,
    difficulty: Difficulty.mid,
    stem:
        '데이터베이스에서 "기본키(Primary Key)"의 특징으로 가장 적절한 것은?',
    choices: [
      '중복된 값을 가질 수 있다',
      '테이블 내에서 각 행을 고유하게 식별할 수 있어야 하며 NULL 값을 가질 수 없다',
      '여러 테이블에서 자유롭게 값이 변경되어도 상관없다',
      '반드시 문자형이어야 한다',
    ],
    correctIndex: 1,
    explanation:
        '기본키는 테이블의 각 레코드를 고유하게 식별하는 값으로, 중복이나 NULL 값을 허용하지 않는다.',
    tags: ['데이터베이스'],
  );
  add(
    category: NcsCategory.information,
    difficulty: Difficulty.mid,
    stem:
        '엑셀에서 특정 조건을 만족하는 셀의 개수를 세고자 할 때 사용하는 함수로 가장 적절한 것은?',
    choices: ['SUM', 'COUNTIF', 'AVERAGE', 'CONCAT'],
    correctIndex: 1,
    explanation:
        'COUNTIF 함수는 지정한 조건을 만족하는 셀의 개수를 세는 함수이다.',
    tags: ['스프레드시트함수'],
  );
  add(
    category: NcsCategory.information,
    difficulty: Difficulty.high,
    stem:
        '개인정보 보호를 위한 정보 관리 원칙으로 가장 거리가 먼 것은?',
    choices: [
      '업무에 필요한 최소한의 개인정보만 수집한다',
      '접근 권한을 세분화하여 관리한다',
      '수집한 개인정보는 목적 달성 후에도 영구히 삭제하지 않고 보관한다',
      '개인정보 처리 현황을 주기적으로 점검한다',
    ],
    correctIndex: 2,
    explanation:
        '개인정보는 수집 목적이 달성되면 지체 없이 파기하는 것이 원칙이며, 영구 보관은 개인정보 보호 원칙에 위배된다.',
    tags: ['정보보안', '개인정보'],
  );
  add(
    category: NcsCategory.information,
    difficulty: Difficulty.high,
    stem:
        '대용량 고객 데이터에서 특정 지역, 특정 연령대 고객만 추출해 마케팅에 활용하려 한다. 이 과정에서 가장 적절한 정보처리 절차는?',
    choices: [
      '전체 데이터를 무작위로 일부만 사용한다',
      '수집 → 목적에 맞는 조건으로 필터링 및 가공 → 분석 → 결과 활용의 순서로 체계적으로 처리한다',
      '데이터를 가공하지 않고 원본 그대로 배포한다',
      '데이터 분석 없이 담당자의 직감으로 대상을 선정한다',
    ],
    correctIndex: 1,
    explanation:
        '체계적인 정보관리는 수집, 가공(필요한 조건으로 선별), 분석, 활용의 절차를 따를 때 효과적이고 신뢰할 수 있다.',
    tags: ['정보처리절차'],
  );

  // 기술능력
  add(
    category: NcsCategory.technology,
    difficulty: Difficulty.low,
    stem: '새로운 장비 도입 시 가장 먼저 확인해야 할 문서는?',
    choices: ['경쟁사 제품 카탈로그', '제품 설명서(매뉴얼) 및 안전 수칙', '회사 연혁 자료', '타 부서 회의록'],
    correctIndex: 1,
    explanation:
        '새 장비를 도입할 때는 올바른 사용법과 안전한 작동을 위해 제품 설명서와 안전 수칙을 가장 먼저 확인해야 한다.',
    tags: ['기술이해', '매뉴얼'],
  );
  add(
    category: NcsCategory.technology,
    difficulty: Difficulty.low,
    stem: '산업재해의 직접적 원인으로 가장 적절한 것은?',
    choices: ['기업의 조직 문화', '불안전한 행동과 불안전한 상태', '국가 경제 상황', '노동법 개정'],
    correctIndex: 1,
    explanation:
        '산업재해의 직접적 원인은 근로자의 불안전한 행동과 설비·환경의 불안전한 상태로 분류된다.',
    tags: ['산업안전'],
  );
  add(
    category: NcsCategory.technology,
    difficulty: Difficulty.mid,
    stem:
        '기술 선택 시 고려해야 할 요소로 가장 거리가 먼 것은?',
    choices: [
      '기술의 수명 주기와 향후 발전 가능성',
      '기업의 전략 및 목표와의 부합성',
      '도입 비용 대비 기대 효과',
      '담당자 개인의 선호도만을 기준으로 한 결정',
    ],
    correctIndex: 3,
    explanation:
        '기술 선택은 조직의 전략, 비용 대비 효과, 기술 수명 주기 등을 종합적으로 고려해야 하며 개인의 선호만으로 결정해서는 안 된다.',
    tags: ['기술선택'],
  );
  add(
    category: NcsCategory.technology,
    difficulty: Difficulty.mid,
    stem:
        '기계 설비 점검 중 이상 소음이 발생했다. 매뉴얼에 따른 가장 적절한 대응 순서는?',
    choices: [
      '무시하고 계속 가동한다',
      '즉시 가동을 중지하고 매뉴얼의 점검 절차에 따라 원인을 확인한 뒤 필요 시 전문가에게 연락한다',
      '소음이 사라질 때까지 속도를 더 높인다',
      '동료에게만 구두로 알리고 별도 조치를 하지 않는다',
    ],
    correctIndex: 1,
    explanation:
        '이상 징후 발견 시 즉시 가동을 중지하고 안전 절차에 따라 원인을 점검하는 것이 안전사고를 예방하는 올바른 대응이다.',
    tags: ['기술적용', '안전'],
  );
  add(
    category: NcsCategory.technology,
    difficulty: Difficulty.high,
    stem:
        '지속가능한 발전을 위한 "친환경 기술(Green Technology)" 도입의 목적으로 가장 적절한 것은?',
    choices: [
      '단기적 생산 비용만을 최소화하기 위해',
      '환경 훼손을 줄이면서 경제적 효율성과 삶의 질을 동시에 추구하기 위해',
      '기존 기술을 전면 폐기하기 위해',
      '규제를 회피하기 위한 형식적 조치를 위해',
    ],
    correctIndex: 1,
    explanation:
        '친환경 기술은 환경 보호와 경제성, 삶의 질 향상을 동시에 추구하는 지속가능한 발전을 목표로 한다.',
    tags: ['친환경기술'],
  );
  add(
    category: NcsCategory.technology,
    difficulty: Difficulty.high,
    stem:
        '벤치마킹(Benchmarking)을 통한 기술 혁신 접근에 대한 설명으로 가장 적절한 것은?',
    choices: [
      '경쟁사의 기술을 무단으로 복제하는 행위',
      '우수한 조직이나 기술 사례를 체계적으로 분석하여 자사에 맞게 응용, 개선하는 활동',
      '자사 기술을 타사에 그대로 제공하는 활동',
      '기술 개발 자체를 포기하는 전략',
    ],
    correctIndex: 1,
    explanation:
        '벤치마킹은 우수 사례를 합법적, 체계적으로 분석하여 자사 실정에 맞게 응용 및 개선하는 경영 혁신 기법이다.',
    tags: ['벤치마킹'],
  );

  // 조직이해능력
  add(
    category: NcsCategory.organization,
    difficulty: Difficulty.low,
    stem: '조직의 경영전략 추진 과정에서 가장 먼저 이루어져야 하는 것은?',
    choices: ['전략 실행', '경영목표 및 전략 수립을 위한 환경 분석', '성과 평가', '조직 개편 공지'],
    correctIndex: 1,
    explanation:
        '경영전략은 내외부 환경 분석을 통해 목표와 전략을 수립하는 단계에서 시작하여 실행, 평가로 이어진다.',
    tags: ['경영전략'],
  );
  add(
    category: NcsCategory.organization,
    difficulty: Difficulty.low,
    stem: '조직도에서 "라인(line) 조직"의 특징으로 가장 적절한 것은?',
    choices: [
      '수평적 관계 중심으로 상하 지휘 계통이 없다',
      '명령 계통이 위에서 아래로 단순하고 일원화되어 있다',
      '전문 스태프 부서만으로 구성된다',
      '외부 이해관계자만으로 구성된다',
    ],
    correctIndex: 1,
    explanation:
        '라인 조직은 상급자에서 하급자로 이어지는 단순하고 일원화된 명령 계통을 특징으로 한다.',
    tags: ['조직구조'],
  );
  add(
    category: NcsCategory.organization,
    difficulty: Difficulty.mid,
    stem:
        '다음 중 SWOT 분석에서 "내부 환경 요인"에 해당하는 것으로만 짝지어진 것은?',
    choices: [
      '기회, 위협',
      '강점, 약점',
      '강점, 기회',
      '약점, 위협',
    ],
    correctIndex: 1,
    explanation:
        'SWOT에서 강점(Strength)과 약점(Weakness)은 내부 환경 요인이며, 기회(Opportunity)와 위협(Threat)은 외부 환경 요인이다.',
    tags: ['SWOT', '경영전략'],
  );
  add(
    category: NcsCategory.organization,
    difficulty: Difficulty.mid,
    stem:
        '결재 문서에서 "전결(專決)"의 의미로 가장 적절한 것은?',
    choices: [
      '최종 결재권자가 모든 사안을 직접 결재하는 것',
      '결재권을 위임받은 자가 자신의 책임 하에 최종 결재를 하는 것',
      '문서를 결재 없이 시행하는 것',
      '결재가 반려되어 재작성하는 것',
    ],
    correctIndex: 1,
    explanation:
        '전결은 결재권자로부터 결재 권한을 위임받은 사람이 자신의 책임 아래 최종적으로 결재하는 제도이다.',
    tags: ['업무이해', '결재제도'],
  );
  add(
    category: NcsCategory.organization,
    difficulty: Difficulty.high,
    stem:
        '조직 문화가 성과에 미치는 영향에 대한 설명으로 가장 적절한 것은?',
    choices: [
      '조직 문화는 성과와 전혀 관계가 없다',
      '긍정적 조직 문화는 구성원의 몰입과 협업을 촉진하여 장기적 성과 향상에 기여할 수 있다',
      '조직 문화는 오직 창업자 개인의 취향일 뿐이다',
      '조직 문화는 한 번 정해지면 절대 변하지 않는다',
    ],
    correctIndex: 1,
    explanation:
        '조직 문화는 구성원의 태도와 행동에 영향을 미쳐 몰입도, 협업, 나아가 조직 성과에 유의미한 영향을 줄 수 있다.',
    tags: ['조직문화'],
  );
  add(
    category: NcsCategory.organization,
    difficulty: Difficulty.high,
    stem:
        '글로벌 경영 환경에서 국제 감각을 기르기 위한 활동으로 가장 거리가 먼 것은?',
    choices: [
      '해외 시장 동향과 국제 이슈에 대한 지속적 관심',
      '다양한 문화적 배경을 가진 사람들과의 교류 경험 축적',
      '자국의 방식만이 항상 옳다는 전제 하에 협상 준비',
      '외국어 능력 및 국제 비즈니스 매너 학습',
    ],
    correctIndex: 2,
    explanation:
        '국제 감각은 자국 중심적 사고에서 벗어나 다양한 문화와 관점을 이해하고 존중하는 태도에서 길러진다.',
    tags: ['국제감각', '글로벌경영'],
  );

  // 직업윤리
  add(
    category: NcsCategory.ethics,
    difficulty: Difficulty.low,
    stem: '직업윤리의 기본 원칙으로 가장 거리가 먼 것은?',
    choices: ['정직과 신용의 원칙', '공정경쟁의 원칙', '연고주의에 따른 특혜 제공의 원칙', '전문성의 원칙'],
    correctIndex: 2,
    explanation:
        '직업윤리는 정직, 신용, 공정성, 전문성 등을 기본으로 하며 연고에 따른 특혜 제공은 공정경쟁 원칙에 위배된다.',
    tags: ['직업윤리기초'],
  );
  add(
    category: NcsCategory.ethics,
    difficulty: Difficulty.low,
    stem:
        '직장 내에서 상사가 부당한 사적 심부름을 반복적으로 지시할 때 가장 바람직한 대응은?',
    choices: [
      '무조건 따른다',
      '정중하지만 명확하게 업무 범위를 벗어난다는 점을 전달하고 필요시 회사의 절차를 통해 문제를 제기한다',
      '즉시 퇴사한다',
      '동료들에게만 불평하고 넘어간다',
    ],
    correctIndex: 1,
    explanation:
        '부당한 지시에 대해서는 정중하고 명확하게 의사를 표현하고, 필요할 경우 사내 절차를 통해 공식적으로 문제를 제기하는 것이 바람직하다.',
    tags: ['직장예절', '갑질대응'],
  );
  add(
    category: NcsCategory.ethics,
    difficulty: Difficulty.mid,
    stem: '다음 중 "직장 내 성희롱"에 해당할 가능성이 가장 높은 사례는?',
    choices: [
      '업무 성과에 대한 공식적인 피드백을 제공하는 것',
      '외모나 신체에 대한 반복적인 평가성 발언을 업무 중 하는 것',
      '정기 회의에서 프로젝트 진행 상황을 보고하는 것',
      '업무 매뉴얼을 함께 검토하는 것',
    ],
    correctIndex: 1,
    explanation:
        '업무와 무관하게 외모나 신체를 대상으로 한 반복적인 평가성 발언은 상대방에게 성적 수치심을 유발할 수 있어 직장 내 성희롱에 해당할 수 있다.',
    tags: ['성희롱예방'],
  );
  add(
    category: NcsCategory.ethics,
    difficulty: Difficulty.mid,
    stem:
        '공적 업무 수행 중 사적 이해관계가 얽힌 협력업체로부터 고가의 선물을 제안받았다. 가장 바람직한 대응은?',
    choices: [
      '개인적으로 조용히 받는다',
      '회사의 윤리 규정과 절차에 따라 수령을 거절하거나 신고 절차를 따른다',
      '거절하되 향후 편의를 봐주기로 구두로 약속한다',
      '가족 명의로 대신 받는다',
    ],
    correctIndex: 1,
    explanation:
        '이해관계가 있는 상대로부터의 금품·향응 제공은 부패로 이어질 수 있으므로 회사 윤리 규정에 따라 거절하거나 신고하는 것이 원칙이다.',
    tags: ['공정경쟁', '부패방지'],
  );
  add(
    category: NcsCategory.ethics,
    difficulty: Difficulty.high,
    stem:
        '내부고발(공익신고)과 관련된 설명으로 가장 적절한 것은?',
    choices: [
      '내부고발은 조직에 대한 배신 행위이므로 어떤 경우에도 정당화될 수 없다',
      '공익을 심각하게 침해하는 조직의 불법행위를 적법한 절차를 통해 알리는 것은 정당한 윤리적 행동으로 평가될 수 있다',
      '내부고발자는 반드시 익명을 포기해야 한다',
      '내부고발은 반드시 언론에 먼저 제보해야 효력이 있다',
    ],
    correctIndex: 1,
    explanation:
        '조직의 중대한 불법행위나 공익 침해 행위를 적법한 절차에 따라 알리는 공익신고는 직업윤리적으로 정당한 행위로 인정될 수 있다.',
    tags: ['내부고발', '공익신고'],
  );
  add(
    category: NcsCategory.ethics,
    difficulty: Difficulty.high,
    stem:
        '준법의식과 관련하여 "윤리적 딜레마" 상황에 대한 설명으로 가장 적절한 것은?',
    choices: [
      '법과 절차만 따르면 윤리적 갈등은 절대 발생하지 않는다',
      '두 가지 이상의 윤리적 가치나 의무가 충돌하여 어느 하나를 선택하기 어려운 상황을 의미한다',
      '개인의 이익을 항상 최우선으로 선택하면 해결되는 상황이다',
      '딜레마는 실제 업무에서는 발생하지 않는 이론적 개념일 뿐이다',
    ],
    correctIndex: 1,
    explanation:
        '윤리적 딜레마는 서로 충돌하는 가치나 의무 중 하나를 선택해야 하는 상황으로, 신중한 판단과 조직의 윤리 기준에 따른 의사결정이 필요하다.',
    tags: ['윤리적딜레마'],
  );

  return list;
}
