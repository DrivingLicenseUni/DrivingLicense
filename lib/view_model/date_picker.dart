import 'package:flutter/material.dart';
import 'package:license/model/appointment.dart';
import 'package:license/res/types.dart';

class DatePickerViewModel extends ChangeNotifier {
  final Appointment _appointment = Appointment();
  DateTime _selectedDate = DateTime.now();
  final List<DateTime> _bookedDates = [];
  // List<String> _availableTimes = [];
  Map<String, dynamic> _availableTimes = {};
  String? _selectedTime;

  DateTime get selectedDate => _selectedDate;
  List<DateTime> get bookedDates => _bookedDates;
  Map<String, dynamic> get availableTimes => _availableTimes;
  String? get selectedTime => _selectedTime;

  final TextEditingController _timeController = TextEditingController();
  TextEditingController get timeController => _timeController;

  DatePickerViewModel() {
    _timeController.text = '';
    loadAvailableTimes().then((value) {
      notifyListeners();
      _availableTimes = value;
    });
  }

  List<Instructor> _instructors = [];

  Future<Map<String, dynamic>> loadAvailableTimes() async {
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
      // _availableTimes
      // _availableTimes = {
      //   "hi": ['10:00 AM'],
      // };
    } catch (e) {
      _availableTimes = {};
    }

    return _availableTimes;
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
