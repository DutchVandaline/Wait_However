import 'package:flutter/material.dart';
import 'package:waithowever/Screens/ArchiveDetailScreen.dart';
import 'package:waithowever/Services/DataBase.dart';

class ArticleTile extends StatefulWidget {
  const ArticleTile({super.key, required this.articleItem});

  final Article articleItem;

  @override
  State<ArticleTile> createState() => _ArticleTileState();
}

class _ArticleTileState extends State<ArticleTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ArchiveDetailScreen()));
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Theme.of(context).cardColor),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.articleItem.changedDate),
                Text(
                  widget.articleItem.original_article,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
