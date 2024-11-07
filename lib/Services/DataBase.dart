import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
//SQFlite에서는 Bool타입이 존재하지 X. 따라서 INT 타입 0과 1로 선언함.

class DBHelper {
  var _db;

  Future<Database> get database async {
    if (_db != null) return _db;
    _db = openDatabase(
      join(await getDatabasesPath(), 'articles.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE articles(id TEXT PRIMARY KEY, original_article TEXT, keyword Text, tendency TEXT, facts TEXT, perspective TEXT, changedDate TEXT)",
        );
      },
      version: 1,
    );
    return _db;
  }

  Future<void> insertArticle(Article article) async {
    final Database db = await database;

    await db.insert(
      'articles',
      article.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("insert article $article");
  }

  Future<List<Article>> getArticles(int numb) async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps =
        await db.query('articles', whereArgs: [numb]);

    return List.generate(maps.length, (i) {
      return Article(
        id: maps[i]['id'],
        original_article: maps[i]['original_article'],
        keyword: maps[i]['keyword'],
        tendency: maps[i]['tendency'],
        facts: maps[i]['facts'],
        perspective: maps[i]['perspective'],
        changedDate: maps[i]['changedDate'],
      );
    });
  }

  Future<List<Article>> findArticlesByKeyword(String keyword) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'articles',
      where: 'keyword LIKE ?',
      whereArgs: ['%$keyword%'],
    );

    return List.generate(maps.length, (i) {
      return Article(
        id: maps[i]['id'],
        original_article: maps[i]['original_article'],
        keyword: maps[i]['keyword'],
        tendency: maps[i]['tendency'],
        facts: maps[i]['facts'],
        perspective: maps[i]['perspective'],
        changedDate: maps[i]['changedDate'],
      );
    });
  }


  Future<List<Article>> findArticle(String id) async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.query('articles', where: 'id = ?', whereArgs: [id]);

    return List.generate(maps.length, (i) {
      return Article(
        id: maps[i]['id'],
        original_article: maps[i]['original_article'],
        keyword: maps[i]['keyword'],
        tendency: maps[i]['tendency'],
        facts: maps[i]['facts'],
        perspective: maps[i]['perspective'],
        changedDate: maps[i]['changedDate'],
      );
    });
  }

  Future<void> updateArticle(Article article) async {
    final db = await database;

    await db.update(
      'articles',
      article.toMap(),
      where: "id = ?",
      whereArgs: [article.id],
    );
    print("update article $article");
  }

  Future<void> deleteArticle(String id) async {
    final db = await database;

    await db.delete(
      'articles',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}

class Article {
  final String id;
  final String original_article;
  final String keyword;
  final String tendency;
  final String facts;
  final String perspective;
  final String changedDate;

  Article({
    required this.id,
    required this.original_article,
    required this.keyword,
    required this.tendency,
    required this.facts,
    required this.perspective,
    required this.changedDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'original_article': original_article,
      'keyword': keyword,
      'tendency': tendency,
      'facts': facts,
      'perspective': perspective,
      'changedDate': changedDate,
    };
  }

  @override
  String toString() {
    return 'Article {id: $id, original_article: $original_article, keyword: $keyword, tendency: $tendency, facts: $facts, perspective: $perspective}';
  }
}
