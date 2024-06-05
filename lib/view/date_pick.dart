import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:license/view_model/appointments_list.dart';
import 'package:provider/provider.dart';

class DatePickerWidget extends StatelessWidget {
  final Function(DateTime)? onDateSelected;

  const DatePickerWidget({Key? key, this.onDateSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appointmentViewModel = Provider.of<AppointmentViewModel>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 40),
      child: Theme(
        data: ThemeData(
          colorScheme: ColorScheme.light(
            primary: Colors.blue,
          ),
        ),
        child: TextFormField(
          readOnly: true,
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: appointmentViewModel.selectedDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (picked != null) {
              appointmentViewModel.setDate(picked);
              if (onDateSelected != null) {
                onDateSelected!(picked);
              }
            }
          },
          decoration: InputDecoration(
            labelText: 'Select Date',
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.calendar_today),
          ),
          controller: TextEditingController(
            text: appointmentViewModel.selectedDate != null
                ? DateFormat('yyyy-MM-dd').format(appointmentViewModel.selectedDate!)
                : '',
          ),
        ),
      ),
    );
  }
}