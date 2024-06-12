import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:license/res/colors.dart';
import 'package:license/res/textstyles.dart';
import 'package:license/view_model.dart';

class DatePickerStudent extends StatefulWidget {
  const DatePickerStudent({super.key, this.restorationId});

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
    _viewModel.loadAvailableTimesForStudent(_viewModel.selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DatePickerViewModel>(
      create: (_) => _viewModel,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text('Book a Lesson', style: AppTextStyles.headline),
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
        body: Consumer<DatePickerViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15.0, bottom: 11.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Select Date',
                      style: AppTextStyles.title,
                    ),
                  ),
                ),
                _buildDatePicker(viewModel),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                  child: _buildTimeSlots(viewModel),
                ),
                const SizedBox(height: 35),
                _buildBookNowButton(viewModel),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDatePicker(DatePickerViewModel viewModel) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryBlue,
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.fromLTRB(13, 0, 13, 19),
      child: CalendarDatePicker(
        initialDate: viewModel.selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
        onDateChanged: (DateTime date) {
          if (viewModel.isDateAlreadyBooked(date)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'This date is already booked. Please select another date.'),
              ),
            );
          } else {
            viewModel.selectDate(date);
          }
        },
        selectableDayPredicate: (DateTime date) {
          return !viewModel.bookedSlots.containsKey(date);
        },
      ),
    );
  }

  Widget _buildTimeSlots(DatePickerViewModel viewModel) {
    return viewModel.availableTimes.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: viewModel.availableTimes.map((time) {
                return Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      viewModel.selectTime(time);
                    },
                    child: Container(
                      width: 78,
                      height: 40,
                      decoration: BoxDecoration(
                        color: viewModel.selectedTime == time
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

  Widget _buildBookNowButton(DatePickerViewModel viewModel) {
    return ElevatedButton(
      onPressed: () {
        if (viewModel.selectedTime != null) {
          viewModel.saveAppointment(
              'current_student_id', viewModel.selectedTime!);
          _showPaymentDialog();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please select a time before booking.'),
            ),
          );
        }
      },
      child: const Text('Book Now'),
    );
  }

  void _showPaymentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Payment Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('To Pay', style: AppTextStyles.labelIconbar),
              Text(
                '180.00 \$',
                style: AppTextStyles.title.copyWith(color: AppColors.primary),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Payment logic here
              },
              child: const Text('Pay Now'),
            ),
          ],
        );
      },
    );
  }
}
