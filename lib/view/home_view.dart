import 'package:flutter/material.dart';
import 'package:license/res/types.dart';
import 'package:license/view/selected_instructor_v.dart';
import 'package:provider/provider.dart';
import 'package:license/res/colors.dart';
import 'package:license/view_model/home_vm.dart';
import 'package:license/view_model/sign_in_logic.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  LoginViewModel _loginViewModel = LoginViewModel();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            "assets/images/logo-h-v.png",
            fit: BoxFit.cover,
            height: 40,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Consumer<HomeViewModel>(
                  builder: (context, viewModel, child) {
                    final student = viewModel.currentStudent;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 37.0,
                              backgroundImage: student?.profileImageUrl != null
                                  ? NetworkImage(student!.profileImageUrl)
                                  : AssetImage("assets/default-image.png")
                                      as ImageProvider,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Welcome Back!",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.placeholder,
                                  ),
                                ),
                                Text(
                                  student?.fullName ?? "Loading...",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.notifications_none,
                              color: AppColors.black, size: 40),
                          onPressed: () {
                            _loginViewModel.signOut(context);
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              ReminderCard(),
              _buildServiceCategories(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCategories(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Text(
            "Service categories:",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w400,
              color: AppColors.placeholder,
            ),
          ),
        ),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          crossAxisSpacing: 16,
          mainAxisSpacing: 5,
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          children: <Widget>[
            _buildCategoryItem(
                context, "Exams", "assets/images/exams.png", const HomeView()),
            _buildCategoryItem(context, "Instructor",
                "assets/images/instructor.png", const SelectInstructor()),
            _buildCategoryItem(context, "Theory", "assets/images/theory.png",
                const HomeView()),
            _buildCategoryItem(context, "Booking", "assets/images/booking.png",
                const HomeView()),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryItem(BuildContext context, String title,
      String assetPath, Widget destinationPage) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Card(
          clipBehavior: Clip.antiAlias,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
          shadowColor: Colors.grey.withOpacity(0.5),
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => destinationPage),
            ),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Image.asset(assetPath),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            title,
            style: TextStyle(
              color: AppColors.placeholder,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}

class ReminderCard extends StatelessWidget {
  ReminderCard({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context, listen: false);

    return FutureBuilder<Student?>(
      future: viewModel.fetchCurrentStudent(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text("Error");
        } else {
          final student = snapshot.data!;
          return FutureBuilder<Instructor>(
            future: viewModel.getInstructorById(student.instructorId!),
            builder: (context, instructorSnapshot) {
              if (instructorSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (instructorSnapshot.hasError) {
                return const Text("Error");
              } else {
                final instructor = instructorSnapshot.data!;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 6.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Remind you:",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            color: AppColors.placeholder,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: AppColors.primary,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(instructor.image),
                        ),
                        title: Text(
                          student.instructorName!,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Owner',
                              style: TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.calendar_today,
                                    color: Colors.white70, size: 20),
                                SizedBox(width: 5),
                                Text(
                                  'Sunday, 12 June',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.access_time,
                                    color: Colors.white70, size: 20),
                                SizedBox(width: 2),
                                Text(
                                  '11:00 AM',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing:
                            Icon(Icons.arrow_forward_ios, color: Colors.white),
                      ),
                    ),
                  ],
                );
              }
            },
          );
        }
      },
    );
  }
}
