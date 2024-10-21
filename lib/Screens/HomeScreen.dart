import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:waithowever/Constants.dart';

String apiKey = Constants.apikey;
String input_text =
"""
As the 2024 election approaches, America finds itself at a pivotal moment. The nation is divided, with tensions higher than ever. The economy, immigration, and national security are front and center as Republicans and Democrats clash over the future of the country.

One of the most shocking events of this election season was the attempted assassination of former President Donald Trump. During a rally earlier this year, a gunman fired shots at Trump, sending shockwaves across the country. Though Trump survived, the incident galvanized his supporters, fueling their resolve to restore what they see as true American values. Trump’s resilience, both politically and personally, remains a testament to his influence and leadership.

As we head to the polls, the stakes could not be higher. Americans must decide between a return to conservative principles—law and order, economic growth, and personal freedom—or continue down a path many believe is leading to increased government control and instability. The future of this great republic is in the hands of its citizens. The fight for America’s soul continues.
""";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              """
              You are a assistant who gives a different perspective of the article. You need to provide 3 different part from the article in listed numerical format. First, analyze the article wheather it's conservative or progressive. Second, extract happened event provided in article. Third, give the other perspective or covered part that user can think of. Your answer needs to be 3 blocks, starting with following:
              "conservative/progressive
              happened event
               other perspective
              """));

      final response = await model.generateContent([
        Content.text("Article : $input_text"),
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
    super.initState();
    _analyzeArticle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: false,
        title: const Text("Hello 👋", style: TextStyle(fontSize: 40.0),),
      ),
      body: Center(
        child: Text(_analysisResult),
      ),
    );
  }
}
