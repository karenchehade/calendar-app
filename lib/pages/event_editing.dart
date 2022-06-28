import 'package:app/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../model/event.dart';
import '../provider/event_provider.dart';

class EventEditingPage extends StatefulWidget {
  final Event? event;

  const EventEditingPage({Key? key, this.event}) : super(key: key);

  @override
  State<EventEditingPage> createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;
  List<Event> events = [];

  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => fetchData().then((value) => null));

    super.initState();
    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(const Duration(hours: 2));
    } else {
      final event = widget.event!;
      titleController.text = event.title;
      fromDate = event.from;
      toDate = event.to;
    }
  }

  Future<void> fetchData() async {
    events = await Provider.of<EventProvider>(context, listen: false).events;
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: const CloseButton(),
        actions: buildEditingAction(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitle(),
              const SizedBox(
                height: 12,
              ),
              buildDateTimePicker(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildEditingAction() => [
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                primary: Colors.transparent, shadowColor: Colors.transparent),
            onPressed: saveForm,
            icon: const Icon(Icons.done),
            label: const Text('Save'))
      ];

  Widget buildTitle() => TextFormField(
        style: const TextStyle(fontSize: 24),
        decoration: const InputDecoration(
            border: UnderlineInputBorder(), hintText: 'add title'),
        validator: (title) =>
            title != null && title.isEmpty ? 'Title cannot be empty' : null,
        onFieldSubmitted: (_) => saveForm(),
        controller: titleController,
      );

  Widget buildDateTimePicker() => Column(
        children: [
          buildFrom(),
          buildTo(),
        ],
      );

  Widget buildFrom() => buildHeader(
        header: 'FROM',
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: buildDropdownField(
                    text: Utils.toDate(fromDate),
                    onClicked: () => pickFromDateTime(pickDate: true))),
            Expanded(
                child: buildDropdownField(
                    text: Utils.toTime(fromDate),
                    onClicked: () => pickFromDateTime(pickDate: false)))
          ],
        ),
      );

  Widget buildTo() => buildHeader(
        header: 'TO',
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: buildDropdownField(
                    text: Utils.toDate(toDate),
                    onClicked: () => pickToDateTime(pickDate: true))),
            Expanded(
                child: buildDropdownField(
                    text: Utils.toTime(toDate),
                    onClicked: () => pickToDateTime(pickDate: false)))
          ],
        ),
      );

  Widget buildDropdownField(
          {required String text, required VoidCallback onClicked}) =>
      ListTile(
        title: Text(text),
        trailing: const Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  Widget buildHeader({required String header, required Widget child}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          child,
        ],
      );

  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    if (date == null) return;

    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }
    setState(() => fromDate = date);
  }

  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(toDate,
        pickDate: pickDate, firstDate: pickDate ? fromDate : null);
    if (date == null) return;

    setState(() => toDate = date);
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime(2022, 6),
          lastDate: DateTime(2027));

      if (date == null) return null;

      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);
      return date.add(time);
    } else {
      final timeDay = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(initialDate));
      if (timeDay == null) return null;
      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeDay.hour, minutes: timeDay.minute);
      return date.add(time);
    }
  }

  Future saveForm() async {
    final isValid = _formKey.currentState!.validate();
    int idcount = 0;
    if (isValid) {
      final event = Event(
          id: idcount,
          title: titleController.text,
          description: 'desc',
          from: fromDate,
          to: toDate,
          isAllDay: false);

      final isEditing = widget.event;
      final provider = Provider.of<EventProvider>(context, listen: false);
      // final selectedEvents = provider.eventOfSelectedDate;
      if (isEditing != null) {
        provider.editEvent(event);
        Navigator.of(context).pop();
      } else {
        idcount++;
        provider.addEvent(event);
      }
      fetchData();
      Navigator.pushNamed(context, Routes.home);
    }
  }
}
