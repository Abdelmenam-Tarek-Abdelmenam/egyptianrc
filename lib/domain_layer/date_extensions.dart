import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension Formating on DateTime {
  String get formatDate => DateFormat('yyyy-MM-dd HH:mm:ss').format(this);
}

extension Parsing on String {
  DateTime get parseDate => DateFormat('yyyy-MM-dd HH:mm:ss').parse(this);
  TimeOfDay get parseTime =>
      TimeOfDay.fromDateTime(DateFormat.jm().parse(this));
}
