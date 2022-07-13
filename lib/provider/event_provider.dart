import 'package:flutter/cupertino.dart';
import '../db/database.dart';
import '../model/event.dart';

class EventProvider extends ChangeNotifier {
  List<Event> _events = [];
  int idcount = 10;
  // List<Event> eventOfSelectedDate = [];

  @override
  void addListener(VoidCallback listener) async {
    _events = await EventsDB.instance.readAllEvents();
    super.addListener(listener);
    notifyListeners();
  }

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) => _selectedDate = date;

  List<Event> get eventOfSelectedDate =>
      // EventsDB.instance.readAllEvents();
      _events;

  List<Event> get events => _events;

  void addEvent(Event event) async {
    // _events.add(event);
    await EventsDB.instance.create(event);
    idcount++;
    notifyListeners();
  }

  void deleteEvent(Event event) async {
    // _events.remove(event);
    await EventsDB.instance.delete(event.id as int);
    notifyListeners();
  }

  Future editEvent(Event newEvent) async {
    // final index = _events.indexOf(oldEvent);
    // _events[index] = newEvent;
    await EventsDB.instance.update(newEvent);
    notifyListeners();
  }
}
