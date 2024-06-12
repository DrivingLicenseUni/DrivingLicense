import 'package:flutter/material.dart';
import 'package:license/res/colors.dart';
import 'package:license/view_model/instructor_selection.dart';
import '../data/remote/user_data.dart';
import '../res/textstyle.dart';
import '../res/types.dart';

class SelectInstructor extends StatefulWidget {
  const SelectInstructor({super.key});

  @override
  State<SelectInstructor> createState() => _SelectInstructorState();
}

class _SelectInstructorState extends State<SelectInstructor> {
  String _selectedInstructorId = "";
  final InstructorSelectionViewModel _instructorSelectionViewModel =
      InstructorSelectionViewModel();
  final StudentData _studentData = StudentData();
  bool _loading = true;

  List<Instructor> _instructors = [];

  @override
  void initState() {
    super.initState();
    _fetchStudentDataAndInstructors();
  }

  Future<void> _fetchStudentDataAndInstructors() async {
    try {
      final student = await _studentData
          .getStudentByEmail(_studentData.currentUser!.email!);
      if (student != null) {
        setState(() {
          _selectedInstructorId = student.instructorId!;
        });
      }

      if (_instructorSelectionViewModel.getCachedInstructors().isNotEmpty) {
        setState(() {
          _instructors = _instructorSelectionViewModel.getCachedInstructors();
          _loading = false;
        });
        return;
      }

      await _instructorSelectionViewModel.cacheInstructors();
      setState(() {
        _instructors = _instructorSelectionViewModel.getCachedInstructors();
        _loading = false;
      });
    } catch (e) {
      // Handle errors
      print("Error fetching student data and instructors: $e");
    }
  }

  Widget _displayInstructor(Instructor instructor) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
      decoration: BoxDecoration(
        color: _selectedInstructorId == instructor.id
            ? AppColors.secondaryBlue
            : Colors.white,
        border: Border.all(
          color: _selectedInstructorId == instructor.id
              ? const Color.fromRGBO(201, 214, 230, 1)
              : const Color.fromRGBO(237, 237, 237, 1),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(instructor.image),
            radius: 45,
          ),
          SizedBox(height: 10),
          Text(
            instructor.name,
              style: AppTextStyles.headline
          ),
          TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith(
                (states) => Colors.transparent,
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/instructor-details',
                arguments: {'id': instructor.id},
              );
            },
            child: Text(
              'View Details',
              style: AppTextStyles.title.copyWith(
                color: AppColors.primary,
              ),
            ),

          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(
            child: CircularProgressIndicator(
              color: AppColors.black,
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('View instructor', style: AppTextStyles.headline),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(30, 25, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Our all instructor :',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(15),
                    itemCount: _instructors.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/instructor-details',
                            arguments: {'id': _instructors[index].id},
                          );
                        },
                        child: _displayInstructor(_instructors[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
