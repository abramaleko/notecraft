import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notecraft/firebase_options.dart';
import 'package:notecraft/provider/note_provider.dart';
import 'package:notecraft/routes/app_routes.dart';
import 'package:notecraft/services/notes_service.dart';
import 'package:notecraft/views/notes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
    create: (context) => NoteProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'NoteCraft',
      routerConfig: AppRoutes().routes,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          textTheme: GoogleFonts.robotoTextTheme()),
      // home: Notes(),
      debugShowCheckedModeBanner: false,
    );
  }
}
