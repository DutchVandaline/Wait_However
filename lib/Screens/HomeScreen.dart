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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: false,
          title: const Text(
            "Hello 👋",
            style: TextStyle(fontSize: 40.0),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
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
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10.0)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    hintText: "분석하고자 하는 게시글을 입력하세요.",
                  ),
                  cursorColor: Theme.of(context).focusColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  articleController.text == "" || articleController.text.isEmpty
                      ? (){}
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
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const Center(
                      child: Text(
                    "게시글의 성향 분석하기",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  )),
                ),
              ),
            )
          ],
        ));
  }
}
