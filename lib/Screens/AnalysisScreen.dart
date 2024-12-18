import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:waithowever/Screens/MainScreen.dart';
import 'package:waithowever/Services/ArchiveNotifier.dart';
import 'package:waithowever/Services/ai_services.dart';
import 'package:waithowever/Widget/FactsWidget.dart';
import 'package:waithowever/Widget/KeywordWidget.dart';
import 'package:waithowever/Widget/PrespectiveWidget.dart';
import 'package:waithowever/Widget/TendencyWidget.dart';

String nowId = "";

class AnalysisScreen extends StatefulWidget {
  final String inputArticle;

  const AnalysisScreen({super.key, required this.inputArticle});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  bool isScrapped = false;
  final AnalysisService _analysisService = AnalysisService();
  bool _isLoading = true;
  Map<String, String> _categorizedResults = {
    "tendency": "",
    "keyword": "",
    "facts": "",
    "perspective": ""
  };

  String _textToShow = '인공지능이 기사를 읽고 있어요!';
  late Timer _timer;

  // 텍스트 메시지 리스트와 현재 메시지 인덱스 설정
  final List<String> _loadingMessages = [
    '인공지능이 기사를 읽고 있어요!',
    '읽은 기사를 분석하고 있어요!',
    '다루지 않은 부분을 생각하고 있어요!',
    '조금만 더 기다려 주세요!'
  ];
  int _currentMessageIndex = 0;

  Future<void> _analyzeArticle() async {
    try {
      final result = await _analysisService.fetchAnalysis(widget.inputArticle);
      setState(() {
        _categorizedResults = _analysisService.splitTextByCategory(result);
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _categorizedResults = {
          "tendency": "Error analyzing article.",
          "keyword": "",
          "facts": "",
          "perspective": ""
        };
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    _analyzeArticle();
    nowId = "";

    _startTextUpdate();
    super.initState();
  }

  void _startTextUpdate() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _textToShow = _loadingMessages[_currentMessageIndex];
        _currentMessageIndex = (_currentMessageIndex + 1) % _loadingMessages.length;
      });
    });
  }

  @override
  void dispose() {
    // 화면을 떠날 때 Timer를 취소하여 리소스를 절약
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        scrolledUnderElevation: 0.0,
        centerTitle: false,
        automaticallyImplyLeading: false,
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
                  text: 'However',
                  style: TextStyle(fontWeight: FontWeight.w800)),
            ],
          ),
        ),
        actions: [
          _isLoading
              ? const SizedBox()
              : Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    isScrapped = !isScrapped;
                    isScrapped
                        ? saveArticle(context)
                        : Provider.of<ArchiveNotifier>(context,
                        listen: false)
                        .deleteArticle(nowId);
                  });
                },
                icon: Icon(
                  isScrapped
                      ? Icons.bookmark_remove
                      : Icons.bookmark_border_outlined,
                  size: 30.0,
                )),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: _isLoading
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitCircle(
                  color: Theme.of(context).primaryColorLight,
                  size: 50.0,
                ),
                const SizedBox(height: 10),
                Text(
                  _textToShow,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
              ],
            ),
          )
              : ListView(
            children: [
              KeywordWidget(
                keywords: _categorizedResults["keyword"] ?? "",
                showTitle: true,
              ),
              TendencyWidget(
                  content: _categorizedResults["tendency"] ?? ""),
              FactsWidget(content: _categorizedResults["facts"] ?? ""),
              PerspectiveWidget(
                  content: _categorizedResults["perspective"] ?? ""),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainScreen()),
                            (route) => false);
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
                          "뒤로 가기",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontFamily: "IBMPlexSansKR"),
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void saveArticle(BuildContext context) {
    DateTime now = DateTime.now();
    String id = memosha512(now.toString());
    String changedDate = DateFormat('yyyyMMdd').format(now);
    nowId = id;
    Provider.of<ArchiveNotifier>(context, listen: false).addArticle(
      id,
      widget.inputArticle,
      //original_Article
      _categorizedResults["keyword"] ?? "",
      //keyword
      _categorizedResults["tendency"] ?? "",
      //tendency
      _categorizedResults["facts"] ?? "",
      //facts,
      _categorizedResults["perspective"] ?? "",
      //perspective
      changedDate,
    );
  }

  String memosha512(String text) {
    var bytes = utf8.encode(text);
    var digest = sha512.convert(bytes);
    return digest.toString();
  }
}
