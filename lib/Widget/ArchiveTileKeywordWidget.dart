import 'package:flutter/material.dart';

class ArchiveTileKeywordWidget extends StatelessWidget {
  final String keywords;

  const ArchiveTileKeywordWidget({Key? key, required this.keywords}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> keywordList =
    keywords.split('/').map((e) => e.trim()).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 40.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: keywordList
              .map((keyword) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).disabledColor),
                  borderRadius: BorderRadius.circular(20.0)),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 5.0),
                child: Center(
                  child: Text(
                    "# $keyword",
                    style: TextStyle(
                        color: Theme.of(context).disabledColor, fontSize: 15.0),
                  ),
                ),
              ),
            ),
          ))
              .toList(),
        ),
      ),
    );
  }
}