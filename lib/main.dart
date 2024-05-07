import "package:firebase_core/firebase_core.dart";
import 'package:flutter/material.dart';
import 'package:license/view/forgot-password-p.dart';
import 'package:license/view/changed-password-p.dart';
import 'package:license/view_model/forgot-password-vm.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDjHqEsPzBzePyIdPu9S17ehvrHSb2deOc",
          appId: "1:486459417909:android:d9f6011ad27e7f79f5587c",
          messagingSenderId: "486459417909",
          projectId: "drivinglicense-437ff"));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ForgotPasswordViewModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/forgotPassword'
            '',
        routes: {
          '/forgotPassword': (context) => ForgotPassword(),
          '/passwordChanged': (context) => const PasswordChanged(),
        },
      ),
    )
  );
  }