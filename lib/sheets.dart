import 'package:gsheets/gsheets.dart';
import 'package:scouting_flutter/main.dart';

const credsJson = String.fromEnvironment('GOOGLE_API_KEY');

const sheetId = '1-Fx_cTEu2BXyJ6MwoB4Y2na-cALNYteOrBl4WmIAQ64';

class ScoutingSheet {
  late Worksheet ws;

  void submit(
      Home home, AutoDetails auto, TeleopDetails teleop, EndDetails end) async {
    final gsheets = GSheets(credsJson);
    final s = await gsheets.spreadsheet(sheetId);

    var ws = s.worksheetByTitle('Scouting App Data');
    ws ??= await s.addWorksheet('Scouting App Data');

    await ws.values.map.appendRow({
      'Team Number': home.teamNum,
      'Scouter': home.scouter,
      'Match Type': home.matchType,
      'Match Number': home.matchNum,
      'Auto Amp Notes': auto.ampNotes,
      'Auto Speaker Notes': auto.speakerNotes,
      'Amp Notes': teleop.ampNotes,
      'Speaker Notes': teleop.speakerNotes,
      'Amped Speaker Notes': teleop.ampedSpeakerNotes,
      'Comments': end.comments,
    });

    await gsheets.close();
  }
}
