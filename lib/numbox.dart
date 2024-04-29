import 'package:flutter/material.dart';

class NumBox extends StatefulWidget {
  NumBox({super.key, this.value = 0, required this.callback});

  int value = 0;
  void Function(int) callback;

  @override
  State<NumBox> createState() => _NumBox();
}

class _NumBox extends State<NumBox> {
  static const double fontSize = 32;
  static const double iconSize = 56;
  static const EdgeInsets btnPadding = EdgeInsets.fromLTRB(8, 4, 8, 4);

  @override
  Widget build(BuildContext context) {
    // By default, the value will be displayed.
    String display = widget.value.toString();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Decrement button
        Padding(
          padding: btnPadding,
          child: IconButton(
            onPressed: () {
              if (widget.value > 0) {
                setState(() {
                  widget.value--;
                });
                widget.callback(widget.value);
              }
            },
            iconSize: iconSize,
            icon: const Icon(Icons.remove),
          ),
        ),

        // Display number
        Text(style: const TextStyle(fontSize: fontSize), display),

        // Increment button
        Padding(
          padding: btnPadding,
          child: IconButton(
            onPressed: () {
              setState(() {
                widget.value++;
              });
              widget.callback(widget.value);
            },
            iconSize: iconSize,
            icon: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
