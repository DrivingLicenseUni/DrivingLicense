import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:license/view_model/date_picker.dart';
import 'package:license/res/textstyle.dart';
import 'package:license/res/colors.dart';
import '../view_model/home_vm.dart';
import 'home_view.dart';

class DatePickerStudent extends StatefulWidget {
  const DatePickerStudent({Key? key, this.restorationId}) : super(key: key);

  final String? restorationId;

  @override
  State<DatePickerStudent> createState() => _DatePickerStudentState();
}

class _DatePickerStudentState extends State<DatePickerStudent> {
  late DatePickerViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = DatePickerViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeView()),
            );
          },
        ),
        title: Text('Book a Lesson', style: AppTextStyles.headline),
        actions: [
          CircleAvatar(
            child: Icon(Icons.person),
            backgroundColor: Colors.grey,
          ),
          SizedBox(width: 17.0),
        ],
        centerTitle: true,
        toolbarHeight: 83,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 11.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Select Date',
                style: AppTextStyles.title,
              ),
            ),
          ),
          _buildDatePicker(),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Select Time Slot',
                style: AppTextStyles.title,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13),
            child: _buildTimeSlots(),
          ),
          const SizedBox(height: 35),
          _buildBookNowButton(),
        ],
      ),
    );
  }

  Widget _buildDatePicker() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryBlue,
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: EdgeInsets.fromLTRB(13, 0, 13, 19),
      child: CalendarDatePicker(
        initialDate: _viewModel.selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
        onDateChanged: _viewModel.selectDate,
        selectableDayPredicate: (DateTime date) {
          // Allow selection only if the date is not booked
          return !_viewModel.bookedDates.contains(date);
        },
      ),
    );
  }

  Widget _buildTimeSlots() {
    return FutureBuilder<List<String>>(
      future: _viewModel.loadAvailableTimesForStudent(_viewModel.selectedDate),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final availableTimes = snapshot.data!;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: availableTimes.map((time) {
                return Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      _viewModel.selectTime(time);
                    },
                    child: Container(
                      width: 78,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _viewModel.selectedTime == time
                            ? Colors.blue
                            : AppColors.secondaryBlue,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          time,
                          style: AppTextStyles.labelLarge,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }

  Widget _buildBookNowButton() {
    return FilledButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(AppColors.primary),
        fixedSize: MaterialStateProperty.all<Size>(const Size(283, 41)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      onPressed: () {
        _viewModel.bookNow(context);
      },
      child: Text(
        'Book Now',
        style: GoogleFonts.roboto(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          height: 1.5,
          letterSpacing: 0.01,
          fontStyle: FontStyle.normal,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}
