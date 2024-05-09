import 'package:flutter/material.dart';
import 'package:license/res/colors.dart';
import 'package:license/res/types.dart';
import 'package:license/view_model/instructor_selection.dart';

class SelectInstructor extends StatefulWidget {
  const SelectInstructor({super.key});

  @override
  State<SelectInstructor> createState() => _SelectInstructorState();
}

class _SelectInstructorState extends State<SelectInstructor> {
  String _selectedInstructorId = "";
  final InstructorSelectionViewModel _instructorSelectionViewModel =
      InstructorSelectionViewModel();

  List<Instructor> _instructors = [];

  @override
  void initState() {
    super.initState();
    if (_instructorSelectionViewModel.getCachedInstructors().isNotEmpty) {
      setState(() {
        _instructors = _instructorSelectionViewModel.getCachedInstructors();
      });
      return;
    }

    _instructorSelectionViewModel.cacheInstructors();

    _instructorSelectionViewModel.cacheInstructors().then((value) {
      setState(() {
        _instructors = _instructorSelectionViewModel.getCachedInstructors();
      });
    });
  }

  Widget _displayInstructor(Instructor instructor) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
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
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Image.network(
              instructor.image,
              height: 75,
              width: 75,
            ),
          ),
          Text(
            instructor.name,
            style: TextStyle(
                fontSize: 20,
                color: AppColors.black,
                fontWeight: FontWeight.w400),
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
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _confirmationButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Visibility(
            visible: _selectedInstructorId != "",
            child: FloatingActionButton(
              backgroundColor: AppColors.primary,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/login',
                );
              },
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Instructor',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(10, 5, 0, 0),
            child: const Text(
              'Select an instructor',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(57, 56, 56, 1),
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            itemCount: _instructors.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (_selectedInstructorId.isNotEmpty) {
                    setState(() {
                      _selectedInstructorId = "";
                    });
                  } else {
                    setState(() {
                      _selectedInstructorId = _instructors[index].id;
                    });
                  }
                },
                child: _displayInstructor(_instructors[index]),
              );
            },
          ),
        ],
      ),
      floatingActionButton: _confirmationButton(),
    );
  }
}
