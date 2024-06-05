// view_models/signs_view_model.dart
import 'package:flutter/material.dart';
import 'package:license/model/signs_model.dart';
import 'package:license/view_model/dummy_data.dart';

class SignsViewModel extends ChangeNotifier {
  final List<SignModel> _signs = dummySignData; // Use the dummy data
  List<String> _headers = [];

  SignsViewModel() {
    _headers = _signs.map((sign) => sign.header).toSet().toList();
  }

  List<SignModel> get signs => _signs;
  List<String> get headers => _headers;

  List<SignModel> getSignsForHeader(String header) {
    return _signs.where((sign) => sign.header == header).toList();
  }
}