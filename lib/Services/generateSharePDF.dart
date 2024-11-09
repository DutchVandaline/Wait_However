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

  pdf.addPage(
    pw.MultiPage(
      build: (pw.Context context) => [
        pw.Column(
          children: articles.map((article) {
            return pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 20),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text("Original Article: ${article.original_article}\n", style: pw.TextStyle(font: ttf)),
                  pw.Text("Keyword: ${article.keyword}\n", style: pw.TextStyle(font: ttf)),
                  pw.Text("Tendency: ${article.tendency}\n", style: pw.TextStyle(font: ttf)),
                  pw.Text("Facts: ${article.facts}\n", style: pw.TextStyle(font: ttf)),
                  pw.Text("Perspective: ${article.perspective}\n", style: pw.TextStyle(font: ttf)),
                  pw.Text("Changed Date: ${article.changedDate}\n", style: pw.TextStyle(font: ttf)),
                  pw.Divider(),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );

  final output = await getApplicationDocumentsDirectory();
  final file = File("${output.path}/WaitHowever.pdf");
  await file.writeAsBytes(await pdf.save());
  Share.shareFiles([file.path]);
}
