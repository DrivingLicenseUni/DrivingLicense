import 'package:license/data/remote/instructor_data.dart';
import 'package:license/res/types.dart';

class SelectInstructorModel {
  final InstructorData _instructorRepository = InstructorData();

  Future<List<Instructor>> getInstructors() async {
    try {
      return await _instructorRepository.getInstructors();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Instructor> getInstructor(String id) async {
    try {
      return await _instructorRepository.getInstructor(id);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
