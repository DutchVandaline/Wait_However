import 'package:flutter/foundation.dart';
import 'package:waithowever/Services/DataBase.dart';


class ArchiveNotifier extends ChangeNotifier {
  List _articles = [];

  List get articles {
    return [..._articles];
  }

  Future deleteArticle(String id) {
    _articles.removeWhere((element) => element.id == id);
    notifyListeners();
    print("Article Deleted!");
    return DBHelper().deleteArticle(id);
  }

  Future addArticle(
      String id,
      String original_article,
      String keyword,
      String tendency,
      String facts,
      String perspective,
      String changedDate,
      ) async {
    final articleItem = Article(
      id: id,
      original_article: original_article,
      keyword: keyword,
      tendency: tendency,
      facts: facts,
      perspective: perspective,
      changedDate: changedDate,
    );

    _articles.insert(_articles.length, articleItem);

    notifyListeners();

    DBHelper().insertArticle(articleItem);
  }

  Future updateArticle(
      String id,
      String original_article,
      String keyword,
      String tendency,
      String facts,
      String perspective,
      String changedDate,
      ) async {
    final articleItem = Article(
      id: id,
      original_article: original_article,
      keyword: keyword,
      tendency: tendency,
      facts: facts,
      perspective: perspective,
      changedDate: changedDate,
    );

    _articles[_articles.indexWhere((element) => element.id == id)] =
        articleItem;

    notifyListeners();

    DBHelper().updateArticle(articleItem);
  }

  Future getArticle() async {
    final articleList = await DBHelper().getArticles(0);

    _articles = articleList.map((item) {
      return Article(
        id: item.id,
        original_article: item.original_article,
        keyword: item.keyword,
        tendency: item.tendency,
        facts: item.facts,
        perspective: item.perspective,
        changedDate: item.changedDate,

      );
    }).toList();

    _articles.sort((a, b) => a.id.length.compareTo(b.id.length));
    notifyListeners();
  }
}
