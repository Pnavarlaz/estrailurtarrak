import 'package:estrailurtarrak/helpers/api_calls.dart';
import 'package:estrailurtarrak/presentation/events/event_presentations.dart';
import 'package:estrailurtarrak/presentation/providers/screens/event/add_new_event.dart';
import 'package:flutter/material.dart';
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

  Future<void> _getData() async {
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
                        child: RefreshIndicator(
                          onRefresh: _getData,
                          child: ListView.builder(
                              controller: _eventScrollController,
                              itemCount: _eventInformationBoxList.length,
                              itemBuilder: ((context, index) {
                                return (_eventInformationBoxList[index]);
                              })),
                        ),
                      ),
                EventListBottomRow(),
              ])),
        ));
  }
}

class EventListBottomRow extends StatelessWidget {
  const EventListBottomRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
      Expanded(
          child: Row(children: [
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ))),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(Icons.person),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Erabiltzaileak')
                    ],
                  )),
            ),
            Expanded(child: SizedBox()),
            Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ))),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddNewEvent()));
              },
              child: Icon(Icons.add)),
        ),
          ]
          )
      )
    ]);
  }
}



