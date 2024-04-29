import 'package:flutter/material.dart';
import 'package:scouting_flutter/numbox.dart';
import 'package:scouting_flutter/main.dart';

class TeleopDetails extends StatefulWidget {
  const TeleopDetails({super.key, required this.callback});

  final void Function(Map<String, int>) callback;

  @override
  State<TeleopDetails> createState() => _TeleopDetails();
}

class _TeleopDetails extends State<TeleopDetails> {
  int speakerNotes = 0;
  int ampNotes = 0;
  int ampedSpeakerNotes = 0;

  @override
  void initState() {
    // Pull stuff from scoutData if it's there
    speakerNotes = MainState.scoutData['teleopSpeakerNotes'] ?? 0;
    ampNotes = MainState.scoutData['teleopAmpNotes'] ?? 0;
    ampedSpeakerNotes = MainState.scoutData['teleopAmpedSpeakerNotes'] ?? 0;
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    widget.callback({
      'teleopSpeakerNotes': speakerNotes,
      'teleopAmpNotes': ampNotes,
      'teleopAmpedSpeakerNotes': ampedSpeakerNotes,
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
                'Teleop')),
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
        Center(
            child: Column(children: [
          const Text('Amped speaker notes'),
          NumBox(
              initValue: ampedSpeakerNotes,
              callback: (int val) {
                setState(() {
                  ampedSpeakerNotes = val;
                });
              }),
        ])),
      ],
    );
  }
}
