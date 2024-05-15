import 'package:license/model/appointments_card_data.dart';
import 'package:flutter/material.dart';

class AppointmentViewModel extends ChangeNotifier {
  DateTime? _selectedDate;

  List<CardData> get filteredCards => _selectedDate == null
      ? sampleCards
      : sampleCards.where((card) =>
  card.date.year == _selectedDate!.year &&
      card.date.month == _selectedDate!.month &&
      card.date.day == _selectedDate!.day).toList();

  void setDate(DateTime? date) {
    _selectedDate = date;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;
}

