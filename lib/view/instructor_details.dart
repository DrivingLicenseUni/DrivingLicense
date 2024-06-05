import 'package:flutter/material.dart';
import 'package:license/res/colors.dart';
import 'package:license/res/types.dart';
import 'package:license/view_model/instructor_selection.dart';

class InstructorDetails extends StatefulWidget {
  final String id;
  const InstructorDetails({super.key, required this.id});

  @override
  State<InstructorDetails> createState() => _InstructorDetailsState();
}

class _InstructorDetailsState extends State<InstructorDetails> {
  late final String id = widget.id;
  Instructor _instructor = Instructor(
    id: "",
    name: "",
    email: "",
    image: "",
    desc: "",
    role: "Instructor",
    availableTimes: {},
  );
  bool _isLoading = true;
  final InstructorSelectionViewModel _instructorSelectionViewModel =
      InstructorSelectionViewModel();

  @override
  void initState() {
    super.initState();

    if (_instructorSelectionViewModel.getCachedInstructor(id) != null) {
      final instructor = _instructorSelectionViewModel.getCachedInstructor(id);
      setState(() {
        _instructor = instructor!;
        _isLoading = false;
      });
      return;
    }

    _instructorSelectionViewModel.cacheInstructors().then((_) {
      final instructor = _instructorSelectionViewModel.getCachedInstructor(id);
      setState(() {
        _instructor = instructor!;
        _isLoading = false;
      });
    });
  }

  Widget _loading() {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.black,
      ),
    );
  }

  Widget _instructorName() {
    return Center(
      child: Text(
        _instructor.name,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          color: AppColors.black,
        ),
      ),
    );
  }

  Widget _instructorImage() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: Image.network(
        _instructor.image,
        // square
        width: 300,
        height: 300,
      ),
    );
  }

  Widget _instructorDescription() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
      child: Text(
        _instructor.desc,
        style: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w400,
          color: AppColors.black,
        ),
      ),
    );
  }

  Widget _instructorDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            _instructorName(),
            _instructorImage(),
            _instructorDescription(),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Instructor Details",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? _loading()
          : SingleChildScrollView(
              child: _instructorDetails(),
            ),
    );
  }
}
