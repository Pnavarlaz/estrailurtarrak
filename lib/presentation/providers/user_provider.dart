import 'package:estrailurtarrak/infrastructure/models/get_event_participants_model.dart';
import 'package:estrailurtarrak/presentation/users/user_box.dart';

class UserProvider {
  List<UserBox> participantList = [];
  List<UserBox> spectatorList = [];

  void updateUsers(GetEventParticipants users) {
    participantList = [];
    spectatorList = [];
    for (Participant user in users.participants) {
      participantList.add(UserBox(
          name: user.colErabiltzaileIzena,
          surname: user.colErabiltzaileAbizena,
          imageUrl: 'https://img2.rtve.es/i/?w=1600&i=1658387876662.jpg'));
    }
    for (Participant user in users.observers) {
      spectatorList.add(UserBox(
          name: user.colErabiltzaileIzena,
          surname: user.colErabiltzaileAbizena,
          imageUrl: 'https://img2.rtve.es/i/?w=1600&i=1658387876662.jpg'));
    }
  }
}
