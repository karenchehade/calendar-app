import 'package:app/pages/event_editing.dart';
import 'package:app/pages/event_viewing.dart';
import 'package:app/provider/event_provider.dart';
import 'package:app/theme.dart';
import 'package:app/widget/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}
class Routes {
  static const String home = '/';
  static const String edit = '/edit';
  static const String view = '/view';
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier()),
          ChangeNotifierProvider<EventProvider>(create: (_) => EventProvider()),
        ],
        child: Consumer<ThemeNotifier>(
            builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            title: 'calendar',
            debugShowCheckedModeBanner: false,
            theme: notifier.isDarkTheme ? dark : light,
            // home: const Home(),
             routes: {
        Routes.home: (BuildContext context) => Home(),
        Routes.edit: (BuildContext context) => const EventEditingPage(),
        Routes.view: (BuildContext context) =>  const EventViewingPage(eventId: 0,),
      },
          );
        }),
      );
}
