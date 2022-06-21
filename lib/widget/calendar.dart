import 'package:app/provider/event_provider.dart';
import 'package:app/widget/tasks.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../model/event_data_source.dart';

class Calendar extends StatelessWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;
    return SfCalendar(
      view: CalendarView.month,
      dataSource: EventDataSource(events),
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Colors.transparent,
      backgroundColor: Theme.of(context).dividerColor,
      todayTextStyle: Theme.of(context).primaryTextTheme.headline1,
      todayHighlightColor: Theme.of(context).primaryColor,
      monthCellBuilder: (BuildContext buildContext, MonthCellDetails details) {
        final Color backgroundColor = Theme.of(context).dividerColor;
                 return Container(
                decoration: BoxDecoration(
                    color: backgroundColor,
                ),
                child: Center(
                  child: Text(
                    details.date.day.toString(),
                    style: TextStyle(color:Theme.of(context).primaryTextTheme.bodyText1?.color),
                  ),
                ),
              );
      },
      monthViewSettings: const MonthViewSettings(
          showAgenda: true,
          agendaStyle: AgendaStyle(
            backgroundColor: Colors.white,
            appointmentTextStyle:
                TextStyle(color: Color.fromARGB(255, 12, 13, 34)),
            dateTextStyle: TextStyle(
                fontStyle: FontStyle.normal,
                fontSize: 22,
                fontWeight: FontWeight.w300,
                color: Colors.black),
            dayTextStyle: TextStyle(
                fontStyle: FontStyle.normal,
                fontSize: 22,
                fontWeight: FontWeight.w300,
                color: Colors.black),
          )),
      onLongPress: (details) {
        final provider = Provider.of<EventProvider>(context, listen: false);

        provider.setDate(details.date!);
        showModalBottomSheet(
          context: context,
          builder: (context) => const TasksWidget(),
        );
      },
    );
  }
}
