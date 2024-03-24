import 'package:tba_api_v3/tba_api_v3.dart';
import 'package:dio/dio.dart';

class Tba {
  final Dio dio = Dio(BaseOptions(
    headers: <String, String>{
      'X-TBA-Auth-Key':
          'cmz9aASLNBgWLR8Rn2rfoLNhCb15zEoj4rwdh0sjBsJTu4JipnVshp1XmPxUYDle'
    },
    baseUrl: 'https://www.thebluealliance.com/api/v3',
  ));

  TbaApiV3? api;

  Tba() {
    api = TbaApiV3(dio: dio, serializers: standardSerializers);
  }

  Future<Team> getTeam(int teamNum) async {
    var team = await api!.getTeamApi().getTeam(teamKey: 'frc$teamNum');
    return team.data!;
  }
/*
	Future<void> getMatches(String eventId) async {
    var matches = await api!.getEventApi().getEventMatches(eventKey: eventId);
    for (Match match in matches.data!) {
      var key = match.key;
			var redTeams = match.alliances!.red!.teamKeys.map((text) => text.replaceFirst('frc', '').toString());
			var blueTeams = match.alliances!.blue!.teamKeys.map((text) => text.replaceFirst('frc', '').toString());
			print(match.scoreBreakdown.toString());
      print('$key => $redTeams / $blueTeams');
			for (String redt in redTeams) {
				print('>$redt');
			}
    }
  }
	*/

  Future<void> getMatches(String eventId) async {
    var matches = await api!.getEventApi().getEventMatches(eventKey: eventId);
    for (Match match in matches.data!) {
      var key = match.key;
      var redTeams = match.alliances!.red!.teamKeys
          .map((text) => text.replaceFirst('frc', '').toString());
      var blueTeams = match.alliances!.blue!.teamKeys
          .map((text) => text.replaceFirst('frc', '').toString());
      match.scoreBreakdown!;
    }
  }
}
