import 'package:flutter/material.dart';
import 'package:waithowever/Screens/AnalysisScreen.dart';

String input_text = "";
String article = "";

class AddArticleManualScreen extends StatefulWidget {
  const AddArticleManualScreen({super.key});

  @override
  State<AddArticleManualScreen> createState() => _AddArticleManualScreenState();
}

class _AddArticleManualScreenState extends State<AddArticleManualScreen> {
  final articleController = TextEditingController();

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
          title: const Text(
            "Manual Article",
            style: TextStyle(fontFamily: 'Poppins'),
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "URL에 문제가 있으신가요?\n직접 기사를 붙여 넣어보세요.",
                style: TextStyle(fontFamily: 'IBMPlexSansKR', fontSize: 17.0),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: TextField(
                      controller: articleController,
                      textInputAction: TextInputAction.done,
                      maxLines: null,
                      onChanged: (text) {
                        article = text;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        hintText: "분석하고자 하는 게시글을 붙여넣으세요.",
                        hintStyle: const TextStyle(fontFamily: "IBMPlexSansKR"),
                      ),
                      cursorColor: Theme.of(context).focusColor,
                      style: const TextStyle(fontFamily: "IBMPlexSansKR"),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    articleController.text == "" ||
                            articleController.text.isEmpty
                        ? () {}
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AnalysisScreen(
                                    inputArticle: articleController.text)));
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
                    )),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
