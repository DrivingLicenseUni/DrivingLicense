import 'package:flutter/material.dart';
import 'package:license/res/colors.dart';
import 'package:license/view_model/instructor_dashboard.dart';
import 'package:provider/provider.dart';

class InstructorDashboardView extends StatelessWidget {
  const InstructorDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InstructorDashboardViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Instructor Dashboard'),
          backgroundColor: AppColors.primary, // Use AppColors.primary
        ),
        body: Consumer<InstructorDashboardViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromRGBO(46, 96, 247, 1)),
                ),
              );
            }

            return DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    indicatorColor: AppColors.primary, // Use AppColors.primary
                    tabs: [
                      Tab(
                        child: Text(
                          'Instructors',
                          style: TextStyle(
                              color:
                                  AppColors.primary), // Use AppColors.primary
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Students',
                          style: TextStyle(
                              color:
                                  AppColors.primary), // Use AppColors.primary
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildInstructorsList(viewModel),
                        _buildStudentsList(viewModel),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInstructorsList(InstructorDashboardViewModel viewModel) {
    return ListView.builder(
      itemCount: viewModel.instructors.length,
      itemBuilder: (context, index) {
        final instructor = viewModel.instructors[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(instructor.image),
          ),
          title: Text(
            instructor.name,
            style: TextStyle(color: AppColors.primary), // Use AppColors.primary
          ),
          subtitle: Text(
            instructor.role,
            style: TextStyle(
                color: AppColors.placeholder), // Use AppColors.placeholder
          ),
          trailing: DropdownButton<String>(
            value: instructor.role,
            dropdownColor: AppColors
                .secondaryLightBlue, // Use AppColors.secondaryLightBlue
            onChanged: (newRole) {
              viewModel.updateInstructorRole(instructor, newRole!);
            },
            items: const [
              DropdownMenuItem(
                value: 'Instructor',
                child: Text('Instructor'),
              ),
              DropdownMenuItem(
                value: 'Student',
                child: Text('Student'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStudentsList(InstructorDashboardViewModel viewModel) {
    return ListView.builder(
      itemCount: viewModel.students.length,
      itemBuilder: (context, index) {
        final student = viewModel.students[index];
        return ListTile(
          leading: const CircleAvatar(
            backgroundColor: Color.fromRGBO(46, 96, 247, 1),
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          title: Text(
            student.fullName,
            style: TextStyle(color: AppColors.primary),
          ),
          subtitle: Text(
            student.role,
            style: TextStyle(color: AppColors.placeholder),
          ),
          trailing: DropdownButton<String>(
            value: student.role,
            dropdownColor: AppColors.secondaryLightBlue,
            onChanged: (newRole) {
              viewModel.updateStudentRole(student, newRole!);
            },
            items: const [
              DropdownMenuItem(
                value: 'Student',
                child: Text('Student'),
              ),
            ],
          ),
        );
      },
    );
  }
}
