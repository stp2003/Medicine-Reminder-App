import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicine_reminder_app/constants/colors.dart';
import 'package:medicine_reminder_app/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Medicine Reminder',
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: bgColor,
        appBarTheme: const AppBarTheme(color: appBarColor),
      ),
      home: const HomeScreen(),
    );
  }
}
