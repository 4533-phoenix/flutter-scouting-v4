import 'package:flutter/material.dart';
import 'package:scouting_flutter/numbox.dart';
import 'package:scouting_flutter/main.dart';

class AutoDetails extends StatefulWidget {
  const AutoDetails({super.key, required this.callback});

  final void Function(Map<String, int>) callback;

  @override
  State<AutoDetails> createState() => _AutoDetails();
}

class _AutoDetails extends State<AutoDetails> {
  int speakerNotes = 0;
  int ampNotes = 0;

  @override
  void initState() {
    speakerNotes = MainState.scoutData['autoSpeakerNotes'] ?? 0;
    ampNotes = MainState.scoutData['autoAmpNotes'] ?? 0;
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    widget.callback({
      'autoSpeakerNotes': speakerNotes,
      'autoAmpNotes': ampNotes,
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
                'Autonomous')),
        Center(
            child: Column(children: [
          const Text('Speaker notes'),
          NumBox(
              initValue: speakerNotes,
              callback: (int val) {
                setState(() {
                  speakerNotes = val;
                });
              }),
        ])),
        Center(
            child: Column(children: [
          const Text('Amp notes'),
          NumBox(
              initValue: ampNotes,
              callback: (int val) {
                setState(() {
                  ampNotes = val;
                });
              }),
        ])),
      ],
    );
  }
}
