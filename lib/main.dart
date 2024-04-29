import 'package:flutter/material.dart';

import 'package:scouting_flutter/home.dart';
import 'package:scouting_flutter/auto_details.dart';
import 'package:scouting_flutter/teleop_details.dart';
import 'package:scouting_flutter/end_details.dart';
import 'package:scouting_flutter/sheets.dart';

void main() async {
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => MainState();
}

class MainState extends State<Main> {
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
                    // If at last page, attempt to submit scouting data
                    // Otherwise, increment page num
                    if (page == lastPage) {
                      try {
                        ScoutingSheet().submit(scoutData);

                        // Reset scoutData, but using the same scouter initials
                        scoutData = {
                          'scouter': scoutData['scouter'],
                        };

                        // Go back to first page
                        page = 0;
                      }
                      // If something went wrong submitting data, we'll retry
                      catch (err) {
                        retry = true;
                      }
                    }
                    // Otherwise, increment page num
                    else {
                      page++;
                    }
                  });
                },
                // If at last page, display "Submit"
                // If at first page, display "Scout"
                // Otherwise, display "Next"
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
