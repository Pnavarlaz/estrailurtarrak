import 'package:flutter/material.dart';

class EstrailurtarrakEvent {
  final int col_eventID;
  final String col_ekitaldi_ziena;
  final String col_ekitaldi_kokalekua;
  final DateTime col_ekitaldi_data;
  final DateTime col_ekitaldi_ordua;

  EstrailurtarrakEvent(
      {required this.col_eventID,
      required this.col_ekitaldi_ziena,
      required this.col_ekitaldi_kokalekua,
      required this.col_ekitaldi_data,
      required this.col_ekitaldi_ordua});
}

class EstrailurtarrakEventType {
  final int eventType;
  static const List<String> eventTypes = [
    'Karrera',
    'Igeriketa',
    'Bizikleta karrera',
    'Triatloia',
    'Trail'
  ];
  
  static List<LinearGradient> eventColors = [
    LinearGradient(
        colors: [Colors.red.shade700, Colors.red.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight),
    LinearGradient(
        colors: [Colors.blue.shade700, Colors.blue.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight),
    LinearGradient(
        colors: [Colors.green.shade700, Colors.green.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight),
    LinearGradient(
      colors: [Colors.blue.shade700, Colors.green.shade700, Colors.red.shade700],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    LinearGradient(
      colors: [Colors.yellow.shade700,Colors.yellow.shade100],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    )
  ];

  static const List<IconData> eventIcon = [
    Icons.run_circle,
    Icons.water,
    Icons.pedal_bike_rounded,
    Icons.more_time_rounded,
    Icons.hiking_rounded
  ];

  EstrailurtarrakEventType({required this.eventType});

  String getName() {
    if (this.eventType >= eventTypes.length) {
      return 'Beste frogak';
    }
    return eventTypes[this.eventType];
  }

  LinearGradient getGradient() {
    if (this.eventType >= eventTypes.length) {
      return LinearGradient(colors: [Colors.black, Colors.black12]);
    }
    return eventColors[this.eventType];
  }

  IconData getIcon() {
    if (this.eventType >= eventTypes.length) {
      return Icons.bakery_dining;
    }
    return eventIcon[this.eventType];
  }
}
