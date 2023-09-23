import 'package:estrailurtarrak/domain/entities/estrailurtarrakEvent.dart';
import 'package:flutter/material.dart';

class SelectEventType extends StatefulWidget {
  const SelectEventType({super.key});

  @override
  State<SelectEventType> createState() => _SelectEventTypeState();
}

class _SelectEventTypeState extends State<SelectEventType> {
  final TextEditingController eventController = TextEditingController();
  EstrailurtarrakEventType? selectedEvent;

  @override
  Widget build(BuildContext context) {
    /* Generate list of events */
    final List<DropdownMenuEntry<EstrailurtarrakEventType>> eventTypeEntries =
        <DropdownMenuEntry<EstrailurtarrakEventType>>[];
    for (int i = 0; i < EstrailurtarrakEventType.eventTypes.length; i++) {
      EstrailurtarrakEventType currentType =
          EstrailurtarrakEventType(eventType: i);
      eventTypeEntries.add(
        DropdownMenuEntry<EstrailurtarrakEventType>(
          style: ButtonStyle(),
          leadingIcon: Icon(currentType.getIcon()),
          value: currentType,
          label: currentType.getName(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ekitaldi mota'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children : [
                  Align(
                    child: DropdownMenu<EstrailurtarrakEventType>(
                      dropdownMenuEntries: eventTypeEntries,  
                      hintText: 'Ekitaldi mota aukeratu',
                      enableSearch: false,
                      label: const Text('Ekitaldi mota'),
                      controller: eventController,
                      onSelected: (EstrailurtarrakEventType? eventType) {
                        setState(() {
                          selectedEvent = eventType;
                        });
                      },
                    ),
                  )
                ]
              ),
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
              onPressed: () {},
              child: Text('Ekitaldia sortu')),
            )
          ],
        ),
      )),
    );
  }
}
