import 'package:flutter/cupertino.dart';
import '../db/database.dart';
import '../model/event.dart';

class EventProvider extends ChangeNotifier {
 List<Event> _events = [];
// final List<Event> _events =  [];
  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) => _selectedDate = date;

  Future<List<Event>> get eventOfSelectedDate => EventsDB.instance.readAllEvents();

  Future<List<Event>> get events => EventsDB.instance.readAllEvents();

  void addEvent(Event event) async {
    // _events.add(event);
    await EventsDB.instance.create(event);
    notifyListeners();
  }

  void deleteEvent(Event event) async {
    // _events.remove(event);
    await EventsDB.instance.delete(event.id as int);
    print(_events);
    notifyListeners();
  }

  void editEvent(Event newEvent) async {
    // final index = _events.indexOf(oldEvent);
    // _events[index] = newEvent;
    await EventsDB.instance.update(newEvent);
    print('ana editt');
    notifyListeners();
  }
}
