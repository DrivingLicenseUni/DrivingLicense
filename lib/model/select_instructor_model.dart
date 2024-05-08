import 'package:license/data/remote/instructor_data.dart';
import 'package:license/res/types.dart';

final Map<String, Instructor> _cachedInstructors = {};

class InstructorModel {
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

  Future<void> cacheInstructors() async {
    final instructors = await getInstructors();
    for (final instructor in instructors) {
      _cachedInstructors[instructor.id] = instructor;
    }
  }

  Instructor? getCachedInstructor(String id) {
    return _cachedInstructors[id];
  }
}
