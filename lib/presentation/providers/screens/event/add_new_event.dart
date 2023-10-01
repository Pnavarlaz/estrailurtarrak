
import 'package:estrailurtarrak/presentation/providers/screens/event/select_event_type.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewEvent extends StatefulWidget {
  const AddNewEvent({super.key});

  @override
  State<AddNewEvent> createState() => _AddNewEventState();
}

class _AddNewEventState extends State<AddNewEvent> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _eventTime = TimeOfDay.now();
  final _nameKey = GlobalKey<FormState>();
  final _locationKey = GlobalKey<FormState>();


  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _eventTime = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameTextController = TextEditingController();
    TextEditingController _locationTextController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ekitaldi berria'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  TextFormField(
                      key: _nameKey,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Izena beharrazekoa da";
                        }
                        return null;
                      },
                      controller: _nameTextController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Ekitaldiaren izena',
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    key: _locationKey,
                    validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Kokalekua beharrezkoa da";
                        }
                        return null;
                      },
                    controller: _locationTextController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Kokalekua',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton(
                            onPressed: () async {
                              final DateTime? dateTime = await showDatePicker(
                                context: context,
                                initialDate: _selectedDate,
                                firstDate: _selectedDate,
                                lastDate: DateTime(2100),
                              );
                              if (dateTime != null)
                                setState(() {
                                  _selectedDate = dateTime;
                                });
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            child: const Icon(Icons.calendar_month)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        DateFormat.yMd().format(_selectedDate),
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton(
                            onPressed: () {
                              _showTimePicker();
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            child: Icon(Icons.access_time_filled_rounded)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        _eventTime.format(context).toString(),
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ))),
                  onPressed: () {
                    if (_nameTextController.text.isNotEmpty && _locationTextController.text.isNotEmpty) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectEventType(eventName: _nameTextController.text, eventLocation: _locationTextController.text, eventDate: _selectedDate, eventTime: _eventTime,)));
                    }
                  },
                  child: Text('Hurrengoa')),
            )
          ],
        ),
      )),
    );
  }
}
