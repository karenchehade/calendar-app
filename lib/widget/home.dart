import 'package:app/theme.dart';
import 'package:app/widget/calendar.dart';
import 'package:flutter/material.dart';
import 'package:app/pages/event_editing.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          Container(
            padding: const EdgeInsets.all(15),
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
                                color: Colors.white,
                              )
                            : const FaIcon(
                                FontAwesomeIcons.moon,
                                size: 20,
                                color: Colors.black,
                              ),
                        onPressed: () => {notifier.toggleTheme()}))
              ],
            ),
          )
        ],
      ),
      body: const Calendar(),
      floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const EventEditingPage()))),
    );
  }
}
