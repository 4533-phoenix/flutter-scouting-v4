import 'package:gsheets/gsheets.dart';
import 'package:scouting_flutter/main.dart';

const credsJson = r'''
{
    "type": "service_account",
    "project_id": "frc-scouting-app-381605",
    "private_key_id": "9612598734d6a2adde2a0e070035f96cd884a4c4",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCmKO7jB+uDzJxh\ne6sfD72OecBdanf3M1hkzdweZZt1AiYvJNs+N+IJn9C56C5RVz+0U3L9KGLD2Kv5\nKED9rmGdDm+AEdp8ZXUs2PvBkOd1LgiJUwsMxqBs1yD/G1UWwpg0pVPO/VvQX1dD\nc+jMqZLsTAizwR1NkRdzCzanTj+uRMy9cpafNiO7tooSvc6d7d0EG7+eck1Sxymv\n6VLYtNMQOmXGskh+NlsgDknj0+OL3g/SgUFUhuMtfc0+z9YyTDtT2bNjUkiUG688\nHOUt74hJ1oO5WJi5A8sRAfsjYni2ogRNjyni7C+Flh1QdkazixO2TKz/YSmbAHwZ\ntv66IrPVAgMBAAECggEABX2pXiKzuSPYsEAAP6erOIRiDLQ7bhWOks9auj1IMm2s\nUxKBTEB8ggl7r7tWw1umwGtYZyeNW/t3TtNgACarFWkDka/gx1S8IEK0hfa5nRSQ\nWoKHcvN9ZRtf/OmZK/PySEHy9DL/vbsNaFLx9n8oo8itKhXPoPG3E4UH6niaW0Rx\nnKSC8iXiRnRHXNujMSqMB2K8Q+WsNFciifQ3Bmhfu8Zhnc6c+qAuqKZ90/uEC4p7\nHsRSY8f/s28hd6jEYJGLlSnieI0L4P69mPByo5i2pNWe+H7AAe/G0fo0YLEpQ63n\nhuBSaIy+8cKmlvaJSnlHCECNijn8aoPclQGRU7LNAQKBgQDoCFLstr+aKDZhF1TD\nxRj42IX3AFV1xlDw7t5gwh+jE/9JdQRkzyLZ2SRq1uYzfrMjO8MbY0zrzQRC6lJn\ngnK3uxjLMDvV4b8y5ObNArBrAAdlvmTVwMswsBuhbAWMtEbewX5W2S5odkSvkFnq\nUxyW9pEQUWaw8Y7s6U0gt4rZXQKBgQC3UrpkoQlD5WcFUYPI5PyreSOatnhsLrff\nvA56OLJzt2vqyRLhGxSRqOwT2W887d2KGBeT5TDoprnOJ4KhDbbYUS8M7U1P8Hbc\nKLNOrGdglX87pzG1pj7c6CQloiyZB9ulUdvZ9bZoRDiHxIDW69BAUSQqEByKO3IS\nQt6mIocE2QKBgGYyLFvoDbHXHkRbI1FqgRoxO6fTtNA/vayweK+DMK4CA8GV0Y6Z\nEM+EbR7FcfSiTEIrcz6f2OROkx7p18uRT/eOZ1gu8Vu9pxnCaclH8u3dwGRWnFDt\nLlFOb40EZ9lWGZTJAl08IM2Psabl3ERxwLjY9oGKaMFsUzgTdY4AaR5dAoGBAItE\n8g2YuW03TfigYLmyHLI4KXBTx1CIfXAfcfAwOoHmirmnYAxbgljWN+MsgHGNU4yh\nmOfmai2U2/td0MOBo7Lamh/794wPZn0C/pV6LF8Xs70h24Xgckloom1ksvTfH2KM\nubTwEk9L5JZgFnEwXNk/y3WZH9V0K8jrvDICcQihAoGAZ6Bu+JELDxTLZozCAwaG\n7btzeG+29jfzWefQ8WfyxzM1tlB3F6PrX4yCi7FEqf8PHNn8TNDbHEB1QtwzPjCw\naq+/Cr9mgam+h7cm7oFgYMjPpw2VJ5nE2FSAcB4uWP564QdwVgdCxQKaUojRNXb+\n0VCqqhelz/lKcBpWuE04QUA=\n-----END PRIVATE KEY-----\n",
    "client_email": "app-updater@frc-scouting-app-381605.iam.gserviceaccount.com",
    "client_id": "104249311345232104939",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/app-updater%40frc-scouting-app-381605.iam.gserviceaccount.com"
}
''';

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
