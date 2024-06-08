import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:license/res/textstyle.dart';
import 'package:license/view_model/student_progress_list.dart';
import 'package:license/view/instructor_log_progress.dart';
import 'package:provider/provider.dart';

class StudentProgressListView extends StatelessWidget {
  const StudentProgressListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StudentProgressListViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Students progress',
            style: AppTextStyles.headline,
          ),
          centerTitle: true,
          toolbarHeight: 83,
        ),
        body: Consumer<StudentProgressListViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.userList.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding: const EdgeInsets.only(top: 64.0),
              child: ListView.builder(
                itemCount: viewModel.userList.length,
                itemBuilder: (context, index) {
                  final user = viewModel.userList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      width: 350,
                      height: 80,
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InstructorLogProgress(user: user.toMap()),
                            ),
                          );
                        },
                        leading: CircleAvatar(
                          radius: 25, // Set the radius to 25 for 50x50 size
                          child: Text(user.avatarText),
                        ),
                        title: Text(
                          user.title,
                          style: AppTextStyles.labelLarge,
                        ),
                        subtitle: Text(
                          user.subtitle,
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            color: const Color(0xFFC3C8DD),
                            decoration: TextDecoration.none,
                          ),
                        ),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
