import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:license/view_model/date_picker.dart';
import 'package:license/res/textstyle.dart';
import 'package:license/res/colors.dart';
import 'package:license/view_model/instructor_selection.dart';

class DatePickerInstructor extends StatefulWidget {
  const DatePickerInstructor({super.key, this.restorationId});

  final String? restorationId;

  @override
  State<DatePickerInstructor> createState() => _DatePickerInstructorState();
}

class _DatePickerInstructorState extends State<DatePickerInstructor> {
  final DatePickerViewModel _viewModel = DatePickerViewModel();
  final InstructorSelectionViewModel _selectionViewModel =
      InstructorSelectionViewModel();
  bool _canEdit = false;
  TimeOfDay? _selectedTime;
  DateTime? _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar', style: AppTextStyles.headline),
        actions: const [
          CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon(Icons.person),
          ),
          SizedBox(width: 17.0),
        ],
        centerTitle: true,
        toolbarHeight: 83,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 11.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    const Text(
                      'Select Date',
                      style: AppTextStyles.title,
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      color: AppColors.primary,
                      onPressed: () {
                        setState(() {
                          _canEdit = !_canEdit;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            _buildDatePicker(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
          ],
        ),
      ),
      floatingActionButton: !_canEdit
          ? const SizedBox()
          : FloatingActionButton(
              onPressed: () {
                _showTimePicker();
              },
              backgroundColor: AppColors.primary,
              child: const Icon(
                Icons.access_time,
                color: Colors.white,
              ),
            ),
    );
  }

  Widget _buildDatePicker() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryBlue,
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.fromLTRB(13, 0, 13, 19),
      child: CalendarDatePicker(
        initialDate: _viewModel.selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 6)),
        onDateChanged: (date) {
          _viewModel.selectDate(date);
          setState(() {
            _selectedDate = date;
          });
        },
        selectableDayPredicate: (DateTime date) {
          // Allow selection only if the date is not booked
          return !_viewModel.bookedDates.contains(date);
        },
      ),
    );
  }

  Widget _buildTimeSlots() {
    return FutureBuilder<List<String>>(
      future: _viewModel.loadAvailableTimes(_selectedDate!.day),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  // snapshot.data!.values.expand((times) => times).map((time) {
                  snapshot.data!.map((time) {
                return Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      if (_canEdit) {
                        _viewModel.removeTime(_selectedDate!.day, time).then(
                          (value) {
                            setState(() {});
                          },
                        );
                      } else {
                        _viewModel.selectTime(time);
                      }
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

  Future<void> _showTimePicker() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            primaryColor: AppColors.primary,
            colorScheme: ColorScheme.light(primary: AppColors.primary),
            cardColor: AppColors.secondaryBlue,
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
            timePickerTheme: TimePickerThemeData(
              dayPeriodColor: AppColors.primary,
              dayPeriodTextColor: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (time != null) {
      final instructor = await _selectionViewModel
          .getInstructorByEmail("omar_ins@instructor.com");

      final formattedTime =
          '${time.hour > 12 ? time.hour - 12 : time.hour}:${time.minute <= 9 ? "0${time.minute}" : time.minute} ${time.period == DayPeriod.am ? 'AM' : 'PM'}';

      if (instructor.availableTimes[_selectedDate!.day] == null) {
        instructor.availableTimes[_selectedDate!.day] = [formattedTime];
      } else {
        instructor.availableTimes[_selectedDate!.day]!.add(formattedTime);
      }

      await _viewModel.updateInstructor(instructor);
      setState(() {
        _selectedTime = time;
      });
    }
  }

  // Widget _buildBookNowButton() {
  //   return FilledButton(
  //     style: ButtonStyle(
  //       backgroundColor: MaterialStatePropertyAll<Color>(AppColors.primary),
  //       fixedSize: MaterialStateProperty.all<Size>(const Size(283, 41)),
  //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //         RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(8.0),
  //         ),
  //       ),
  //     ),
  //     onPressed: () {
  //       _viewModel.bookNow(context);
  //     },
  //     child: Text(
  //       'Book Now',
  //       style: GoogleFonts.roboto(
  //         fontSize: 15,
  //         fontWeight: FontWeight.w500,
  //         height: 1.5,
  //         letterSpacing: 0.01,
  //         fontStyle: FontStyle.normal,
  //         decoration: TextDecoration.none,
  //       ),
  //     ),
  //   );
  // }
}
