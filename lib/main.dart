import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:license/view/date_picker_student.dart';
import 'package:license/view/document_upload.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDjHqEsPzBzePyIdPu9S17ehvrHSb2deOc",
        appId: "1:486459417909:android:d9f6011ad27e7f79f5587c",
        messagingSenderId: "486459417909",
        projectId: "drivinglicense-437ff",
        storageBucket: "drivinglicense-437ff.appspot.com"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const DocumentUpload(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_left_sharp),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.title),
      ),
    );
  }
}
