import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'date_pick.dart';
import 'sample_card.dart';
import 'package:license/view_model/appointments_list.dart';

class AppointmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Replace this with navigation logic to the previous page
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'View Appointments',
          style: GoogleFonts.roboto(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            height: 1.6,
            fontStyle: FontStyle.normal,
            decoration: TextDecoration.none,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 83,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 22),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.event_available_outlined,
                  size: 24,
                ),
                SizedBox(height: 10),
                Text(
                  'Select time slot',
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                    letterSpacing: 0.02,
                    fontStyle: FontStyle.normal,
                    decoration: TextDecoration.none,
                  ),
                ),
                const DatePickerWidget(),
                SizedBox(height: 20),
                Consumer<AppointmentViewModel>(
                  builder: (context, viewModel, child) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: viewModel.filteredAppointments.length,
                        itemBuilder: (context, index) {
                          return CardItem(cardData: viewModel.filteredAppointments[index]);
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
