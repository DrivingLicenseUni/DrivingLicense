import 'package:flutter/material.dart';
import 'package:license/model/appointment.dart';

class DatePickerViewModel extends ChangeNotifier {
  DateTime _selectedDate = DateTime.now();
  List<DateTime> _bookedDates = [];
  List<String> _availableTimes = [];
  String? _selectedTime;

  DateTime get selectedDate => _selectedDate;
  List<DateTime> get bookedDates => _bookedDates;
  List<String> get availableTimes => _availableTimes;
  String? get selectedTime => _selectedTime;

  TextEditingController _timeController = TextEditingController();
  TextEditingController get timeController => _timeController;

  DatePickerViewModel() {
    _timeController.text = '';
    _loadAvailableTimes();
  }

  void _loadAvailableTimes() {
    try {
      _availableTimes = ['10:00 AM', '11:00 AM', '12:00 PM', '2:00 PM', '3:00 PM'];
    } catch (e) {
      print('Error loading available times: $e');
      _availableTimes = [];
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
          SnackBar(content: Text('Booking for $_selectedDate at $_selectedTime')),
        );
      } catch (e) {
        print('Error booking appointment: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred while booking the appointment')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a time first')),
      );
    }
  }
}
