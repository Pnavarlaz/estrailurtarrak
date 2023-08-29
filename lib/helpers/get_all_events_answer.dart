
import 'package:dio/dio.dart';
import 'package:estrailurtarrak/infrastructure/models/get_all_events_model.dart';

class GetAllEventsAnswer {
  final _dio = Dio();

  Future<List> getAllEvents() async {
    final response = await _dio.get('http://192.168.1.137:5000/events');
    final getAllEvents = getAllEventsFromJson(response.data);
    return getAllEvents;
  }
}
