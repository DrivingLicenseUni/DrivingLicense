import 'package:flutter/material.dart';

import '../data/remote/user_data.dart';
import '../model/appointments_card_data.dart';

class AppointmentViewModel extends ChangeNotifier {
  DateTime? _selectedDate;
  List<CardData> appointments = [];

  List<CardData> get filteredAppointments {
    if (_selectedDate == null) {
      return appointments;
    } else {
      return appointments.where((appointment) {
        final appointmentDate = DateTime(
          appointment.date.year,
          appointment.date.month,
          appointment.date.day,
        );
        final selectedDate = DateTime(
          _selectedDate!.year,
          _selectedDate!.month,
          _selectedDate!.day,
        );
        return selectedDate == appointmentDate;
      }).toList();
    }
  }

  DateTime? get selectedDate => _selectedDate;

  void setDate(DateTime? date) {
    _selectedDate = date;
    notifyListeners();
  }

  AppointmentViewModel() {
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    final StudentData studentData = StudentData();
    appointments = await studentData.getBookedAppointments();
    notifyListeners();
  }
}
