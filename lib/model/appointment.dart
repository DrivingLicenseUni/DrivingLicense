import 'package:license/data/remote/instructor_data.dart';
import 'package:license/res/types.dart';

import '../data/remote/user_data.dart';

class Appointment {
  final InstructorData _instructorData = InstructorData();
  final StudentData _studentData = StudentData();

  Future<List<Instructor>> getInstructors() async {
    return await _instructorData.getInstructors();
  }

  Future<void> removeTimeFromInstructorFromDay(
      String instructorEmail, int day, String time) async {
    await _instructorData.removeTimeFromInstructorFromDay(
        instructorEmail, day, time);
  }

  Future<void> updateInstructor(Instructor instructor) async {
    await _instructorData.updateInstructor(instructor);
  }

  Future<Map<String, List<String>>> fetchAvailableTimeSlots() async {
    return await _studentData.fetchAvailableTimeSlots();
  }
}
