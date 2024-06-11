// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:license/data/remote/signin_data.dart';
import 'package:license/view/home_view.dart';

class HomeScreen extends StatelessWidget {
  final RemoteDataSource _dataSource = RemoteDataSource();

  HomeScreen({super.key});

  Future<void> signOut(BuildContext context) async {
    try {
      // Add your sign-out logic here
      Navigator.pushNamedAndRemoveUntil(
          context, '/login', (Route<dynamic> route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to sign out: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return HomeView();
  }
}
