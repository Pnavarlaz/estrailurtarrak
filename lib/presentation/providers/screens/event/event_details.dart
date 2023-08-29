import 'package:estrailurtarrak/helpers/get_event_participants_answer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gradient_borders/gradient_borders.dart';

enum ParticipantType { participant, spectator }

class EventDetails extends StatelessWidget {
  const EventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final eventParticipants = context.watch<GetEventParticipantsAnswer>();
    eventParticipants.getEventParticipants(2);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hondarribiako Triatloia'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      'https://www.hondarribia.eus/documents/124308/124935/Hondartza/8e7d0e0a-7675-48d0-b891-adbe801a2e13?t=1467040014000',
                      alignment: Alignment.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Column(children: [
                      ParticipantInformation(
                        participantType: ParticipantType.participant,
                        title: 'Partaideak',
                        participantsAnswer: eventParticipants,
                      ),
                      SizedBox(height: 20),
                      ParticipantInformation(
                        participantType: ParticipantType.spectator,
                        title: 'Animatzaileak',
                        participantsAnswer: eventParticipants,
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
  final GetEventParticipantsAnswer participantsAnswer;
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
              colors: [Color(0xFF9747FF), Color(0xFF00DADA)],
            ),
            width: 3),
        borderRadius: BorderRadius.circular(15),
      ),
      height: 300,
      child: Column(
        children: [
          ParticipantInformationHeader(title: title),
          Expanded(
              child: ListView.builder(
            controller: participantsAnswer.chatScrollController,
            itemCount: (participantType == ParticipantType.participant)
                ? participantsAnswer.userProvider.participantList.length
                : participantsAnswer.userProvider.spectatorList.length,
            itemBuilder: (context, index) {
              return ((participantType == ParticipantType.participant)
                  ? (participantsAnswer.userProvider.participantList[index])
                  : (participantsAnswer.userProvider.spectatorList[index]));
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
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add_circle_outline_rounded,
              size: 30,
              color: Color(0xFF9747FF),
            ))
      ],
    );
  }
}
