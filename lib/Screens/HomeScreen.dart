import 'package:flutter/material.dart';
import 'package:waithowever/Screens/AnalysisScreen.dart';

String input_text = "";
String article = "";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          centerTitle: false,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  'a helpful assisant\nto keep you\nbalanced.'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Text(
                            "If you want to know the other perspective of article, paste the article in.\nArtificial Intelligence will help you.",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 16.0,
                                color: Theme.of(context).primaryColorLight),
                          )),
                    )
                  ],
                ),
              ),
              Padding(
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
                      hintText: "분석하고자 하는 게시글을 입력하세요.",
                      hintStyle: const TextStyle(fontFamily: "IBMPlexSansKR"),
                    ),
                    cursorColor: Theme.of(context).focusColor,
                    style: const TextStyle(fontFamily: "IBMPlexSansKR"),
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
