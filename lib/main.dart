import 'package:app/provider/event_provider.dart';
import 'package:app/theme.dart';
import 'package:app/widget/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
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
            home: const Home(),
          );
        }),
      );
}
