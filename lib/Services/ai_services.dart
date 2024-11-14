// services/analysis_service.dart
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:waithowever/Constants.dart';
import 'package:waithowever/API_KEY.dart';

class AnalysisService {
  final String apiKey = API_KEY.apikey;

  Future<String> fetchAnalysis(String inputArticle) async {
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
      systemInstruction: Content.text(Constants().prompt_Engineering),
    );

    final response = await model.generateContent([
      Content.text("Article : $inputArticle"),
    ]);

    // Replace all asterisks with an empty string
    return response.text!.replaceAll("*", "");
  }


  Map<String, String> splitTextByCategory(String text) {
    Map<String, String> categorizedText = {
      "tendency": "",
      "keyword": "",
      "facts": "",
      "perspective": ""
    };

    List<String> sections = text.split(RegExp(r'(?=zai_tendency|zai_keyword|zai_facts|zai_perspective)'));

    for (var section in sections) {
      if (section.startsWith("zai_tendency")) {
        categorizedText["tendency"] = section.replaceAll("zai_tendency:", "").trim();
      } else if (section.startsWith("zai_keyword")) {
        categorizedText["keyword"] = section.replaceAll("zai_keyword:", "").trim();
      } else if (section.startsWith("zai_facts")) {
        categorizedText["facts"] = section.replaceAll("zai_facts:", "").trim();
      } else if (section.startsWith("zai_perspective")) {
        categorizedText["perspective"] = section.replaceAll("zai_perspective:", "").trim();
      }
    }

    return categorizedText;
  }
}
