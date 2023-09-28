import 'package:estrailurtarrak/domain/entities/estrailurtarrakEvent.dart';
import 'package:estrailurtarrak/presentation/providers/screens/event/event_details.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';



class EventInformationBox extends StatefulWidget {
  final String eventName;
  final String eventLocation;
  final DateTime datetime;
  final TimeOfDay time;
  final int eventType;
  final int eventID;

  const EventInformationBox({
    super.key,
    required this.eventID,
    required this.eventName,
    required this.eventLocation,
    required this.datetime,
    required this.time,
    required this.eventType,
  });

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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventDetails(
                  eventID: widget.eventID,
                  eventName: widget.eventName,)));
          },
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  height: 130,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [ BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 5),),],
                      border: GradientBoxBorder(
                        width: 1.5,
                        gradient: LinearGradient(
                          colors: eventTypeDetails.getGradient().colors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,),
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: EventInformationBoxText(
                    eventName: widget.eventName,
                    eventLocation: widget.eventLocation,
                    date: widget.datetime,
                    icon: eventTypeDetails.getIcon(),
                    time: widget.time,
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
  final TimeOfDay time;
  final IconData icon;
  const EventInformationBoxText(
      {super.key,
      required this.eventName,
      required this.eventLocation,
      required this.date,
      required this.time,
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
                Text(
                  time.format(context).toString(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}