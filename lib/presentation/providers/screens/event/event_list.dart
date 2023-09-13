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
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(children: [
                Column(children: [
                  EventInformationBox(
                      eventName: 'Hondarribiako Triatloia',
                      eventLocation: 'Hondarribia',
                      datetime: DateTime(2023, 05, 06, 15, 00),
                      icon: Icons.heart_broken,),
                  const SizedBox(
                    height: 20,
                  ),
                  EventInformationBox(
                      eventName: 'Behobia SS',
                      eventLocation: 'Donostia',
                      datetime: DateTime(2023, 11, 12, 9, 30),
                      icon: Icons.run_circle_rounded,),
                ])
              ])),
        ));
  }
}

class EventInformationBox extends StatelessWidget {
  final String eventName;
  final String eventLocation;
  final DateTime datetime;
  final IconData icon;

  const EventInformationBox(
      {super.key,
      required this.eventName,
      required this.eventLocation,
      required this.datetime,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            height: 110,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    spreadRadius: 1,
                    blurRadius: 15,
                    offset: const Offset(0, 15),
                  )
                ],
                border: const GradientBoxBorder(
                  gradient: LinearGradient(
                    colors: [Color(0xFF9747FF), Color(0xFF00DADA)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                borderRadius: BorderRadius.circular(10)),
            child: EventInformationBoxText(
                eventName: eventName,
                eventLocation: eventLocation,
                date: datetime,
                icon: icon,),
          ),
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
          Expanded(
            child: Column(
              children: [
                Text(
                  eventName,
                  textAlign: TextAlign.left,
                ),
                Text(eventLocation),
                Text(DateFormat.yMEd().format(date)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
