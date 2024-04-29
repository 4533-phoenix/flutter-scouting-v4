import 'package:flutter/material.dart';
import 'package:scouting_flutter/main.dart';

class EndDetails extends StatefulWidget {
  const EndDetails({super.key, required this.callback});

  final void Function(Map<String, dynamic>) callback;

  @override
  State<EndDetails> createState() => _EndDetails();
}

class _EndDetails extends State<EndDetails> {
  String comments = '';

  @override
  void initState() {
    comments = MainState.scoutData['comments'] ?? '';
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    widget.callback({
      'comments': comments,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
                style: TextStyle(
                  fontSize: 24.0,
                ),
                'End')),
        Center(
            child: Column(children: [
          TextField(
            onChanged: (val) {
              setState(() {
                comments = val;
              });
            },
            minLines: 3,
            maxLines: 5,
            decoration: const InputDecoration(labelText: 'Comments'),
          ),
        ])),
      ],
    );
  }
}
