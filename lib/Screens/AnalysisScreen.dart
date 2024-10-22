import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:waithowever/Constants.dart';
import 'package:waithowever/API_KEY.dart';

class AnalysisScreen extends StatefulWidget {
  final String inputArticle;

  AnalysisScreen({super.key, required this.inputArticle});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  String apiKey = API_KEY.apikey;
  String _analysisResult = "Analyzing...";
  bool _isLoading = true;


  Future<void> _analyzeArticle() async {
    try {
      final model = GenerativeModel(
          model: "gemini-1.5-pro",
          apiKey: apiKey,
          generationConfig: GenerationConfig(
            temperature: 1.0,
            topK: 64,
            topP: 0.95,
            maxOutputTokens: 8192,
            responseMimeType: "text/plain",
          ),
          systemInstruction: Content.text(
            Constants().prompt_Engineering
          ));

      final response = await model.generateContent([
        Content.text("Article : ${widget.inputArticle}"),
      ]);
      setState(() {
        _analysisResult = response.text!;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _analysisResult = "Error analyzing Article: $error";
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
        title: const Text(
          "Analysis 🏴‍☠️",
          style: TextStyle(fontSize: 30.0),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: _isLoading
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: ListView(children: [
                        MarkdownBody(data: _analysisResult)
                      ]),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: const Center(
                    child: Text(
                  "뒤로 가기",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
