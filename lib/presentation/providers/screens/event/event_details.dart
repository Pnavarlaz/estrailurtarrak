import 'package:estrailurtarrak/helpers/api_calls.dart';
import 'package:estrailurtarrak/infrastructure/models/get_event_participants_model.dart';
import 'package:estrailurtarrak/presentation/providers/screens/users/add_participants.dart';
import 'package:estrailurtarrak/presentation/users/user_box.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

enum ParticipantType { participant, spectator }

class EventDetails extends StatefulWidget {
  final String eventName;
  final int eventID;
  const EventDetails(
      {super.key, required this.eventID, required this.eventName});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  late List<Participant> _participantList;
  late List<Participant> _observerList;
  List<Participant> _nonparticipantList = [];

  bool answerReceived = false;
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    late List<Participant> _intparticipantList;
    late List<Participant> _intobserverList;
    late List<Participant> _intnonparticipantList;
    (_intparticipantList, _intobserverList, _intnonparticipantList) =
        await ApiService().getEventParticipants(widget.eventID);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          answerReceived = true;
          _participantList = _intparticipantList;
          _observerList = _intobserverList;
          _nonparticipantList = _intnonparticipantList;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.eventName),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(10),
                  //   child: Image.network(
                  //     'https://www.hondarribia.eus/documents/124308/124935/Hondartza/8e7d0e0a-7675-48d0-b891-adbe801a2e13?t=1467040014000',
                  //     alignment: Alignment.center,
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: (false == answerReceived)
                      ? const Center(
                            child: CircularProgressIndicator(),
                                                )
                      : Column(children: [
                          ParticipantInformation(
                            participantType: ParticipantType.participant,
                            title: 'Partaideak',
                            participantsAnswer: _participantList,
                            nonparticipantAnswer: _nonparticipantList,
                            eventID: widget.eventID,
                          ),
                          SizedBox(height: 20),
                          ParticipantInformation(
                            participantType: ParticipantType.spectator,
                            title: 'Animatzaileak',
                            participantsAnswer: _observerList,
                            nonparticipantAnswer: _nonparticipantList,
                            eventID: widget.eventID,
                          ),
                        ]),
                  )
                ],
              ))),
    );
  }
}

class ParticipantInformation extends StatelessWidget {
  final String title;
  final ParticipantType participantType;
  final List<Participant>? participantsAnswer;
  final List<Participant>? nonparticipantAnswer;
  final int eventID;

  const ParticipantInformation({
    super.key,
    required this.title,
    required this.participantType,
    required this.participantsAnswer,
    required this.nonparticipantAnswer,
    required this.eventID,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade600,
              spreadRadius: 1,
              blurRadius: 15,
              offset: const Offset(0, 15))
        ],
        border: const GradientBoxBorder(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF9747FF), Color(0xFF00DADA)],
            ),
            width: 1.5),
        borderRadius: BorderRadius.circular(15),
      ),
      height: 300,
      child: Column(
        children: [
          ParticipantInformationHeader(
              title: title,participantAnswer: participantsAnswer, nonparticipantAnswer: nonparticipantAnswer, participantType: participantType, eventID: eventID),
          Expanded(
              child: ListView.builder(
            itemCount: participantsAnswer!.length,
            itemBuilder: (context, index) {
              return (UserBox(userid: participantsAnswer![index].colUserId, 
                              name: participantsAnswer![index].colErabiltzaileIzena, 
                              surname: participantsAnswer![index].colErabiltzaileAbizena, 
                              imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHVvTOY1BR-T_roGOwEql-q9hFj5rLatYa5A&usqp=CAU"));
            },
          ))
        ],
      ),
    );
  }
}

class ParticipantInformationHeader extends StatelessWidget {
  final List<Participant>? participantAnswer;
  final List<Participant>? nonparticipantAnswer;
  final ParticipantType participantType;
  final int eventID;

  const ParticipantInformationHeader({
    super.key,
    required this.title,
    required this.participantAnswer,
    required this.nonparticipantAnswer,
    required this.participantType,
    required this.eventID,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title,
            textAlign: TextAlign.left,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const Spacer(),
        ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ))),
            onPressed: () {
              if (nonparticipantAnswer != null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddParticipants(
                          nonparticipantAnswer: nonparticipantAnswer!,
                          participantType: participantType,
                          participantAction: ParticipantAction.ADD,
                          eventID: eventID),
                    ));
              }
            },
            child: const Icon(
              Icons.person_add_alt_1_rounded,
              color: Color(0xFF9747FF),
            )),
            SizedBox(width: 5,),
            ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ))),
            onPressed: () {
              if (nonparticipantAnswer != null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddParticipants(
                          nonparticipantAnswer: participantAnswer!,
                          participantType: participantType,
                          participantAction: ParticipantAction.DELETE,
                          eventID: eventID),
                    ));
              }
            },
            child: const Icon(
              Icons.person_remove_alt_1_rounded,
              color: Color(0xFF9747FF),
            )),
      ],
    );
  }
}
