// To parse this JSON data, do
//
//     final getEventParticipants = getEventParticipantsFromJson(jsonString);

import 'dart:convert';

GetEventParticipants getEventParticipantsFromJson(String str) => GetEventParticipants.fromJson(json.decode(str));

String getEventParticipantsToJson(GetEventParticipants data) => json.encode(data.toJson());

class GetEventParticipants {
    final List<Participant> observers;
    final List<Participant> participants;

    GetEventParticipants({
        required this.observers,
        required this.participants,
    });

    factory GetEventParticipants.fromJson(Map<String, dynamic> json) => GetEventParticipants(
        observers: List<Participant>.from(json["observers"].map((x) => Participant.fromJson(x))),
        participants: List<Participant>.from(json["participants"].map((x) => Participant.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "observers": List<dynamic>.from(observers.map((x) => x.toJson())),
        "participants": List<dynamic>.from(participants.map((x) => x.toJson())),
    };
}

class Participant {
    final String colErabiltzaileAbizena;
    final String colErabiltzaileIzena;
    final int colUserId;

    Participant({
        required this.colErabiltzaileAbizena,
        required this.colErabiltzaileIzena,
        required this.colUserId,
    });

    factory Participant.fromJson(Map<String, dynamic> json) => Participant(
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