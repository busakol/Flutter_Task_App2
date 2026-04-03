import 'package:flutter/material.dart';
import 'package:flutter_task_app/views/splash_screen_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  //กำหนดค่าการติดต่อกับ Project บน Supabase ที่จะทำงานด้วย
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://yultnczqqgievqhxsano.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl1bHRuY3pxcWdpZXZxaHhzYW5vIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzUyMDc4OTQsImV4cCI6MjA5MDc4Mzg5NH0.CibGTqR_31FkVN1AFudtUn7DWgM3luTJsZkt0cqa02M',
  );

  //----------------------------
  runApp(
    FlutterTaskApp(),
  );
}

class FlutterTaskApp extends StatelessWidget {
  const FlutterTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenUi(),
      theme: ThemeData(
        textTheme: GoogleFonts.promptTextTheme(),
      ),
    );
  }
}
