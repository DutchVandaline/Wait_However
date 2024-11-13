import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'package:waithowever/Screens/ArticleSelectScreen.dart';

String input_text = "";
String article = "";

class HomeScreen_URLONLY extends StatefulWidget {
  const HomeScreen_URLONLY({super.key});

  @override
  State<HomeScreen_URLONLY> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen_URLONLY> {
  final _urlController = TextEditingController();
  String _articleContent = "여기서 표시됩니다.";

  Future<void> fetchAndExtractContent() async {
    final url = _urlController.text;
    if (url.isEmpty) {
      setState(() {
        _articleContent = "URL을 입력하세요.";
      });
      print(_articleContent); // 콘솔 출력
      return;
    }

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final content = extractContent(response.body);
        setState(() {
          _articleContent = content.isNotEmpty ? content : "본문을 찾을 수 없습니다.";
        });
      } else {
        setState(() {
          _articleContent = "웹페이지를 로드하지 못했습니다.";
        });
      }
    } catch (e) {
      setState(() {
        _articleContent = "오류 발생: $e";
      });
    }

    // 화면에 표시할 내용 콘솔에 출력
    print(_articleContent);
  }

  String extractContent(String htmlContent) {
    final document = html_parser.parse(htmlContent);

    // MBC 뉴스 본문이 포함된 특정 태그 선택 (예: <div class="news_txt">)
    final articleElement = document.querySelector('div.news_txt');

    if (articleElement != null) {
      final paragraphs = articleElement.querySelectorAll('p');

      final excludeKeywords = [
        '로그인',
        '공유',
        '글자크기',
        '댓글',
        '페이스북',
        '트위터',
        'URL 복사'
      ];

      final filteredContent = paragraphs
          .map((element) => element.text.trim())
          .where((text) => excludeKeywords.every((keyword) => !text.contains(keyword)))
          .join('\n\n')  // 문단 구분을 위해 줄바꿈 두 개 사용
          .replaceAll('\t', ' ')
          .replaceAll(RegExp(r'[ ]{2,}'), ' ');  // 연속된 공백만 하나로 축소


      return filteredContent.isNotEmpty ? filteredContent : "본문을 찾을 수 없습니다.";
    } else {
      final paragraphs = document.querySelectorAll('p');

      final excludeKeywords = [
        '로그인',
        '공유',
        '글자크기',
        '댓글',
        '페이스북',
        '트위터',
        'URL 복사'
      ];

      final filteredContent = paragraphs
          .map((element) => element.text.trim())
          .where((text) => excludeKeywords.every((keyword) => !text.contains(keyword)))
          .join('\n\n')  // 문단 구분을 위해 줄바꿈 두 개 사용
          .replaceAll('\t', ' ')
          .replaceAll(RegExp(r'[ ]{2,}'), ' ');  // 연속된 공백만 하나로 축소


      return filteredContent.isNotEmpty ? filteredContent : "본문을 찾을 수 없습니다.";
    }
  }

  @override
  void initState() {
    input_text = "";
    article = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          fontSize: 35.0,
                          color: Theme.of(context).primaryColorLight,
                          height: 1.05),
                      children: const <TextSpan>[
                        TextSpan(text: 'Hello, I am\n'),
                        TextSpan(
                            text: 'Wait,However\n',
                            style: TextStyle(
                                fontSize: 35.0, fontWeight: FontWeight.w800)),
                        TextSpan(
                            text:
                                'a helpful assistant\nto keep you\nbalanced.'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        "If you want to know the other perspective of the article, paste the article in.\nArtificial Intelligence will help you.",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16.0,
                            color: Theme.of(context).primaryColorLight),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0, bottom: 6.0),
                    child: Text("Input URL", style: TextStyle(fontFamily: "Poppins", fontSize: 17.0),),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: TextField(
                      controller: _urlController,
                      textInputAction: TextInputAction.done,
                      maxLines: 1,
                      onChanged: (text) {
                        article = text;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        hintText: "분석하고자 하는 기사의 URL을 입력하세요.",
                        hintStyle: const TextStyle(fontFamily: "IBMPlexSansKR"),
                      ),
                      cursorColor: Theme.of(context).focusColor,
                      style: const TextStyle(fontFamily: "IBMPlexSansKR"),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  fetchAndExtractContent().then((value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ArticleSelectScreen(articleContent: _articleContent))));

                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Center(
                    child: Text(
                      "게시글 성향 분석하기",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: "IBMPlexSansKR"),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
