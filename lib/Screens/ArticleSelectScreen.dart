import 'package:flutter/material.dart';
import 'package:waithowever/Screens/AnalysisScreen.dart';

class ArticleSelectScreen extends StatefulWidget {
  const ArticleSelectScreen({super.key, required this.articleContent});
  final String articleContent;

  @override
  State<ArticleSelectScreen> createState() => _ArticleSelectScreenState();
}

class _ArticleSelectScreenState extends State<ArticleSelectScreen> {
  List<String> _paragraphs = [];
  List<int> _selectedIndices = [];

  @override
  void initState() {
    super.initState();
    _paragraphs = widget.articleContent.split('\n').where((p) => p.trim().isNotEmpty).toList();
  }

  void toggleParagraphSelection(int index) {
    setState(() {
      if (_selectedIndices.contains(index)) {
        _selectedIndices.remove(index);
      } else {
        _selectedIndices.add(index);
      }
    });
  }

  bool isParagraphSelected(int index) {
    return _selectedIndices.contains(index);
  }

  void selectAllParagraphs() {
    setState(() {
      if (_selectedIndices.length == _paragraphs.length) {
        _selectedIndices.clear();
      } else {
        _selectedIndices = List<int>.generate(_paragraphs.length, (index) => index); // 모두 선택
      }
    });
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
          "Select Article",
          style: TextStyle(fontFamily: "Poppins"),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _selectedIndices.length == _paragraphs.length ? Icons.deselect : Icons.select_all,
              color: Colors.blueAccent,
            ),
            onPressed: selectAllParagraphs,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _paragraphs.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => toggleParagraphSelection(index),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        decoration: BoxDecoration(
                          color: isParagraphSelected(index)
                              ? Colors.blueAccent.withOpacity(0.2)
                              : Theme.of(context).scaffoldBackgroundColor,
                          border: Border.all(
                            color: isParagraphSelected(index)
                                ? Colors.blueAccent
                                : Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          _paragraphs[index],
                          style: const TextStyle(fontSize: 16.0, fontFamily: "IBMPlexSansKR"),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    String selectedText = (_selectedIndices..sort())
                        .map((index) => _paragraphs[index])
                        .join('\n\n');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnalysisScreen(inputArticle: selectedText),
                      ),
                    );
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
      ),
    );
  }
}

