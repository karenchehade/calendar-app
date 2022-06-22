import 'package:flutter/material.dart';

const String tableEvents = 'events';

class EventFields {
static final List<String> values = [
    /// Add all fields
    id, title, description, fromDate, toDate, isAllDay
  ];
  static  String id = 'id';
  static  String title = 'title';
  static  String description = 'description';
  static  String fromDate = 'fromDate';
  static  String toDate = 'toDate';
  static  String isAllDay = 'isAllDay';
}

class Event {
  final int? id;
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final Color backgroundColor;
  final bool isAllDay;

  const Event(
      {this.id,
      required this.title,
      required this.description,
      required this.from,
      required this.to,
      this.backgroundColor = Colors.blueGrey,
      this.isAllDay = false});

  Map<String, Object?> toJson() => {
        EventFields.id: id!,
        EventFields.title: title,
        EventFields.description: description,
        EventFields.fromDate: from.toIso8601String(),
        EventFields.toDate: to.toIso8601String(),
        EventFields.isAllDay: isAllDay ? 1 : 0
      };

  Event copy({
    int? id,
    String? title,
    String? description,
    DateTime? from,
    DateTime? to,
    bool? isAllDay,
  }) =>
      Event(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        from: from ?? this.from,
        to: to ?? this.to,
        isAllDay: isAllDay ?? this.isAllDay,
      );

  static Event fromJson(Map<String, Object?> json) => Event(
        id: json[EventFields.id] as int?,
        title: json[EventFields.title] as String,
        description: json[EventFields.description] as String,
        from: DateTime.parse(json[EventFields.fromDate] as String),
        to: DateTime.parse(json[EventFields.toDate] as String),
        isAllDay: json[EventFields.isAllDay] == 1,
      );
}
