import 'package:app/pages/event_editing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:events_calendar/utils.dart';

import '../model/event.dart';
import '../provider/event_provider.dart';

class EventViewingPage extends StatelessWidget {
  final Event event;
  const EventViewingPage({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const CloseButton(), actions: buildViewingActions(context, event)),
      body: ListView(
        padding: const EdgeInsets.all(32),
        children: <Widget>[
          buildDateTime(event),
          const SizedBox(
            height: 32,
          ),
          Text(
            event.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            event.description,
            style: const TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget buildDateTime(Event event) {
    return Column(
      children: [
        buildDate(event.isAllDay ? 'All-day' : 'from', event.from),
        if (!event.isAllDay) buildDate('To', event.to),
      ],
    );
  }

  List<Widget> buildViewingActions(BuildContext context, Event event) {
    return [
      IconButton(
        onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => EventEditingPage(event: event))),
        icon: const Icon(Icons.edit),
      ),
      IconButton(
          onPressed: () {
            final provider = Provider.of<EventProvider>(context, listen: false);
            provider.deleteEvent(event);
          },
          icon: const Icon(Icons.delete))
    ];
  }

  Widget buildDate(String title, DateTime date) => Row(
        children: [
          Text(title),
          // Text(date.f),
        ],
      );
}
