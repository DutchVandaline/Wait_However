import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AnalysisCardWidget extends StatelessWidget {
  const AnalysisCardWidget({super.key, required this.title, required this.content});
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
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
}
