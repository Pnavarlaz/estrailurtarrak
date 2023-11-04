import 'package:estrailurtarrak/infrastructure/models/get_event_participants_model.dart';

class UserProvider {
  List<Participant> participantList = [];
  List<Participant> spectatorList = [];
  List<Participant> nonparticipantList = [];

  void updateUsers(GetEventParticipants users) {
    participantList = [];
    spectatorList = [];
    nonparticipantList = [];

    for (Participant user in users.participants) {
      participantList.add(user);
    }
    for (Participant user in users.observers) {
      spectatorList.add(user);
    }
    for (Participant user in users.nonparticipants) {
      nonparticipantList.add(user);
    }
  }
}
