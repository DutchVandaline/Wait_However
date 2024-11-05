import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:waithowever/Services/ai_services.dart';

class AnalysisScreen extends StatefulWidget {
  final String inputArticle;

  const AnalysisScreen({super.key, required this.inputArticle});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  final AnalysisService _analysisService = AnalysisService();
  bool _isLoading = true;
  Map<String, String> _categorizedResults = {
    "tendency": "",
    "keyword": "",
    "facts": "",
    "perspective": ""
  };

  Future<void> _analyzeArticle() async {
    try {
      final result = await _analysisService.fetchAnalysis(widget.inputArticle);
      setState(() {
        _categorizedResults = _analysisService.splitTextByCategory(result);
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _categorizedResults = {
          "tendency": "Error analyzing article.",
          "keyword": "",
          "facts": "",
          "perspective": ""
        };
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    _analyzeArticle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        scrolledUnderElevation: 0.0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
              fontSize: 30.0,
              color: Theme.of(context).primaryColorLight,
              height: 1.05,
            ),
            children: const <TextSpan>[
              TextSpan(text: 'Wait, '),
              TextSpan(
                  text: 'However',
                  style: TextStyle(fontWeight: FontWeight.w800)),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColorLight,
                  ),
                )
              : ListView(
                  children: [
                    KeywordWidget(
                        keywords: _categorizedResults["keyword"] ?? ""),
                    TendencyWidget(
                        content: _categorizedResults["tendency"] ?? ""),
                    FactsWidget(content: _categorizedResults["facts"] ?? ""),
                    PerspectiveWidget(
                        content: _categorizedResults["perspective"] ?? ""),
                  ],
                ),
        ),
      ),
    );
  }
}

class KeywordWidget extends StatelessWidget {
  final String keywords;

  const KeywordWidget({Key? key, required this.keywords}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> keywordList =
        keywords.split('/').map((e) => e.trim()).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Keywords",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 40.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: keywordList
                  .map((keyword) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).canvasColor,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Center(
                              child: Text(
                                "# $keyword",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 17.0),
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class TendencyWidget extends StatelessWidget {
  final String content;

  const TendencyWidget({Key? key, required this.content}) : super(key: key);

  Map<String, int> _extractValues(String text) {
    final regExp = RegExp(r'(\w+):\s*(-?\d+)');
    Map<String, int> values = {};

    for (var match in regExp.allMatches(text)) {
      final tag = match.group(1)!;
      final value = int.parse(match.group(2)!);
      values[tag] = value;
    }

    return values;
  }

  List _getPolicyIcon(int value) {
    if (value == -3) return [Icons.shield, "보수적"];
    if (value == -2) return [Icons.balance, "중도"];
    if (value == -1) return [Icons.attach_money, "진보적"];
    return [Icons.warning_amber, "문제가 발생했습니다."];
  }

  List _getAgitationIcon(int value) {
    if (value == 1) return [Icons.sentiment_satisfied_alt, "낮은 선동성"];
    if (value == 2) return [Icons.sentiment_neutral, "약한 선동성"];
    if (value == 3) return [Icons.sentiment_dissatisfied, "보통 선동성"];
    if (value == 4) return [Icons.sentiment_very_dissatisfied, "다분히 선동적"];
    if (value == 5) return [Icons.warning, "심히 선동적"];
    return [Icons.help_outline, "문제가 발생했습니다."];
  }

  @override
  Widget build(BuildContext context) {
    final values = _extractValues(content);
    final policyValue = values['policy'] ?? 0;
    final agitationValue = values['agitation'] ?? 0;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Tendency",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Icon(_getPolicyIcon(policyValue)[0], size: 30),
                  SizedBox(height: 10.0,),
                  Text(
                    _getPolicyIcon(policyValue)[1],
                    style: const TextStyle(fontFamily: "Poppins", fontSize: 20.0),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Column(
                children: [
                  Icon(_getAgitationIcon(agitationValue)[0], size: 30),
                  SizedBox(height: 10.0,),
                  Text(
                    _getAgitationIcon(agitationValue)[1],
                    style: const TextStyle(fontFamily: "Poppins", fontSize: 20.0),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class FactsWidget extends StatelessWidget {
  final String content;

  const FactsWidget({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildCard("Facts", content);
  }
}

class PerspectiveWidget extends StatelessWidget {
  final String content;

  const PerspectiveWidget({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildCard("Perspective", content);
  }
}

Widget _buildCard(String title, String content) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        MarkdownBody(
          data: content,
          styleSheet: MarkdownStyleSheet(
            p: const TextStyle(fontSize: 17),
          ),
        ),
      ],
    ),
  );
}
