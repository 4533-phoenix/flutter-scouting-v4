import 'dart:convert';
import 'dart:io' show Platform;

import 'package:gsheets/gsheets.dart';
import 'package:scouting_flutter/main.dart';

const credsJson = String.fromEnvironment('GOOGLE_API_KEY', defaultValue: '{}');

const sheetId = '10qG0P9vYwTufODa_nN8c-zj3AMaf11B7eZUReINfdpQ';

class ScoutingSheet {
  late Worksheet ws;

  void submit(
    Map<String, dynamic> data) async {
    Map<String, dynamic> sheetsData = {
      'Team Number': data['teamNum'],
      'Scouter': data['scouter'],
      'Match Type': data['matchType'],
      'Match Number': data['matchNum'],
      'Auto Amp Notes': data['autoAmpNotes'],
      'Auto Speaker Notes': data['autoSpeakerNotes'],
      'Amp Notes': data['teleopAmpNotes'],
      'Speaker Notes': data['teleopSpeakerNotes'],
      'Amped Speaker Notes': data['teleopAmpedSpeakerNotes'],
      'Comments': data['comments'],
    };

    final gsheets = GSheets(credsJson);
    final s = await gsheets.spreadsheet(sheetId);

    var ws = s.worksheetByTitle('Scouting App Data');
    ws ??= await s.addWorksheet('Scouting App Data');

    await ws.values.map.appendRow(sheetsData);

    await gsheets.close();
  }

  void getTbaData() async {
    final gsheets = GSheets(credsJson);
    final s = await gsheets.spreadsheet(sheetId);

    var ws = s.worksheetByTitle('Scouting App Data')!;

    var rows = await ws.values.map.allRows();
    for (Map<String, String> row in rows!) {
      var teamNum = row['Team Number'];
      var matchNum = row['Match Number'];
      print(
          '$teamNum - <https://thebluealliance.com/match/2024sccha_qm$matchNum>');
    }
  }
}
