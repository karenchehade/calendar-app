import 'package:flutter/cupertino.dart';
import '../db/database.dart';
import '../model/event.dart';

class EventProvider extends ChangeNotifier {
  final List<Event> _events = EventsDB.instance.readAllEvents() as List<Event>;

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) => _selectedDate = date;

  List<Event> get eventOfSelectedDate => _events;

 List<Event> get events => _events;




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
