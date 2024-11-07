import 'package:flutter/material.dart';
import 'package:waithowever/Widget/AnalysisCardWidget.dart';

class FactsWidget extends StatelessWidget {
  final String content;

  const FactsWidget({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnalysisCardWidget(title: "Facts", content: content);
  }
}