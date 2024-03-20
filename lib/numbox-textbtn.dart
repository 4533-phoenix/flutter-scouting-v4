import 'package:flutter/material.dart';

class NumBox extends StatefulWidget {
  NumBox({super.key});

  @override
  State<NumBox> createState() => _NumBox();
}

class _NumBox extends State<NumBox> {
  int value = -1;

  @override
  Widget build(BuildContext context) {
    // By default, the value will be displayed.
    String display = value.toString();

    // If the value is less than 0 (i.e. is -1), display a dash instead.
    if (value < 0) {
      display = "-";
    }

    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: TextButton(
            onPressed: () {
              if (value > 0) {
                setState(() {
                  value--;
                });
              }
            },
            style: TextButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.blue),
            child: const Text(style: TextStyle(fontSize: 16), '-'),
          ),
        ),
        Text(style: const TextStyle(fontSize: 16), display),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: TextButton(
            onPressed: () {
              setState(() {
                value++;
              });
            },
            style: TextButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.blue),
            child: const Text(style: TextStyle(fontSize: 16), '+'),
          ),
        ),
      ],
    );
  }
}
