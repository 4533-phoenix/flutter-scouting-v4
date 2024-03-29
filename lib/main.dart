import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scouting_flutter/numbox.dart';
import 'package:scouting_flutter/sheets.dart';
import 'package:scouting_flutter/tba.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  static Home home = Home();
  static AutoDetails autoDetails = AutoDetails();
  static TeleopDetails teleopDetails = TeleopDetails();
  static EndDetails endDetails = EndDetails();

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
                        ScoutingSheet().submit(
                            home, autoDetails, teleopDetails, endDetails);
                        home = Home(scouter: home.scouter);
                        autoDetails = AutoDetails();
                        teleopDetails = TeleopDetails();
                        endDetails = EndDetails();
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
              home,
              autoDetails,
              teleopDetails,
              endDetails,
            ][page]),
          ),
        ),
      ),
    );
  }
}

class AutoDetails extends StatefulWidget {
  AutoDetails({super.key});

  int speakerNotes = -1;
  int ampNotes = -1;

  @override
  State<AutoDetails> createState() => _AutoDetails();
}

class _AutoDetails extends State<AutoDetails> {
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
              value: widget.speakerNotes,
              callback: (int val) {
                widget.speakerNotes = val;
              }),
        ])),
        Center(
            child: Column(children: [
          const Text('Amp notes'),
          NumBox(
              value: widget.ampNotes,
              callback: (int val) {
                widget.ampNotes = val;
              }),
        ])),
        /*
        ListTile(
          title: const Text('Leave'),
          leading: Checkbox(
              value: leave,
              onChanged: (val) {
                setState(() {
                  leave = val!;
                });
              }),
        ),
				*/
      ],
    );
  }
}

class TeleopDetails extends StatefulWidget {
  TeleopDetails({super.key});

  int speakerNotes = -1;
  int ampNotes = -1;
  int ampedSpeakerNotes = -1;

  @override
  State<TeleopDetails> createState() => _TeleopDetails();
}

class _TeleopDetails extends State<TeleopDetails> {
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
              value: widget.speakerNotes,
              callback: (int val) {
                widget.speakerNotes = val;
              }),
        ])),
        Center(
            child: Column(children: [
          const Text('Amp notes'),
          NumBox(
              value: widget.ampNotes,
              callback: (int val) {
                widget.ampNotes = val;
              }),
        ])),
        Center(
            child: Column(children: [
          const Text('Amped speaker notes'),
          NumBox(
              value: widget.ampedSpeakerNotes,
              callback: (int val) {
                widget.ampedSpeakerNotes = val;
              }),
        ])),
      ],
    );
  }
}

class EndDetails extends StatefulWidget {
  EndDetails({super.key});

  String comments = '';

  @override
  State<EndDetails> createState() => _EndDetails();
}

class _EndDetails extends State<EndDetails> {
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
              widget.comments = val;
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
  Home({super.key, this.scouter = ''});

  int teamNum = -1;
  String matchType = '';
  int matchNum = -1;
  String scouter = '';

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  TextEditingController teamNum = TextEditingController(text: '');
  TextEditingController matchNum = TextEditingController(text: '');
  TextEditingController scouter = TextEditingController(text: '');

  late FocusNode teamNumFocus;
  late FocusNode matchNumFocus;
  late FocusNode scouterFocus;

	//Future<SharedPreferences> db = SharedPreferences.getInstance();
	SharedPreferences? db;
	VoidCallback? onSubmitLocal;

	void initDb() {
		Timer.run(() async {
			db = await SharedPreferences.getInstance().whenComplete(() => null);
		});
	}

  @override
  void initState() {
    super.initState();

    scouter.text = widget.scouter;

    if (widget.teamNum != -1) {
      teamNum.text = widget.teamNum.toString();
    }

    if (widget.matchNum != -1) {
      matchNum.text = widget.matchNum.toString();
    }

    teamNumFocus = FocusNode();
    matchNumFocus = FocusNode();
    scouterFocus = FocusNode();

		initDb();
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
		Timer.run(() async {
		if (db != null) {
			if (db!.containsKey('matches')) {
				setState(() {
					onSubmitLocal = () {
						setState(() {
							onSubmitLocal = null;
						});
						ScoutingSheet().submitLocal();
					};
				});
			} else {
				setState(() {
					onSubmitLocal = null;
				});
			}
		}
		});

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
                DropdownMenuEntry(value: 'scchs2024', label: 'CHARLESTON'),
              ],
            )),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DropdownMenu(
                width: 180,
                label: const Text('Match type'),
                initialSelection: widget.matchType,
                onSelected: (val) {
                  widget.matchType = val!;
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
                    controller: matchNum,
                    onChanged: (text) {
                      widget.matchNum = int.tryParse(text) ?? -1;
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
              controller: teamNum,
              onChanged: (text) {
                widget.teamNum = int.tryParse(text) ?? -1;
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
              controller: scouter,
              inputFormatters: [
                TextInputFormatter.withFunction(
                    (oldValue, newValue) => TextEditingValue(
                          text: newValue.text.toUpperCase(),
                          selection: newValue.selection,
                        )),
              ],
              onChanged: (text) {
                widget.scouter = scouter.text;
              },
              decoration: const InputDecoration(label: Text('Initials')),
            )),
				SizedBox(
				width: 200,
				height: 50,
				child: Padding(padding: const EdgeInsets.only(top: 8), child: TextButton(
					onPressed: onSubmitLocal,
					child: const Text('Submit local data'),
					)),
				),
      ],
    );
  }
}
