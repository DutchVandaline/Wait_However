import 'package:flutter/material.dart';

class DetailWidget extends StatelessWidget {
  const DetailWidget({
    super.key,
    required this.inputTitle,
    required this.inputItem,
  });

  final String inputItem;
  final String inputTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            inputTitle,
            style: const TextStyle(
                fontFamily: "Poppins",
                fontSize: 28.0,
                fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(inputItem),
          )
        ],
      ),
    );
  }
}