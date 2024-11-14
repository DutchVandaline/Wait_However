import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:waithowever/Screens/AboutScreen.dart';
import 'package:waithowever/Screens/ArticleSelectScreen.dart';

String article = "";

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late StreamSubscription _intentSub;
  final _sharedFiles = <SharedMediaFile>[];
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
        _articleContent = "올바르지 않은 URL이거나 오류가 발생했습니다.";
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
          .where((text) =>
              excludeKeywords.every((keyword) => !text.contains(keyword)))
          .join('\n\n') // 문단 구분을 위해 줄바꿈 두 개 사용
          .replaceAll('\t', ' ')
          .replaceAll(RegExp(r'[ ]{2,}'), ' '); // 연속된 공백만 하나로 축소

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
          .where((text) =>
              excludeKeywords.every((keyword) => !text.contains(keyword)))
          .join('\n\n') // 문단 구분을 위해 줄바꿈 두 개 사용
          .replaceAll('\t', ' ')
          .replaceAll(RegExp(r'[ ]{2,}'), ' '); // 연속된 공백만 하나로 축소

      return filteredContent.isNotEmpty ? filteredContent : "본문을 찾을 수 없습니다.";
    }
  }

  void _showSnackbar(String message, {Color backgroundColor = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        content: Text(
          message,
          style: const TextStyle(fontFamily: 'IBMPlexSansKR', fontSize: 16.0),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    article = "";
    _intentSub = ReceiveSharingIntent.instance.getMediaStream().listen(
        (List<SharedMediaFile> value) {
      if (value.isNotEmpty) {
        String potentialUrl = extractUrlFromPath(value.first.path);
        if (potentialUrl.isNotEmpty) {
          setState(() {
            _urlController.text = potentialUrl;
          });
        }
      }
    }, onError: (err) {
      print("getMediaStream error: $err");
    });

    // Get shared media when the app is launched from a share
    ReceiveSharingIntent.instance
        .getInitialMedia()
        .then((List<SharedMediaFile> value) {
      if (value.isNotEmpty) {
        String potentialUrl = extractUrlFromPath(value.first.path);
        if (potentialUrl.isNotEmpty) {
          setState(() {
            _urlController.text =
                potentialUrl; // Update text field with shared URL
          });
        }
      }
    });
  }

  // Helper function to extract URL if path contains one
  String extractUrlFromPath(String path) {
    // Basic check for URL pattern in path; adjust as needed for URL structure
    final urlPattern = RegExp(r'https?://[^\s]+');
    final match = urlPattern.firstMatch(path);
    return match != null ? match.group(0) ?? "" : "";
  }

  @override
  void dispose() {
    _intentSub.cancel();
    super.dispose();
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.w800)),
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 40.0, horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0, bottom: 6.0),
                        child: Text(
                          "Input URL",
                          style:
                              TextStyle(fontFamily: "Poppins", fontSize: 17.0),
                        ),
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
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10.0)),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            hintText: "분석하고자 하는 기사의 URL을 공유하세요.",
                            hintStyle:
                                const TextStyle(fontFamily: "IBMPlexSansKR"),
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
                    onTap: () async {
                      if (_urlController.text.isEmpty) {
                        _showSnackbar("URL을 입력해주세요.");
                      } else {
                        await fetchAndExtractContent();
                        if (_articleContent == "URL을 입력하세요." ||
                            _articleContent == "본문을 찾을 수 없습니다." ||
                            _articleContent.contains("오류 발생:") ||
                            _articleContent == "웹페이지를 로드하지 못했습니다.") {
                          _showSnackbar(_articleContent);
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArticleSelectScreen(
                                articleContent: _articleContent,
                              ),
                            ),
                          );
                        }
                      }
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
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AboutScreen()));
              },
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: "Poppins",
                    color: Theme.of(context).primaryColorLight,
                  ),
                  children: const <TextSpan>[
                    TextSpan(text: 'About '),
                    TextSpan(
                        text: 'Wait,However',
                        style: TextStyle(fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
