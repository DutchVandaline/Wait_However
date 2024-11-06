import 'package:flutter/material.dart';
import 'package:waithowever/Widget/buildCard.dart';


class PerspectiveWidget extends StatelessWidget {
  final String content;

  const PerspectiveWidget({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildCard("Perspective", content);
  }
}