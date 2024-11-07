import 'package:waithowever/Services/DataBase.dart';
import 'package:waithowever/Services/ArchiveNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeletePopUp extends StatelessWidget {
  final Article selectedArticle;

  const DeletePopUp(this.selectedArticle, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: const Text("스크랩 취소",
          style: TextStyle(
              fontFamily: "IBMPlexSansKR")),
      content: const Text("해당 기사 스크랩을 삭제하시겠습니까?\n삭제 이후에는 복구할 수 없습니다.",
          style: TextStyle(fontFamily: "IBMPlexSansKR", fontSize: 19.0)),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          child: InkWell(
            child: const Text(
              "삭제",
              style: TextStyle(fontFamily: "IBMPlexSansKR", fontSize: 17.0),
            ),
            onTap: () async {
              Provider.of<ArchiveNotifier>(context, listen: false)
                  .deleteArticle(selectedArticle.id);
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          child: InkWell(
            child: const Text(
              "돌아가기",
              style: TextStyle(fontFamily: "IBMPlexSansKR", fontSize: 17.0),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
  }
}
