import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:license/view/instructor_dashboard_.dart';
import 'package:license/view/logo-view.dart';

import 'package:license/view/notification_view.dart';

import 'package:license/view/home_page.dart';
import 'package:license/view/onboarding-v.dart';
import 'package:license/view/sign_in.dart';
import 'package:license/view/view_calendar_time_ins.dart';
import 'package:license/res/colors.dart';
import 'package:license/view/document_upload.dart';
import 'package:license/view/instructor_details.dart';
import 'package:license/view/select_instructor.dart';
import 'package:license/view/forgot_password_v.dart';
import 'package:license/view/changed_password_v.dart';
import 'package:license/view/view_calendar_time_stu.dart';
import 'package:license/view_model/forgot_password_vm.dart';
import 'package:provider/provider.dart';
import 'data/remote/forgot_password_d.dart';
import 'model/firebase-massaging.dart';
import 'model/forgot_password_m.dart';
import 'package:license/view/sign_up.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDjHqEsPzBzePyIdPu9S17ehvrHSb2deOc",
          appId: "1:486459417909:android:d9f6011ad27e7f79f5587c",
          messagingSenderId: "486459417909",
          projectId: "drivinglicense-437ff"));

  await FirebaseApi().initNotifications();

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  runApp(MyApp(user: user));
}

class MyApp extends StatelessWidget {
  final User? user;
  const MyApp({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ForgotPasswordViewModel(
            ForgotPasswordModel(
              ForgotPasswordRemoteData(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Driving License',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          primaryColor: AppColors.primary,
          focusColor: AppColors.primary,
          useMaterial3: true,
        ),
        restorationScopeId: 'app',
        home: LogoView(
          user: user,
        ),
        navigatorKey: navigatorKey,
        routes: {
          "/dashboard": (context) => const InstructorDashboardView(),
          "/forgot-password": (context) => ForgotPassword(),
          '/password-changed': (context) => const PasswordChanged(),
          "/signup": (context) => const SignUp(),
          "/select-instructor": (context) => const SelectInstructor(),
          "/document-upload": (context) => const DocumentUpload(),
          "/logo-view": (context) => LogoView(user: user),
          "/onboarding-view": (context) => const OnboardingView(),
          "/instructor-calendar": (context) =>
          const DatePickerInstructor(restorationId: 'main'),
          "/book-appointment": (context) =>
          const DatePickerStudent(restorationId: 'main'),
          '/login': (context) => const LoginView(),
          '/home-screen': (context) => HomeScreen(),
          '/application-root': (context) => const ApplicationRoot(),
          '/notification-view': (context) => NotificationView(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == "/instructor-details") {
            final args = settings.arguments as Map<String, dynamic>;
            final String id = args['id'];
            return MaterialPageRoute(
              builder: (context) => InstructorDetails(id: id),
            );
          }
          return null;
        },
      ),
    );
  }
}

class ApplicationRoot extends StatefulWidget {
  const ApplicationRoot({super.key});

  @override
  State<ApplicationRoot> createState() => _MyAppState();
}

class _MyAppState extends State<ApplicationRoot> {
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const OnboardingView(),
        const InstructorDashboardView(),
        const SelectInstructor(),
        const DocumentUpload(),
        const DatePickerInstructor(restorationId: 'main'),
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        indicatorColor: AppColors.secondaryLightBlue,
        backgroundColor: AppColors.secondaryBlue,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        shadowColor: AppColors.black,
        selectedIndex: currentPageIndex,
        height: 80,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.bookmark_border),
            selectedIcon: Icon(Icons.bookmark),
            label: 'Onboarding',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            selectedIcon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.add),
            selectedIcon: Icon(Icons.add),
            label: 'Add',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
        ],
      ),
    );
  }
}
