import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/home_screen.dart';
import 'screens/add_data_screen.dart';
import 'screens/display_data_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env");
    print("SUPABASE_URL: ${dotenv.env['SUPABASE_URL']}");
    print("SUPABASE_ANON_KEY: ${dotenv.env['SUPABASE_ANON_KEY']}");
  } catch (e) {
    print("Error loading .env file: $e");
  }

  try {
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL'] ?? '',
      anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
    );
    print("Supabase initialized successfully.");
  } catch (e) {
    print("Error initializing Supabase: $e");
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/add': (context) => const AddDataScreen(),
        '/display': (context) => DisplayDataScreen(),
      },
    );
  }
}
