import 'package:estrailurtarrak/domain/entities/estrailurtarrakEvent.dart';
import 'package:estrailurtarrak/helpers/api_calls.dart';
import 'package:estrailurtarrak/presentation/providers/screens/event/add_new_event.dart';
import 'package:estrailurtarrak/presentation/providers/screens/event/event_details.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';

class EventList extends StatefulWidget {
  const EventList({super.key});

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  late List<GetEvents>? _eventList = [];
  late List<EventInformationBox> _eventInformationBoxList = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _eventList = (await ApiService().getEvents())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          _convertToInformationBox(_eventList);
        }));
  }

  TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat.Hm(); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(tod));
  }

  List<EventInformationBox> _convertToInformationBox(List<GetEvents>? events) {
    if (events == null || events.isEmpty) {
      _eventInformationBoxList = [];
    } else {
      for (int i = 0; i < events.length; i++) {
        _eventInformationBoxList.add(EventInformationBox(
            eventID: events[i].colEventId,
            eventName: events[i].colEkitaldiIzena,
            eventLocation: events[i].colEkitaldiKokalekua,
            datetime: events[i].colEkitaldiData,
            time: stringToTimeOfDay(events[i].colEkitaldiOrdua),
            eventType: events[i].colEkitaldiMota));
      }
    }
    return _eventInformationBoxList;
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _eventScrollController = ScrollController();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Estrailurtarren ekitaldiak'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(children: [
                _eventInformationBoxList.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: ListView.builder(
                            controller: _eventScrollController,
                            itemCount: _eventInformationBoxList.length,
                            itemBuilder: ((context, index) {
                              return (_eventInformationBoxList[index]);
                            })),
                      ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ))),
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
                        )));
          },
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  height: 130,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
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
