import 'package:license/data/remote/instructor_data.dart';
import 'package:license/res/types.dart';

class Appointment {
  // DateTime selectedDate;
  // String? selectedTime;
  InstructorData _instructorData = InstructorData();

  Future<List<Instructor>> getInstructors() async {
    return await _instructorData.getInstructors();
  }

  Appointment();
}
