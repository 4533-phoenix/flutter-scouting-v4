import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scouting_flutter/main.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.callback});

  final void Function(Map<String, dynamic>) callback;

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  int teamNum = -1;
  String matchType = '';
  int matchNum = -1;
  String scouter = '';

  TextEditingController teamNumEdCtrl = TextEditingController(text: '');
  TextEditingController matchNumEdCtrl = TextEditingController(text: '');
  TextEditingController scouterEdCtrl = TextEditingController(text: '');

  late FocusNode teamNumFocus;
  late FocusNode matchNumFocus;
  late FocusNode scouterFocus;

  @override
  void initState() {
    super.initState();

    scouter = MainState.scoutData['scouter'] ?? '';
    teamNum = MainState.scoutData['teamNum'] ?? -1;
    matchType = MainState.scoutData['matchType'] ?? '';
    matchNum = MainState.scoutData['matchNum'] ?? -1;

    scouterEdCtrl.text = scouter;

    if (teamNum != -1) {
      teamNumEdCtrl.text = teamNum.toString();
    }

    if (matchNum != -1) {
      matchNumEdCtrl.text = matchNum.toString();
    }

    teamNumFocus = FocusNode();
    matchNumFocus = FocusNode();
    scouterFocus = FocusNode();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    widget.callback({
      'scouter': scouter,
      'teamNum': teamNum,
      'matchType': matchType,
      'matchNum': matchNum,
    });
  }

  @override
  void dispose() {
    teamNumFocus.dispose();
    matchNumFocus.dispose();
    scouterFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
                style: TextStyle(
                  fontSize: 24.0,
                ),
                'Scouting v4')),
        const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: DropdownMenu(
              label: Text('Event'),
              initialSelection: 'scchs2024',
              dropdownMenuEntries: [
                DropdownMenuEntry(value: 'scchs2024', label: 'PCH DCMP'),
              ],
            )),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DropdownMenu(
                width: 180,
                label: const Text('Match type'),
                initialSelection: matchType,
                onSelected: (val) {
                  setState(() {
                    matchType = val!;
                  });
                  matchNumFocus.requestFocus();
                },
                dropdownMenuEntries: const [
                  DropdownMenuEntry(value: 'Practice', label: 'Practice'),
                  DropdownMenuEntry(
                      value: 'Qualification', label: 'Qualification'),
                  DropdownMenuEntry(value: 'Semi-final', label: 'Semi-final'),
                  DropdownMenuEntry(value: 'Final', label: 'Final'),
                ],
              ),
              SizedBox(
                  width: 100,
                  child: TextField(
                    focusNode: matchNumFocus,
                    controller: matchNumEdCtrl,
                    onChanged: (text) {
                      setState(() {
                        matchNum = int.tryParse(text) ?? -1;
                      });
                    },
                    onSubmitted: (_) {
                      teamNumFocus.requestFocus();
                    },
                    decoration: const InputDecoration(label: Text('Match num')),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  )),
            ]),
        SizedBox(
            width: 200,
            child: TextField(
              focusNode: teamNumFocus,
              controller: teamNumEdCtrl,
              onChanged: (text) {
                setState(() {
                  teamNum = int.tryParse(text) ?? -1;
                });
              },
              onSubmitted: (_) {
                scouterFocus.requestFocus();
              },
              decoration: const InputDecoration(label: Text('Team num')),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            )),
        SizedBox(
            width: 200,
            child: TextField(
              focusNode: scouterFocus,
              controller: scouterEdCtrl,
              inputFormatters: [
                TextInputFormatter.withFunction(
                    (oldValue, newValue) => TextEditingValue(
                          text: newValue.text.toUpperCase(),
                          selection: newValue.selection,
                        )),
              ],
              onChanged: (text) {
                setState(() {
                  scouter = scouterEdCtrl.text;
                });
              },
              decoration: const InputDecoration(label: Text('Initials')),
            )),
      ],
    );
  }
}
