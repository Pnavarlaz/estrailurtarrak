import 'package:estrailurtarrak/helpers/api_calls.dart';
import 'package:estrailurtarrak/presentation/providers/screens/event/event_list.dart';
import 'package:estrailurtarrak/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GetEventParticipantsAnswer(),)
      ],
      child: MaterialApp(
        title: 'Estrailurtarrak',
        theme: AppTheme(selectedColor: 0).theme(),
        debugShowCheckedModeBanner: false,
        home: const EventList(),
      ),
    );
  }
}
