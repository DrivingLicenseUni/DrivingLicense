import 'package:flutter/material.dart';
import 'package:license/model/appointment.dart';
import 'package:license/res/types.dart';

import '../data/remote/instructor_data.dart';
import '../data/remote/user_data.dart';

class DatePickerViewModel extends ChangeNotifier {
  final Appointment _appointment = Appointment();
  DateTime _selectedDate = DateTime.now();
  final List<DateTime> _bookedDates = [];
  // List<String> _availableTimes = [];
  Map<int, dynamic> _availableTimes = {};
  dynamic _availableTimesInDate = [];
  String? _selectedTime;

  DateTime get selectedDate => _selectedDate;
  dynamic get availableTimesInDate => _availableTimesInDate;
  List<DateTime> get bookedDates => _bookedDates;
  Map<int, dynamic> get availableTimes => _availableTimes;
  String? get selectedTime => _selectedTime;

  final TextEditingController _timeController = TextEditingController();
  TextEditingController get timeController => _timeController;

  DatePickerViewModel() {
    _timeController.text = '';
    loadAvailableTimes(_selectedDate.day).then((value) {
      notifyListeners();
      _availableTimesInDate = value;
    });
  }

  List<Instructor> _instructors = [];

  Future<void> updateInstructor(Instructor instructor) async {
    await _appointment.updateInstructor(instructor);
    loadAvailableTimes(_selectedDate.day).then((value) {
      _availableTimesInDate = value;
    });
  }

  Future<List<String>> loadAvailableTimes(int day) async {
    try {
      _instructors = await _appointment.getInstructors();
      late Instructor instructor;

      for (int i = 0; i < _instructors.length; i++) {
        if (_instructors[i].email == 'omar_ins@instructor.com') {
          instructor = _instructors[i];
          break;
        }
      }

      _availableTimes = instructor.availableTimes;

      if (instructor.availableTimes[day] != null) {
        _availableTimesInDate = instructor.availableTimes[day];
      } else {
        _availableTimesInDate = [];
      }
    } catch (e) {
      _availableTimes = {};
      _availableTimesInDate = [];
    }

    List<String> actualTimes = [];
    for (int i = 0; i < _availableTimesInDate.length; i++) {
      actualTimes.add(_availableTimesInDate[i]);
    }

    _availableTimesInDate = actualTimes;

    return actualTimes;
  }

  Future<void> removeTime(int day, String time) async {
    await _appointment.removeTimeFromInstructorFromDay(
        "omar_ins@instructor.com", day, time);
    notifyListeners();
  }

  Future<List<String>> loadAvailableTimesForStudent(
      DateTime selectedDate) async {
    try {
      final availableTimeSlots = await StudentData().fetchAvailableTimeSlots();

      if (availableTimeSlots.containsKey(selectedDate.day.toString())) {
        var timeSlots = availableTimeSlots[selectedDate.day.toString()];
        if (timeSlots is List<String>) {
          return timeSlots;
        }
      }
      return [];
    } catch (e) {
      print('Error loading available times for student: $e');
      throw e;
    }
  }

  void selectDate(DateTime selectedDate) {
    _selectedDate = selectedDate;
    notifyListeners();
  }

  void selectTime(String time) {
    _selectedTime = time;
    notifyListeners();
  }

  void bookNow(BuildContext context) {
    if (_selectedTime != null) {
      try {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Booking for $_selectedDate at $_selectedTime')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('An error occurred while booking the appointment')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a time first')),
      );
    }
  }
}
