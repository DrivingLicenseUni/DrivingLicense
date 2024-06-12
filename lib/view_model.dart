import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatePickerViewModel with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DateTime _selectedDate = DateTime.now();
  String? _selectedTime;
  final Map<DateTime, List<String>> _bookedSlots = {};
  List<String> _availableTimes = [];

  DateTime get selectedDate => _selectedDate;
  String? get selectedTime => _selectedTime;
  Map<DateTime, List<String>> get bookedSlots => _bookedSlots;
  List<String> get availableTimes => _availableTimes;

  void selectDate(DateTime date) {
    _selectedDate = date;
    loadAvailableTimesForStudent(date);
  }

  void selectTime(String time) {
    _selectedTime = time;
    notifyListeners();
  }

  Future<void> loadAvailableTimesForStudent(DateTime date) async {
    try {
      final DocumentSnapshot documentSnapshot = await _firestore
          .collection('available_times')
          .doc('student_id')
          .get();

      if (documentSnapshot.exists) {
        final data = documentSnapshot.data() as Map<String, dynamic>;
        final times = data['times'] as List<dynamic>;
        _availableTimes = List<String>.from(times);
      } else {
        _availableTimes = [];
      }
    } catch (error) {
      print('Error loading available times: $error');
      _availableTimes = [];
      throw error;
    }
    notifyListeners();
  }

  bool isDateAlreadyBooked(DateTime date) {
    return _bookedSlots.containsKey(date);
  }

  bool isSlotAlreadyBooked(DateTime date, String time) {
    return _bookedSlots.containsKey(date) && _bookedSlots[date]!.contains(time);
  }

  Future<void> saveAppointment(String studentId, String time) async {
    try {
      if (isSlotAlreadyBooked(_selectedDate, time)) {
        throw Exception('This time slot is already booked.');
      }

      final appointmentData = {
        'studentId': studentId,
        'date': _selectedDate,
        'time': time,
      };

      // Save appointment to Firestore
      await _firestore.collection('appointments').add(appointmentData);

      // Update booked slots locally
      if (!_bookedSlots.containsKey(_selectedDate)) {
        _bookedSlots[_selectedDate] = [];
      }
      _bookedSlots[_selectedDate]!.add(time);
      notifyListeners();
    } catch (error) {
      print('Error saving appointment: $error');
      throw error;
    }
  }
}
