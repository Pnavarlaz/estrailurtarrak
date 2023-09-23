import 'package:estrailurtarrak/domain/entities/estrailurtarrakEvent.dart';
import 'package:estrailurtarrak/presentation/providers/screens/event/add_new_event.dart';
import 'package:estrailurtarrak/presentation/providers/screens/event/event_details.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';

class EventList extends StatelessWidget {
  const EventList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Estrailurtarren ekitaldiak'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(children: [
                Expanded(
                  child: Column(children: [
                    EventInformationBox(
                      eventName: 'Hondarribiako Triatloia',
                      eventLocation: 'Hondarribia',
                      datetime: DateTime(2023, 05, 06, 15, 00),
                      eventType: 3,
                    ),
                    EventInformationBox(
                      eventName: 'Behobia SS',
                      eventLocation: 'Donostia',
                      datetime: DateTime(2023, 11, 12, 9, 30),
                      eventType: 0,
                    ),
                    EventInformationBox(
                        eventName: 'Igeriketa Froga',
                        eventLocation: 'Igerilekuan',
                        datetime: DateTime(2023, 12, 24),
                        eventType: 1),
                    EventInformationBox(
                        eventName: 'Bizikleta Karrera',
                        eventLocation: 'Mendian',
                        datetime: DateTime(2024, 01, 01),
                        eventType: 2),
                    EventInformationBox(
                        eventName: 'Trail karrera',
                        eventLocation: 'Mendian baitare',
                        datetime: DateTime(2080, 12, 31),
                        eventType: 4),
                  ]),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      )
                    )
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddNewEvent()));
                  },
                  child: Icon(Icons.add)),
                )
              ])),
        ));
  }
}

class EventInformationBox extends StatefulWidget {
  final String eventName;
  final String eventLocation;
  final DateTime datetime;
  final int eventType;

  const EventInformationBox(
      {super.key,
      required this.eventName,
      required this.eventLocation,
      required this.datetime,
      required this.eventType});

  @override
  State<EventInformationBox> createState() => _EventInformationBoxState();
}

class _EventInformationBoxState extends State<EventInformationBox> {
  @override
  Widget build(BuildContext context) {
    EstrailurtarrakEventType eventTypeDetails =
        EstrailurtarrakEventType(eventType: widget.eventType);
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const EventDetails()));
          },
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  height: 120,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade500,
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: const Offset(0, 10),
                        )
                      ],
                      border: GradientBoxBorder(
                        gradient: LinearGradient(
                          colors: eventTypeDetails.getGradient().colors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: EventInformationBoxText(
                    eventName: widget.eventName,
                    eventLocation: widget.eventLocation,
                    date: widget.datetime,
                    icon: eventTypeDetails.getIcon(),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class EventInformationBoxText extends StatelessWidget {
  final String eventName;
  final String eventLocation;
  final DateTime date;
  final IconData icon;
  const EventInformationBoxText(
      {super.key,
      required this.eventName,
      required this.eventLocation,
      required this.date,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            child: Icon(icon),
            alignment: Alignment.center,
            width: 30,
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  eventName,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                Text(
                  eventLocation,
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  DateFormat.yMEd().format(date),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
