import 'package:app/utils.dart';
import 'package:app/pages/event_editing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../model/event.dart';
import '../provider/event_provider.dart';

class EventViewingPage extends StatefulWidget {
  final int? eventId;
  final Event? event;
  const EventViewingPage({Key? key, this.eventId , this.event }) : super(key: key);
  @override
  State<EventViewingPage> createState() => _EventViewingPageState();
}

class _EventViewingPageState extends State<EventViewingPage> {
  // late Event? eventp;
  bool isLoading = false;

  @override
  void initState() {
    refreshEvent();
    super.initState();
  }

  Future<void> refreshEvent() async {
    setState(() => isLoading = true);
    // eventp = await EventsDB.instance.readEvent(widget.eventId!);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: const CloseButton(),
          actions: buildViewingActions(context, widget.event!)),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(32),
              children: <Widget>[
                buildDateTime(widget.event!),
                const SizedBox(
                  height: 32,
                ),
                Text(
                  widget.event!.title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  widget.event!.description,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
    );
  }

  Widget buildDateTime(Event event) {
    return Column(
      children: [
        buildDate(event.isAllDay ? 'All-day' : 'from  ', widget.event!.from),
        if (!event.isAllDay) buildDate('To  ', widget.event!.to),
      ],
    );
  }

  List<Widget> buildViewingActions(BuildContext context, Event event) {
    return [
      IconButton(
        onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => EventEditingPage(event: widget.event!))),
        icon: const Icon(Icons.edit),
      ),
      IconButton(
          onPressed: () async {
            final provider = Provider.of<EventProvider>(context, listen: false);
            provider.deleteEvent(widget.event!);
            refreshEvent();
            Navigator.pushNamed(context, Routes.home);
          },
          icon: const Icon(Icons.delete))
    ];
  }

  Widget buildDate(String title, DateTime date) => Row(
        children: [
          Text(title),
          Text(Utils.toDateTime(date)),
        ],
      );
}
