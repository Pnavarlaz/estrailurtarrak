import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:estrailurtarrak/infrastructure/models/get_event_participants_model.dart';
import 'package:estrailurtarrak/presentation/providers/user_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

final String baseUrl = 'http://192.168.1.137:5000/';
final String eventuser = 'eventuser';
final String events = 'events';

class GetEventParticipantsAnswer extends ChangeNotifier {
  final _dio = Dio();
  final ScrollController chatScrollController = ScrollController();
  final UserProvider userProvider = UserProvider();

  Future<void> getEventParticipants(int eventID) async {
    final response = await _dio
        .get(baseUrl + eventuser, queryParameters: {"eventID": eventID});
    final getEventParticipant = GetEventParticipants.fromJson(response.data);
    userProvider.updateUsers(getEventParticipant);
    notifyListeners();
  }
}

List<GetEvents> getEventsFromJson(String str) =>
    List<GetEvents>.from(json.decode(str).map((x) => GetEvents.fromJson(x)));

String getEventsToJson(List<GetEvents> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetEvents {
    final DateTime colEkitaldiData;
    final String colEkitaldiIzena;
    final String colEkitaldiKokalekua;
    final int colEkitaldiMota;
    final String colEkitaldiOrdua;
    final int colEventId;

    GetEvents({
        required this.colEkitaldiData,
        required this.colEkitaldiIzena,
        required this.colEkitaldiKokalekua,
        required this.colEkitaldiMota,
        required this.colEkitaldiOrdua,
        required this.colEventId,
    });

    factory GetEvents.fromJson(Map<String, dynamic> json) => GetEvents(
        colEkitaldiData: DateTime.parse(json["col_ekitaldi_data"]),
        colEkitaldiIzena: json["col_ekitaldi_izena"],
        colEkitaldiKokalekua: json["col_ekitaldi_kokalekua"],
        colEkitaldiMota: json["col_ekitaldi_mota"],
        colEkitaldiOrdua: json["col_ekitaldi_ordua"],
        colEventId: json["col_eventID"],
    );

    Map<String, dynamic> toJson() => {
        "col_ekitaldi_data": "${colEkitaldiData.year.toString().padLeft(4, '0')}-${colEkitaldiData.month.toString().padLeft(2, '0')}-${colEkitaldiData.day.toString().padLeft(2, '0')}",
        "col_ekitaldi_izena": colEkitaldiIzena,
        "col_ekitaldi_kokalekua": colEkitaldiKokalekua,
        "col_ekitaldi_mota": colEkitaldiMota,
        "col_ekitaldi_ordua": colEkitaldiOrdua,
        "col_eventID": colEventId,
    };

}



class ApiService {
  Future<List<GetEvents>?> getEvents() async {
    try {
      var url = Uri.parse(baseUrl + events);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<GetEvents> _model = getEventsFromJson(response.body);
        return _model;
      }
    } catch (e) {
      
    }
    return null;
  }
}
