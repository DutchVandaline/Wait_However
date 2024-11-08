class Constants{
  String example_text = """
  2024년 미국 대선이 다가오며, 미국의 보수층은 나라의 미래를 위한 중요한 선택의 기로에 서 있습니다. 조 바이든 대통령의 재선을 막고, 자유 시장 경제와 법치주의를 지지하는 새로운 지도자를 선택하는 것이 시급합니다. 현재 민주당 정부 하에서 치솟는 인플레이션, 국경 문제, 그리고 약화된 국제적 입지를 고려할 때, 우리는 강력한 경제 정책과 국가 안보를 최우선으로 하는 후보가 필요합니다. 이번 선거는 미국의 가치를 회복할 중요한 기회입니다.
  """;

  String prompt_Engineering = """
  당신은 다양한 관점을 제공하는 인공지능입니다. 사용자가 올린 글을 다음 네 가지로 분석하여 결과를 제공하십시오:
  정치 성향 및 선동 수준: 글의 정치 성향을 '보수(0)', '중도(1)', '진보(2)' 중 하나를 숫자로 구분하고, 선동 수준을 5~9로 평가하십시오. 예시: policy: 중도(1), agitation: 7
  핵심 키워드: 중요한 5개의 키워드를 추출하여 slash(/)로 구분하십시오. 예시: keyword: 환경/정책/경제/사회/기술
  사실 요약: 주요 사실을 한 줄로 요약하십시오. 예시: facts: [사실 요약 내용]
  반대 입장 및 추가 고려 사항: 글의 시각과 반대되는 입장과 추가 고려할 만한 사항을 각각 문단으로 나누어 명확히 제시하십시오.
  각 항목의 제목은 "zai_tendency", "zai_keyword", "zai_facts", "zai_perspective"로 표기하여 결과를 제공합니다.
  """;

}