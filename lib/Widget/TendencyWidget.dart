import 'package:flutter/material.dart';

int policyValue = 0;
int agitation = 0;

class TendencyWidget extends StatelessWidget {
  final String content;

  const TendencyWidget({Key? key, required this.content}) : super(key: key);

  void _extractPolicyValue(String text) {
    final regExp = RegExp(r'중도\((\d+)\)');
    final match = regExp.firstMatch(text);
    if (match != null) {
      print("Match found for policy: ${match.group(1)}");
      policyValue = int.parse(match.group(1)!);
    } else {
      print("No match found for policy value.");
      policyValue = 0;
    }
  }

  int _extractAgitationValue(String text) {
    final regExp = RegExp(r'agitation:\s*(\d+)');
    final match = regExp.firstMatch(text);
    if (match != null) {
      print("Match found for agitation: ${match.group(1)}");
      return int.parse(match.group(1)!);
    }
    return 0;
  }

  List _getPolicyIcon(int policyValue) {
    if (policyValue == 0) return [Icons.shield, "보수적"];
    if (policyValue == 1) return [Icons.balance, "중도"];
    if (policyValue == 2) return [Icons.handyman, "진보적"];
    return [Icons.warning_amber, "문제가 발생했습니다."];
  }

  List _getAgitationIcon(int agitationValue) {
    if (agitationValue == 5) return [Icons.flag_rounded, Colors.teal, "낮은 선동성"];
    if (agitationValue == 6) return [Icons.flag_rounded, Colors.indigo, "약한 선동성"];
    if (agitationValue == 7) return [Icons.flag_sharp, Colors.orange, "보통 선동성"];
    if (agitationValue == 8) return [Icons.flag_rounded, Colors.red, "다분히 선동적"];
    if (agitationValue == 9) return [Icons.warning, Colors.red, "심히 선동적"];
    return [Icons.help_outline, Colors.black, "문제가 발생했습니다."];
  }

  @override
  Widget build(BuildContext context) {
    _extractPolicyValue(content);
    final agitationValue = _extractAgitationValue(content);

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
