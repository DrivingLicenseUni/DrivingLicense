import "package:firebase_core/firebase_core.dart";
import 'package:flutter/material.dart';
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
                ForgotPasswordModel(ForgotPasswordRemoteData()))),
      ],
      child: MaterialApp(
        title: 'Driving License',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: const SignUp(),
        routes: {
          "/forgot-password": (context) => ForgotPassword(),
          '/password-changed': (context) => const PasswordChanged(),
          "/signup": (context) => const SignUp(),
        },
      ),
    );
  }
}
