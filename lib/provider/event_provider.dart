import 'package:flutter/cupertino.dart';
import '../db/database.dart';
import '../model/event.dart';

class EventProvider extends ChangeNotifier {
  final Future<List<Event>> _events = EventsDB.instance.readAllEvents();
// final List<Event> _events =  [];
  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) => _selectedDate = date;

  Future<List<Event>> get eventOfSelectedDate => _events;

Future<List<Event>> get events => _events;




  void addEvent(Event event) async {
    // _events.add(event);
     await EventsDB.instance.create(event);
    notifyListeners();
  }

  void deleteEvent(Event event ) async{
    // _events.remove(event);
     await EventsDB.instance.delete(event.id as int);
    notifyListeners();
  }

  void editEvent(Event newEvent) async {
    // final index = _events.indexOf(oldEvent);
    // _events[index] = newEvent;
   await EventsDB.instance.update(newEvent);
    notifyListeners();
  }
}
