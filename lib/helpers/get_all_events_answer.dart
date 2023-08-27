import 'dart:html';

import 'package:dio/dio.dart';
import 'package:estrailurtarrak/domain/entities/estrailurtarrakEvent.dart';
import 'package:estrailurtarrak/infrastructure/models/get_all_events_model.dart';

class GetAllEventsAnswer {
  final _dio = Dio();

  Future<EstrailurtarrakEvent> getAllEvents() async {
    final response = await _dio.get('http://192.168.1.137:5000/events');
    final getAllEvents = GetAllEvents.fromJson(response.data);
    return getAllEvents;
  }
}
