import 'package:flutter/material.dart';

class NumBox extends StatefulWidget {
  NumBox({super.key, required this.callback});

  void Function(int) callback;

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
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
          child: IconButton(
            onPressed: () {
              if (value > 0) {
                setState(() {
                  value--;
                });
                widget.callback(value);
              }
            },
            icon: const Icon(Icons.remove),
          ),
        ),
        Text(style: const TextStyle(fontSize: 16), display),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: IconButton(
            onPressed: () {
              setState(() {
                value++;
              });
              widget.callback(value);
            },
            icon: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
