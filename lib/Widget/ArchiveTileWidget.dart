import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:waithowever/Screens/ArchiveDetailScreen.dart';
import 'package:waithowever/Services/DataBase.dart';
import 'package:waithowever/Widget/ArchiveTileKeywordWidget.dart';

class ArchiveTileWidget extends StatefulWidget {
  const ArchiveTileWidget({super.key, required this.articleItem});

  final Article articleItem;

  @override
  State<ArchiveTileWidget> createState() => _ArchiveTileWidgetState();
}

class _ArchiveTileWidgetState extends State<ArchiveTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ArchiveDetailScreen(
                        articleItem: widget.articleItem,
                      )));
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Theme.of(context).cardColor),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat("yyyy/MM/dd")
                      .format(DateTime.parse(widget.articleItem.changedDate)),
                  style: const TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Text(
                    widget.articleItem.original_article,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(fontFamily: "IBMPlexSansKR"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: ArchiveTileKeywordWidget(
                      keywords: widget.articleItem.keyword),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
