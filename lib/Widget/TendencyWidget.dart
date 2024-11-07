import 'package:flutter/material.dart';

class TendencyWidget extends StatelessWidget {
  final String content;

  const TendencyWidget({Key? key, required this.content}) : super(key: key);

  Map<String, int> _extractValues(String text) {
    final regExp = RegExp(r'(\w+):\s*(-?\d+)');
    Map<String, int> values = {};

    for (var match in regExp.allMatches(text)) {
      final tag = match.group(1)!;
      final value = int.parse(match.group(2)!);
      values[tag] = value;
    }

    return values;
  }

  List _getPolicyIcon(int value) {
    if (value == 0) return [Icons.shield, "보수적"];
    if (value == 1) return [Icons.balance, "중도"];
    if (value == 2) return [Icons.handyman, "진보적"];
    return [Icons.warning_amber, "문제가 발생했습니다."];
  }

  List _getAgitationIcon(int value) {
    if (value == 5) return [Icons.flag_rounded, Colors.teal, "낮은 선동성"];
    if (value == 6) return [Icons.flag_rounded, Colors.indigo, "약한 선동성"];
    if (value == 7) return [Icons.flag_sharp, Colors.orange, "보통 선동성"];
    if (value == 8) return [Icons.flag_rounded, Colors.red, "다분히 선동적"];
    if (value == 9) return [Icons.warning, Colors.red, "심히 선동적"];
    return [Icons.help_outline, Colors.black, "문제가 발생했습니다."];
  }

  @override
  Widget build(BuildContext context) {
    final values = _extractValues(content);
    final policyValue = values['policy'] ?? 0;
    final agitationValue = values['agitation'] ?? 0;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Tendency",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: Column(
                  children: [
                    Icon(_getPolicyIcon(policyValue)[0], size: 30),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        _getPolicyIcon(policyValue)[1],
                        style: const TextStyle(
                            fontFamily: "Poppins", fontSize: 20.0),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    Icon(
                      _getAgitationIcon(agitationValue)[0],
                      color: _getAgitationIcon(agitationValue)[1],
                      size: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        _getAgitationIcon(agitationValue)[2],
                        style: const TextStyle(
                            fontFamily: "Poppins", fontSize: 20.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}