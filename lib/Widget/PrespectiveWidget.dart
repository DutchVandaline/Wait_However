import 'package:flutter/material.dart';
import 'package:waithowever/Widget/AnalysisCardWidget.dart';


class PerspectiveWidget extends StatelessWidget {
  final String content;

  const PerspectiveWidget({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String filteredContent = content.replaceAll('zai_perspective', '');

    return AnalysisCardWidget(title: "Perspective", content: filteredContent);
  }
}