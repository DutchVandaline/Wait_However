import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waithowever/Screens/ArticleSearchScreen.dart';
import 'package:waithowever/Services/ArchiveNotifier.dart';
import 'package:waithowever/Widget/ArchiveTileWidget.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({super.key});

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        scrolledUnderElevation: 0.0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ArticleSearchScreen()));
              },
              icon: const Icon(
                Icons.search,
                size: 25.0,
              ))
        ],
        title: RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
              fontSize: 30.0,
              color: Theme.of(context).primaryColorLight,
              height: 1.05,
            ),
            children: const <TextSpan>[
              TextSpan(text: 'Wait, '),
              TextSpan(
                  text: 'Archive',
                  style: TextStyle(fontWeight: FontWeight.w800)),
            ],
          ),
        ),
      ),
      body: FutureBuilder(
          future:
              Provider.of<ArchiveNotifier>(context, listen: false).getArticle(),
          builder: (context, AsyncSnapshot snapshot) {
            return Scaffold(
              body: Consumer<ArchiveNotifier>(
                builder: (context, articleData, child) {
                  return articleData.articles.isEmpty
                      ? Container(
                          alignment: Alignment.center,
                          child: const Text(
                            '📄 아카이브 된 기사가 없습니다.',
                            style: TextStyle(
                                fontSize: 20.0, fontFamily: "IBMPlexSansKR"),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: articleData.articles.length,
                          itemBuilder: (context, index) {
                            final i = index;
                            final articleItem = articleData.articles[i];
                            return ArchiveTileWidget(articleItem: articleItem);
                          });
                },
              ),
            );
          }),
    );
  }
}
