import 'package:flutter/material.dart';

class KeywordWidget extends StatelessWidget {
  final String keywords;
  final bool showTitle;

  const KeywordWidget({Key? key, required this.keywords, required this.showTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> keywordList =
    keywords.split('/').map((e) => e.trim()).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showTitle ? Text(
            "Keywords",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Theme.of(context).primaryColorLight,
            ),
          ) : const SizedBox(),
          showTitle ? const SizedBox(height: 8) : const SizedBox(),
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