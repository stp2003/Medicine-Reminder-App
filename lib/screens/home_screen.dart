import 'package:flutter/material.dart';
import 'package:medicine_reminder_app/constants/colors.dart';
import 'package:medicine_reminder_app/screens/newEntry/new_entry_page.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
      ),

      //?? body ->
      body: Padding(
        padding: EdgeInsets.all(2.h),
        child: Column(
          children: [
            const TopContainer(),
            SizedBox(height: 2.h),
            const Flexible(
              child: BottomContainer(),
            ),
          ],
        ),
      ),

      //?? floating action button ->
      floatingActionButton: InkResponse(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewEntryPage(),
            ),
          );
        },
        child: SizedBox(
          width: 18.w,
          height: 9.h,
          child: Card(
            color: kPrimaryColor,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(3.h),
            ),
            child: Icon(
              Icons.add_outlined,
              color: kScaffoldColor,
              size: 50.sp,
            ),
          ),
        ),
      ),
    );
  }
}

//?? top container ->
class TopContainer extends StatelessWidget {
  const TopContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(bottom: 1.h),
          child: Text(
            'Worry less. \nLive healthier.',
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(bottom: 1.h),
          child: Text(
            'Welcome to Daily Dose.',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        SizedBox(height: 2.h),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 1.h),
          child: Text(
            '0',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ],
    );
  }
}

//?? bottom container ->
class BottomContainer extends StatelessWidget {
  const BottomContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No Medicine',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }
}
