import "package:firebase_core/firebase_core.dart";
import 'package:flutter/material.dart';
import 'package:license/res/colors.dart';
import 'package:license/view/document_upload.dart';
import 'package:license/view/instructor_details.dart';
import 'package:license/view/select_instructor.dart';
import 'package:license/view/forgot-password-v.dart';
import 'package:license/view/changed-password-v.dart';
import 'package:license/view_model/forgot-password-vm.dart';
import 'package:provider/provider.dart';
import 'data/remote/forgot-password-d.dart';
import 'model/forgot-password-m.dart';
import 'package:license/view/sign_up.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDjHqEsPzBzePyIdPu9S17ehvrHSb2deOc",
          appId: "1:486459417909:android:d9f6011ad27e7f79f5587c",
          messagingSenderId: "486459417909",
          projectId: "drivinglicense-437ff"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          useMaterial3: true,
        ),
        home: const ApplicationRoot(),
        routes: {
          "/forgot-password": (context) => ForgotPassword(),
          '/password-changed': (context) => const PasswordChanged(),
          "/signup": (context) => const SignUp(),
          "/select-instructor": (context) => const SelectInstructor(),
          "/document-upload": (context) => const DocumentUpload(),
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
          const SignUp(),
          ForgotPassword(),
          const SelectInstructor(),
          const DocumentUpload(),
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
              icon: Icon(Icons.home),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
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
          ],
        ));
  }
}
