import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
                height: 1.05),
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
                  children: _buildCategoryWidgets(),
                ),
        ),
      ),
    );
  }

  List<Widget> _buildCategoryWidgets() {
    List<Widget> widgets = [];

    _categorizedResults.forEach((key, value) {
      if (key == "keyword") {
        List<String> keywords = value.split('/').map((e) => e.trim()).toList();
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
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
                      children: keywords
                          .map((keyword) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).canvasColor,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
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
            ),
          ),
        );
      } else {
        widgets.add(_buildCard(key.capitalize(), value));
      }
    });
    return widgets;
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
              p: const TextStyle(fontSize: 17), // 본문 폰트 크기를 16으로 설정
            ),
          ),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
