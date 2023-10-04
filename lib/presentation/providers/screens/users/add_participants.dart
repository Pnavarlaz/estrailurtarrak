import 'package:estrailurtarrak/infrastructure/models/get_event_participants_model.dart';
import 'package:estrailurtarrak/presentation/providers/screens/event/event_details.dart';
import 'package:estrailurtarrak/presentation/users/user_box.dart';
import 'package:flutter/material.dart';

class AddParticipants extends StatefulWidget {
  final List<Participant> nonparticipantAnswer;
  final ParticipantType participantType;
  const AddParticipants({super.key, required this.nonparticipantAnswer, required this.participantType});

  @override
  State<AddParticipants> createState() => _AddParticipantsState();
}

class _AddParticipantsState extends State<AddParticipants> {
  int selectedUID = -1;

  @override
  Widget build(BuildContext context) {
    final ScrollController _userScrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Partehartzailea gehitu'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      controller: _userScrollController,
                      itemCount: widget.nonparticipantAnswer.length,
                      itemBuilder: ((BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedUID =
                                  widget.nonparticipantAnswer[index].colUserId;
                            });
                          },
                          child: (UserBox(
                            name: widget.nonparticipantAnswer[index]
                                .colErabiltzaileIzena,
                            surname: widget.nonparticipantAnswer[index]
                                .colErabiltzaileAbizena,
                            userid:
                                widget.nonparticipantAnswer[index].colUserId,
                            isSelected: (selectedUID ==
                                widget.nonparticipantAnswer[index].colUserId),
                            imageUrl:
                                'https://www.latercera.com/resizer/Lv1ZJ2RxxMB41puL6s-MzNCUPmc=/900x600/smart/cloudfront-us-east-1.images.arcpublishing.com/copesa/NN5RYASU7VFZFK5ECHJA2QKEYQ.jpg',
                            deletable: false,
                            selectable: true,
                          )),
                        );
                      }))),
              AddParticipantBottomRow(),
            ],
          ),
        ),
      ),
    );
  }
}

class AddParticipantBottomRow extends StatelessWidget {
  const AddParticipantBottomRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: SizedBox()),
        ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ))),
            onPressed: () {},
            child: Text('Partehartzailea gehitu'))
      ],
    );
  }
}
