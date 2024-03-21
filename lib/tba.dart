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
}
