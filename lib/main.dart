import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scouting_flutter/numbox.dart';
import 'package:scouting_flutter/sheets.dart';

void main() async {
  //var team = await Tba().getTeam(4533);
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _Main();
}

class _Main extends State<Main> {
  static int page = 0;
  static int lastPage = 3;
  static bool retry = false;

  static Map<String, dynamic> scoutData = <String, dynamic>{};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phoenix Scouting v4',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      home: Scaffold(
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconButton(
                  onPressed: () {
                    if (page > 0) {
                      setState(() {
                        page--;
                      });
                    }
                  },
                  icon: const Icon(Icons.arrow_back)),
              TextButton(
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(36, 18, 36, 18),
                    textStyle: const TextStyle(fontSize: 18)),
                onPressed: () {
                  setState(() {
                    // If at last page, submit scouting data.
                    // Otherwise, increment page num.
                    if (page == lastPage) {
                      try {
                        ScoutingSheet().submit(scoutData);
                        scoutData = {
                          'scouter': scoutData['scouter'],
                        };
                        page = 0;
                      } catch (err) {
                        retry = true;
                      }
                    } else {
                      page++;
                    }
                  });
                },
                // If at last page, display "Submit".
                // If at first page, display "Scout".
                // Otherwise, display "Next".
                child: page == lastPage
                    ? retry
                        ? const Text(
                            'Something prolly went wrong with your wifi. Click to retry')
                        : const Text('Submit')
                    : page == 0
                        ? const Text('Scout')
                        : const Text('Next'),
              ),
            ])),
        body: Center(
          child: SizedBox(
            //height: 700,
            width: 420,
            child: Center(
                child: <Widget>[
              Home(callback: (map) {
                scoutData.addAll(map);
              }),
              AutoDetails(callback: (map) {
                scoutData.addAll(map);
              }),
              TeleopDetails(callback: (map) {
                scoutData.addAll(map);
              }),
              EndDetails(callback: (map) {
                scoutData.addAll(map);
              }),
            ][page]),
          ),
        ),
      ),
    );
  }
}

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
    speakerNotes = _Main.scoutData['autoSpeakerNotes'] ?? 0;
    ampNotes = _Main.scoutData['autoAmpNotes'] ?? 0;
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
    speakerNotes = _Main.scoutData['teleopSpeakerNotes'] ?? 0;
    ampNotes = _Main.scoutData['teleopAmpNotes'] ?? 0;
    ampedSpeakerNotes = _Main.scoutData['teleopAmpedSpeakerNotes'] ?? 0;
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
    comments = _Main.scoutData['comments'] ?? '';
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

    scouter = _Main.scoutData['scouter'] ?? '';
    teamNum = _Main.scoutData['teamNum'] ?? -1;
    matchType = _Main.scoutData['matchType'] ?? '';
    matchNum = _Main.scoutData['matchNum'] ?? -1;

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
