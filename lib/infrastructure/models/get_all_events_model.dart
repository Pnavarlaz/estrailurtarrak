// To parse this JSON data, do
//
//     final getAllEvents = getAllEventsFromJson(jsonString);

import 'dart:convert';

List<GetAllEvents> getAllEventsFromJson(String str) => List<GetAllEvents>.from(json.decode(str).map((x) => GetAllEvents.fromJson(x)));

String getAllEventsToJson(List<GetAllEvents> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllEvents {
    final String colEkitaldiData;
    final String colEkitaldiIzena;
    final String colEkitaldiKokalekua;
    final String colEkitaldiOrdua;
    final int colEventId;

    GetAllEvents({
        required this.colEkitaldiData,
        required this.colEkitaldiIzena,
        required this.colEkitaldiKokalekua,
        required this.colEkitaldiOrdua,
        required this.colEventId,
    });

    factory GetAllEvents.fromJson(Map<String, dynamic> json) => GetAllEvents(
        colEkitaldiData: json["col_ekitaldi_data"],
        colEkitaldiIzena: json["col_ekitaldi_izena"],
        colEkitaldiKokalekua: json["col_ekitaldi_kokalekua"],
        colEkitaldiOrdua: json["col_ekitaldi_ordua"],
        colEventId: json["col_eventID"],
    );

    Map<String, dynamic> toJson() => {
        "col_ekitaldi_data": colEkitaldiData,
        "col_ekitaldi_izena": colEkitaldiIzena,
        "col_ekitaldi_kokalekua": colEkitaldiKokalekua,
        "col_ekitaldi_ordua": colEkitaldiOrdua,
        "col_eventID": colEventId,
    };
}