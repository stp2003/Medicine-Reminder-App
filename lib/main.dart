import 'package:flutter/material.dart'
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_reminder_app/constants/colors.dart';
import 'package:medicine_reminder_app/global_bloc.dart';
import 'package:medicine_reminder_app/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //**
  GlobalBloc? globalBloc;

  //?? init ->
  @override
  void initState() {
    globalBloc = GlobalBloc();
    super.initState();
  }

  //?? build ->
  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>.value(
      value: globalBloc!,
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Medicine Reminder',
            theme: ThemeData.dark(useMaterial3: true).copyWith(
              primaryColor: kPrimaryColor,
              scaffoldBackgroundColor: bgColor,
              appBarTheme: AppBarTheme(
                toolbarHeight: 7.h,
                backgroundColor: appBarColor,
                elevation: 0,
                iconTheme: IconThemeData(
                  color: kPrimaryColor,
                  size: 20.sp,
                ),
                titleTextStyle: GoogleFonts.mulish(
                  color: kTextColor,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.normal,
                  fontSize: 16.sp,
                ),
              ),

              textTheme: TextTheme(
                displaySmall: TextStyle(
                  fontSize: 28.sp,
                  color: kSecondaryColor,
                  fontWeight: FontWeight.w500,
                ),
                headlineMedium: GoogleFonts.poppins(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: kTextColor,
                ),
                headlineSmall: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w900,
                  color: kTextColor,
                ),
                titleLarge: GoogleFonts.poppins(
                  fontSize: 13.sp,
                  color: kTextColor,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.0,
                ),
                titleMedium:
                    GoogleFonts.poppins(fontSize: 15.sp, color: kPrimaryColor),
                titleSmall: GoogleFonts.poppins(
                    fontSize: 12.sp, color: kTextLightColor),
                bodySmall: GoogleFonts.poppins(
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w400,
                  color: kTextLightColor,
                ),
                labelMedium: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: kScaffoldColor,
                ),
              ),
              inputDecorationTheme: const InputDecorationTheme(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: kTextLightColor,
                    width: 0.7,
                  ),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: kTextLightColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor),
                ),
              ),

              //** customize the timePicker theme ->
              timePickerTheme: TimePickerThemeData(
                backgroundColor: cardColor,
                hourMinuteColor: appBarColor,
                hourMinuteTextColor: kScaffoldColor,
                dayPeriodColor: appBarColor,
                dayPeriodTextColor: kScaffoldColor,
                dialBackgroundColor: appBarColor,
                dialHandColor: kPrimaryColor,
                dialTextColor: kScaffoldColor,
                entryModeIconColor: kOtherColor,
                dayPeriodTextStyle: GoogleFonts.aBeeZee(
                  fontSize: 8.sp,
                ),
              ),
            ),
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
