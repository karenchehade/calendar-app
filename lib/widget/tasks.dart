import 'package:app/model/event_data_source.dart';
import 'package:app/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
// ignore: depend_on_referenced_packages
import 'package:syncfusion_flutter_core/theme.dart';

import '../model/event.dart';
import '../pages/event_viewing.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({Key? key}) : super(key: key);

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  List<Event> events = [];
  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => fetchData().then((value) => null));

    super.initState();
  }

  Future<void> fetchData() async {
    events = await Provider.of<EventProvider>(context, listen: false).events;
    print(events);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
   var selectedEvents = provider.eventOfSelectedDate;

    if (selectedEvents != null) {
      return const Center(
        child: Text(
          'no Events found!',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      );
    }
    return SfCalendarTheme(
      data: SfCalendarThemeData(
        timeTextStyle: const TextStyle(fontSize: 16, color: Colors.black),
      ),
      child: SfCalendar(
        view: CalendarView.timelineDay,
        dataSource: EventDataSource(events),
        initialDisplayDate: provider.selectedDate,
        appointmentBuilder: appointmentBuilder,
        headerHeight: 0,
        todayHighlightColor: Colors.black,
        selectionDecoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        onTap: (details) {
          if (details.appointments == null) return;
          // final event = details.appointments!.first;
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const EventViewingPage()));
        },
      ),
    );
  }

  Widget appointmentBuilder(
      BuildContext context, CalendarAppointmentDetails details) {
    final event = details.appointments.first;
    return Container(
      margin: const EdgeInsets.all(5),
      width: details.bounds.width,
      height: details.bounds.height,
      decoration: BoxDecoration(
          color: event.backgroundColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Text(
          event.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
