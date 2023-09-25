import 'package:estrailurtarrak/helpers/api_calls.dart';
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
  late List<UserBox> _participantList;
  late List<UserBox> _observerList;
  bool answerReceived = false;
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    late List<UserBox> _intparticipantList;
    late List<UserBox> _intobserverList;
    (_intparticipantList, _intobserverList) =
        await ApiService().getEventParticipants(widget.eventID);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          answerReceived = true;
          _participantList = _intparticipantList;
          _observerList = _intobserverList;
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
                    child: 
                    (false == answerReceived) ?
                    const Center(
                        child: CircularProgressIndicator(),
                      ) :
                    Column(children: [
                      ParticipantInformation(
                        participantType: ParticipantType.participant,
                        title: 'Partaideak',
                        participantsAnswer: _participantList,
                      ),
                      SizedBox(height: 20),
                      ParticipantInformation(
                        participantType: ParticipantType.spectator,
                        title: 'Animatzaileak',
                        participantsAnswer: _observerList,
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
  final List<UserBox>? participantsAnswer;
  const ParticipantInformation({
    super.key,
    required this.title,
    required this.participantType,
    required this.participantsAnswer,
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
          ParticipantInformationHeader(title: title),
          Expanded(
              child: ListView.builder(
            itemCount: participantsAnswer!.length,
            itemBuilder: (context, index) {
              return (participantsAnswer![index]);
            },
          ))
        ],
      ),
    );
  }
}

class ParticipantInformationHeader extends StatelessWidget {
  const ParticipantInformationHeader({
    super.key,
    required this.title,
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
            onPressed: () {},
            child: const Icon(
              Icons.add,
              size: 30,
              color: Color(0xFF9747FF),
            ))
      ],
    );
  }
}
