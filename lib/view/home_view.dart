import 'package:flutter/material.dart';
import 'package:license/res/types.dart';
import 'package:license/view/profile-page.dart';
import 'package:license/view/selected_instructor_v.dart';
import 'package:license/view/stu_progress_page.dart';
import 'package:license/view/theory_section.dart';
import 'package:license/view/view_calendar_time_stu.dart';
import 'package:provider/provider.dart';
import 'package:license/res/colors.dart';
import 'package:license/view_model/home_vm.dart';
import 'package:license/view/theory_exams_section.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
        body: [
          SingleChildScrollView(
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
                                backgroundImage:
                                student?.profileImageUrl != null
                                    ? NetworkImage(student!.profileImageUrl)
                                    : AssetImage("") as ImageProvider,
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
                              Navigator.pushNamed(
                                  context, '/notification-view');
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
          SizedBox(),
          ProfilePage(),
        ][_selectedIndex],
        bottomNavigationBar: NavigationBar(
          height: 80,
          selectedIndex: _selectedIndex,
          onDestinationSelected: onTabTapped,
          indicatorColor: AppColors.secondaryLightBlue,
          backgroundColor: AppColors.secondaryBlue,
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.show_chart),
              selectedIcon: Icon(Icons.home),
              label: 'Progress',
            ),
            NavigationDestination(
              icon: Icon(Icons.bubble_chart),
              selectedIcon: Icon(Icons.home),
              label: 'Activities',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outlined),
              selectedIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
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
                context, "Exams", "assets/images/exams.png", TheorySection()),
            _buildCategoryItem(context, "Instructor",
                "assets/images/instructor.png", const SelectInstructor()),
            _buildCategoryItem(context, "Theory", "assets/images/theory.png",
                const TheorySection()),
            _buildCategoryItem(context, "Booking", "assets/images/booking.png",
                const DatePickerStudent()),
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
      builder: (context, studentSnapshot) {
        if (studentSnapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (studentSnapshot.hasError) {
          return const Text("Error fetching student data");
        } else if (!studentSnapshot.hasData) {
          return const Text("No student data available");
        } else {
          final student = studentSnapshot.data!;
          return FutureBuilder<Instructor?>(
            future: viewModel.getInstructorById(student.instructorId!),
            builder: (context, instructorSnapshot) {
              if (instructorSnapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (instructorSnapshot.hasError) {
                return const Text("Error fetching instructor data");
              } else if (!instructorSnapshot.hasData) {
                return const Text("No instructor data available");
              } else {
                final instructor = instructorSnapshot.data!;
                return FutureBuilder<Map<String, dynamic>?>(
                  future: viewModel.fetchLastLesson(student.id!),
                  builder: (context, lessonSnapshot) {
                    if (lessonSnapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (lessonSnapshot.hasError) {
                      return const Text("Error fetching lesson data");
                    } else {
                      final lesson = lessonSnapshot.data;
                      final date = lesson?['date'] ?? 'N/A';
                      final time = lesson?['time'] ?? 'N/A';
                      final lessonText = lesson != null ? 'Next lesson:' : 'No upcoming lessons';

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
                                instructor.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    lessonText,
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
                                        date,
                                        style: TextStyle(
                                            color: Colors.white),
                                      ),
                                      SizedBox(width: 8),
                                      Icon(Icons.access_time,
                                          color: Colors.white70, size: 20),
                                      SizedBox(width: 2),
                                      Text(
                                        time,
                                        style: TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
      },
    );
  }
}
