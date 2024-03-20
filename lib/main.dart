import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scouting_flutter/numbox.dart';
import 'package:scouting_flutter/sheets.dart';
import 'package:scouting_flutter/tba.dart';

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
  static int page     = 0;
	static int lastPage = 3;
	static bool retry = false;

  Home          home          = Home();
  AutoDetails   autoDetails   = AutoDetails();
	TeleopDetails teleopDetails = TeleopDetails();
	EndDetails    endDetails    = EndDetails();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phoenix Scouting v4',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      home: Scaffold(
        bottomNavigationBar: Padding(padding: const EdgeInsets.all(8), child: TextButton(
          style: TextButton.styleFrom(padding: const EdgeInsets.all(18.0)),
          onPressed: () {
            setState(() {
							// If at last page, submit scouting data.
							// Otherwise, increment page num.
              if (page == lastPage) {
								try {
	                ScoutingSheet()
                    .submit(home, autoDetails, teleopDetails, endDetails);
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
              ? retry ? const Text('Something prolly went wrong with your wifi. Click to retry') : const Text('Submit')
              : page == 0
                  ? const Text('Scout')
                  : const Text('Next'),
        )),
        body: Center(
          child: SizedBox(
            //height: 700,
            width: 200,
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
          NumBox(callback: (int val) {
            widget.speakerNotes = val;
          }),
        ])),
        Center(
            child: Column(children: [
          const Text('Amp notes'),
          NumBox(callback: (int val) {
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
          NumBox(callback: (int val) {
            widget.speakerNotes = val;
          }),
        ])),
        Center(
            child: Column(children: [
          const Text('Amp notes'),
          NumBox(callback: (int val) {
            widget.ampNotes = val;
          }),
        ])),
				Center(
					child: Column(children: [
					const Text('Amped speaker notes'),
					NumBox(callback: (int val) {
						widget.ampedSpeakerNotes = val;
					}),
					])
				),
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


/*
class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _Main();
}

class _Main extends State<Main> {
	int page = 0;
  TextEditingController _scouter = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                    'Scouting v4'
								)
						),
          ],
        ),
      ),
    );
  }
}


class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _Main();
}

class _Main extends State<Main> {
	int page = 0;
  TextEditingController _scouter = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                    'Scouting v4'
								)
						),
          ],
        ),
      ),
    );
  }
}
*/

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

  @override
  Widget build(BuildContext context) {
    widget.teamNum = 123;
		scouter.text = widget.scouter;

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
        const Padding(padding: EdgeInsets.only(bottom: 16), child: DropdownMenu(
          label: Text('Event'),
          initialSelection: 'scchs2024',
          dropdownMenuEntries: [
            //DropdownMenuEntry(value: 'scriw2023', label: 'SCRIW 2023'),
            DropdownMenuEntry(value: 'scchs2024', label: 'CHARLESTON'),
          ],
        )),
        DropdownMenu(
          label: const Text('Match type'),
					onSelected: (val) {
						widget.matchType = val!;
					},
          dropdownMenuEntries: const [
            //DropdownMenuEntry(value: 'scriw2023', label: 'SCRIW 2023'),
            DropdownMenuEntry(value: 'Qualification', label: 'Qualification'),
            DropdownMenuEntry(value: 'Semi-final', label: 'Semi-final'),
            DropdownMenuEntry(value: 'Final', label: 'Final'),
          ],
        ),
        SizedBox(
            width: 200,
            child: TextField(
              onChanged: (text) {
                widget.matchNum = int.tryParse(text) ?? -1;
              },
              decoration: const InputDecoration(label: Text('Match number')),
							keyboardType: TextInputType.number,
							inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            )),
        SizedBox(
            width: 200,
            child: TextField(
              controller: scouter,
              onSubmitted: (text) {
                scouter.text = text.toUpperCase();
                widget.scouter = scouter.text;
              },
              decoration: const InputDecoration(label: Text('Initials')),
            )),
      ],
    );
  }
}
