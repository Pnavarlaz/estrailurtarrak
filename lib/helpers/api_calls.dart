import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:estrailurtarrak/infrastructure/models/get_event_participants_model.dart';
import 'package:estrailurtarrak/presentation/providers/screens/event/event_details.dart';
import 'package:estrailurtarrak/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final String baseUrl = 'http://192.168.1.137:5000/';
final String user = 'user';
final String users = 'users';
final String eventuser = 'eventuser';
final String events = 'events';
final String event = 'event';

class GetEventParticipantsAnswer extends ChangeNotifier {
  final ScrollController chatScrollController = ScrollController();
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
        "col_ekitaldi_data":
            "${colEkitaldiData.year.toString().padLeft(4, '0')}-${colEkitaldiData.month.toString().padLeft(2, '0')}-${colEkitaldiData.day.toString().padLeft(2, '0')}",
        "col_ekitaldi_izena": colEkitaldiIzena,
        "col_ekitaldi_kokalekua": colEkitaldiKokalekua,
        "col_ekitaldi_mota": colEkitaldiMota,
        "col_ekitaldi_ordua": colEkitaldiOrdua,
        "col_eventID": colEventId,
      };
}

List<GetUsers> getUsersFromJson(String str) =>
    List<GetUsers>.from(json.decode(str).map((x) => GetUsers.fromJson(x)));

String getUsersToJson(List<GetUsers> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetUsers {
  final String colErabiltzaileAbizena;
  final String colErabiltzaileIzena;
  final int colUserId;

  GetUsers({
    required this.colErabiltzaileAbizena,
    required this.colErabiltzaileIzena,
    required this.colUserId,
  });

  factory GetUsers.fromJson(Map<String, dynamic> json) => GetUsers(
        colErabiltzaileAbizena: json["col_erabiltzaile_abizena"],
        colErabiltzaileIzena: json["col_erabiltzaile_izena"],
        colUserId: json["col_userID"],
      );

  Map<String, dynamic> toJson() => {
        "col_erabiltzaile_abizena": colErabiltzaileAbizena,
        "col_erabiltzaile_izena": colErabiltzaileIzena,
        "col_userID": colUserId,
      };
}

class ApiService {
  final _dio = Dio();
  final UserProvider userProvider = UserProvider();

  Future<List<GetEvents>?> getEvents() async {
    try {
      var url = Uri.parse(baseUrl + events);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<GetEvents> _model = getEventsFromJson(response.body);
        return _model;
      }
    } catch (e) {}
    return null;
  }

  Future<(List<Participant>, List<Participant>, List<Participant>)>
      getEventParticipants(int eventID) async {
    final response = await _dio
        .get(baseUrl + eventuser, queryParameters: {"eventID": eventID});
    final getEventParticipant = GetEventParticipants.fromJson(response.data);
    userProvider.updateUsers(getEventParticipant);
    return (
      userProvider.participantList,
      userProvider.spectatorList,
      userProvider.nonparticipantList
    );
  }

  Future<bool> addNewEvent(String eventName, String eventLocation,
      String eventDate, String eventTime, int eventType) async {
    final _queryParameters = {
      "name": eventName,
      "location": eventLocation,
      "date": eventDate,
      "time": eventTime,
      "type": eventType,
    };

    final response =
        await _dio.post(baseUrl + event, queryParameters: _queryParameters);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> addNewUser(String name, String surname) async {
    final _queryParameters = {
      "name": name,
      "surname": surname,
    };

    final response =
        await _dio.post(baseUrl + user, queryParameters: _queryParameters);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<List<GetUsers>?> getUsers() async {
    var url = Uri.parse(baseUrl + users);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<GetUsers> _users = getUsersFromJson(response.body);
      return _users;
    }
    return null;
  }

  Future<bool?> addParticipantToEvent(
      ParticipantType vF_participantType, int vF_eventID, int vF_userID) async {
    final int participantType =
        (vF_participantType == ParticipantType.participant) ? 1 : 2;

    final _queryParameters = {
      "eventID": vF_eventID,
      "userID": vF_userID,
      "participationType": participantType,
    };
    final response =
        await _dio.post(baseUrl + eventuser, queryParameters: _queryParameters);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool?> removeParticipantFromEvent(ParticipantType vF_participantType,
      int vF_eventID, int vF_userID) async {
    final int participantType =
        (vF_participantType == ParticipantType.participant) ? 1 : 2;

    final _queryParameters = {
      "eventID": vF_eventID,
      "userID": vF_userID,
      "participationType": participantType,
    };
    final response =
        await _dio.delete(baseUrl + eventuser, queryParameters: _queryParameters);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
      }
}
