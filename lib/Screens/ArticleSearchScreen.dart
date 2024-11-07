import 'dart:async';

import 'package:flutter/material.dart';
import 'package:waithowever/Services/DataBase.dart';
import 'package:waithowever/Widget/ArchiveTileWidget.dart';

class ArticleSearchScreen extends StatefulWidget {
  const ArticleSearchScreen({super.key});

  @override
  _ArticleSearchScreenState createState() => _ArticleSearchScreenState();
}

class _ArticleSearchScreenState extends State<ArticleSearchScreen> {
  final DBHelper dbHelper = DBHelper();
  List<Article> _articles = [];
  String _searchKeyword = '';
  Timer? _debounce;

  void _onSearchChanged(String keyword) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _searchArticles(keyword);
    });
  }

  void _searchArticles(String keyword) async {
    if (keyword.isEmpty) {
      setState(() {
        _articles = [];
      });
      return;
    }

    List<Article> articles = await dbHelper.findArticlesByKeyword(keyword);
    setState(() {
      _articles = articles;
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: const Text(
          "Search",
          style: TextStyle(fontFamily: "Poppins"),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: TextField(
              onChanged: (value) {
                _onSearchChanged(value);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).primaryColorLight),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).primaryColorLight),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).primaryColorLight),
                ),
                hintText: "키워드를 입력하세요",
                hintStyle: const TextStyle(fontFamily: "IBMPlexSansKR"),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 12.0),
              ),
            ),
          ),
          Expanded(
            child: _articles.isEmpty && _searchKeyword.isEmpty
                ? Center(
                    child: Text(
                      "스크랩한 기사의 키워드를 검색하세요.",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Theme.of(context).primaryColorLight,
                        fontFamily: "IBMPlexSansKR",
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: _articles.length,
                    itemBuilder: (context, index) {
                      final article = _articles[index];
                      return ArchiveTileWidget(articleItem: article);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
