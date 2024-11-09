import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:waithowever/Services/DataBase.dart';
import 'package:waithowever/Widget/DeletePopup.dart';
import 'package:waithowever/Widget/DetailWidget.dart';
import 'package:waithowever/Widget/KeywordWidget.dart';
import 'package:waithowever/Widget/TendencyWidget.dart';

class ArchiveDetailScreen extends StatefulWidget {
  const ArchiveDetailScreen({super.key, required this.articleItem});

  final Article articleItem;

  @override
  State<ArchiveDetailScreen> createState() => _ArchiveDetailScreenState();
}

class _ArchiveDetailScreenState extends State<ArchiveDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          scrolledUnderElevation: 0.0,
          title: Text(
            DateFormat("yyyy/MM/dd")
                .format(DateTime.parse(widget.articleItem.changedDate)),
            style: const TextStyle(
                fontFamily: "Poppins", fontWeight: FontWeight.w500),
          ),
          actions: [
            IconButton(
              onPressed: () {
                _showDialog();
              },
              icon: const Icon(
                Icons.bookmark_remove,
                size: 30.0,
              ),
            )
          ],
        ),
      ),
      body: ListView(
        children: [
          TendencyWidget(content: widget.articleItem.tendency),
          DetailWidget(
              inputTitle: "Original Article",
              inputItem: widget.articleItem.original_article),
          KeywordWidget(
            keywords: widget.articleItem.keyword,
            showTitle: false,
          ),
          DetailWidget(
              inputTitle: "Wait, However",
              inputItem: widget.articleItem.perspective)
        ],
      ),
    );
  }
  _showDialog() {
    showDialog(
        context: this.context,
        builder: (context) {
          return DeletePopUp(widget.articleItem);
        });
  }
}
