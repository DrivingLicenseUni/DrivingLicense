import 'package:license/data/remote/instructor_data.dart';
import 'package:license/res/types.dart';

class Appointment {
  // DateTime selectedDate;
  // String? selectedTime;
  final InstructorData _instructorData = InstructorData();

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
}
