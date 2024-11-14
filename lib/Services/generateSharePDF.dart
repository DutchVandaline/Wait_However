import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:waithowever/Services/DataBase.dart';

Future<void> generateAndSharePdf(List<Article> articles) async {
  final pdf = pw.Document();
  final fontData = await rootBundle.load("assets/fonts/IBMPlexSansKR-Regular.ttf");
  final ttf = pw.Font.ttf(fontData);
  const maxArticlesPerPdf = 1000;

  int currentPageArticleCount = 0;
  List<pw.Document> pdfDocuments = [];
  pw.Document currentPdf = pw.Document();

  for (var article in articles) {
    if (currentPageArticleCount >= maxArticlesPerPdf) {
      pdfDocuments.add(currentPdf);
      currentPdf = pw.Document(); // Create a new document
      currentPageArticleCount = 0; // Reset counter
    }

    currentPdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("Original Article: ${article.original_article}", style: pw.TextStyle(font: ttf)),
              pw.Text("Keyword: ${article.keyword}", style: pw.TextStyle(font: ttf)),
              pw.Text("Tendency: ${article.tendency}", style: pw.TextStyle(font: ttf)),
              pw.Text("Facts: ${article.facts}", style: pw.TextStyle(font: ttf)),
              pw.Text("Perspective: ${article.perspective}", style: pw.TextStyle(font: ttf)),
              pw.Text("Changed Date: ${article.changedDate}", style: pw.TextStyle(font: ttf)),
              pw.Divider(),
            ],
          );
        },
      ),
    );

    currentPageArticleCount++;
  }

  if (currentPageArticleCount > 0) {
    pdfDocuments.add(currentPdf);
  }

  // Save or share each document
  try {
    final output = await getApplicationDocumentsDirectory();
    for (var i = 0; i < pdfDocuments.length; i++) {
      final file = File("${output.path}/WaitHowever_${i + 1}.pdf");
      await file.writeAsBytes(await pdfDocuments[i].save());
      Share.shareFiles([file.path]);
    }
  } catch (e) {
    print("Error generating PDF: $e");
  }
}
