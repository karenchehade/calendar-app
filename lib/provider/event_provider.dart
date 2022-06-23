import 'package:flutter/cupertino.dart';
import '../db/database.dart';
import '../model/event.dart';

class EventProvider extends ChangeNotifier {
  Future<List<Event>> _events = EventsDB.instance.readAllEvents();
// final List<Event> _events =  [];
  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) => _selectedDate = date;
  // Event get firstEvent => event[0];
  Future<List<Event>> get eventOfSelectedDate =>
      EventsDB.instance.readAllEvents();

  Future<List<Event>> get events => EventsDB.instance.readAllEvents();

  void setEvents(Future<List<Event>> value) => _events = value;

  void addEvent(Event event) async {
    // _events.add(event);
    await EventsDB.instance.create(event);
    notifyListeners();
  }

  void deleteEvent(Event event) async {
    // _events.remove(event);
    await EventsDB.instance.delete(event.id as int);
    _events = EventsDB.instance.readAllEvents();
    print(_events);
    notifyListeners();
  }

  Future editEvent(Event newEvent) async {
    // final index = _events.indexOf(oldEvent);
    // _events[index] = newEvent;
    await EventsDB.instance.update(newEvent);
    _events = EventsDB.instance.readAllEvents();
    print('ana editt');
    notifyListeners();
  }
}
