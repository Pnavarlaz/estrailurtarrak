import 'package:dio/dio.dart';
import 'package:estrailurtarrak/infrastructure/models/get_event_participants_model.dart';
import 'package:estrailurtarrak/presentation/providers/user_provider.dart';
import 'package:flutter/widgets.dart';

class GetEventParticipantsAnswer extends ChangeNotifier {
  final _dio = Dio();
  final ScrollController chatScrollController = ScrollController();
  final UserProvider userProvider = UserProvider();

  Future<void> getEventParticipants(int eventID) async {
    final response = await _dio.get('http://192.168.1.137:5000/eventuser',
        queryParameters: {"eventID": eventID});
    final getEventParticipant = GetEventParticipants.fromJson(response.data);
    userProvider.updateUsers(getEventParticipant);
    notifyListeners();
  }
}
