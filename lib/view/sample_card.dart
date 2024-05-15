import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:license/res/colors.dart';
import 'package:license/view_model/appointments_list.dart';
import 'package:provider/provider.dart';


class SampleCard extends StatelessWidget {
  final AppointmentViewModel viewModel;

  SampleCard({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AppointmentViewModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child : SizedBox (
      width: 370,
      height: 85,
      child: Card(
        child: ListView.builder(
          itemCount: viewModel.filteredCards.length,
          itemBuilder: (context, index) {
            final cardData = viewModel.filteredCards[index];
            return ListTile(
              tileColor: Colors.blue[50],
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Text(
                cardData.title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                DateFormat('hh:mm a').format(cardData.date),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
      ),
    ));
  }
}