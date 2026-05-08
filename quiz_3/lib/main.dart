import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/submission_list_screen.dart';

// IMPORTANT: Replace with your actual Supabase credentials
const String supabaseUrl = 'https://urdlwsxhmuokecmjpcqg.supabase.co';
const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVyZGx3c3hobXVva2VjbWpwY3FnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzgyMzcwNjAsImV4cCI6MjA5MzgxMzA2MH0.BPiEYNVpfZKcTBtKxl3T9d4VafNXfOzlwlpeSwBaIdE';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );
  
  runApp(const Quiz3App());
}

class Quiz3App extends StatelessWidget {
  const Quiz3App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz 3 Submission Form',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SubmissionListScreen(),
    );
  }
}
