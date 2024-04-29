import 'package:flutter/material.dart';

class NumBox extends StatefulWidget {
  const NumBox({super.key, this.initValue = 0, required this.callback});

  final int initValue;
  final void Function(int) callback;

  @override
  State<NumBox> createState() => _NumBox();
}

class _NumBox extends State<NumBox> {
  static const double fontSize = 32;
  static const double iconSize = 56;
  static const EdgeInsets btnPadding = EdgeInsets.fromLTRB(8, 4, 8, 4);

  int value = 0;

  @override
  void initState() {
    // By default, the value will be displayed.
    value = widget.initValue;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Decrement button
        Padding(
          padding: btnPadding,
          child: IconButton(
            onPressed: () {
              if (value > 0) {
                setState(() {
                  value--;
                });
                widget.callback(value);
              }
            },
            iconSize: iconSize,
            icon: const Icon(Icons.remove),
          ),
        ),

        // Display number
        Text(style: const TextStyle(fontSize: fontSize), value.toString()),

        // Increment button
        Padding(
          padding: btnPadding,
          child: IconButton(
            onPressed: () {
              setState(() {
                value++;
              });
              widget.callback(value);
            },
            iconSize: iconSize,
            icon: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
