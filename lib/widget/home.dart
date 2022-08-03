import 'package:app/theme.dart';
import 'package:app/widget/calendar.dart';
import 'package:app/widget/logout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app/pages/event_editing.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Calendar",
                    style: Theme.of(context).primaryTextTheme.headline1),
                Consumer<ThemeNotifier>(
                    builder: (context, notifier, child) => IconButton(
                        icon: notifier.isDarkTheme
                            ? const Icon(
                                Icons.wb_sunny,
                                size: 20,
                                color: Colors.white,
                              )
                            : const FaIcon(
                                FontAwesomeIcons.moon,
                                size: 20,
                                color: Colors.white,
                              ),
                        onPressed: () => {notifier.toggleTheme()})),
                 const SizedBox(
                  width: 140,
                ),
                const LogOut(),
               
              ],
            ),
          )
        ],
      ),
      body: Calendar(),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const EventEditingPage()))),
    );
  }
}
