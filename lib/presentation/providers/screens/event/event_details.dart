import 'package:estrailurtarrak/presentation/providers/user_provider.dart';
import 'package:estrailurtarrak/presentation/users/user_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gradient_borders/gradient_borders.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key});

  @override
  Widget build(BuildContext context) {
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
                  const Expanded(
                    child: Column(children: [
                      ParticipantInformation(
                        title: 'Partaideak',
                      ),
                      SizedBox(height: 20),
                      ParticipantInformation(
                        title: 'Animatzaileak',
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

  const ParticipantInformation({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

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
            controller: userProvider.chatScrollController,
            itemCount: userProvider.userList.length,
            itemBuilder: (context, index) {
              final UserBox user = userProvider.userList[index];
              return user;
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
