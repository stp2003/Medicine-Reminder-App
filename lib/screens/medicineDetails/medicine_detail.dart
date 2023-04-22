import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicine_reminder_app/constants/colors.dart';
import 'package:sizer/sizer.dart';

class MedicineDetail extends StatefulWidget {
  const MedicineDetail({Key? key}) : super(key: key);

  @override
  State<MedicineDetail> createState() => _MedicineDetailState();
}

class _MedicineDetailState extends State<MedicineDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Details',
          style: TextStyle(
            fontFamily: 'poppins_bold',
            letterSpacing: 0.8,
          ),
        ),
        centerTitle: true,
      ),

      //?? body ->
      body: Padding(
        padding: EdgeInsets.all(2.h),
        child: Column(
          children: [
            //?? main section ->
            const MainSection(),
            //?? Extended section ->
            const ExtendedInfo(),
            const Spacer(),
            //?? text button ->
            SizedBox(
              width: 100.w,
              height: 7.h,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: kSecondaryColor,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Delete',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: kScaffoldColor),
                ),
              ),
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}

//?? main section ->
class MainSection extends StatelessWidget {
  const MainSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SvgPicture.asset(
          'assets/icons/bottle.svg',
          height: 7.h,
          color: kOtherColor,
        ),
        SizedBox(width: 2.w),
        Column(
          children: const [
            MainInfoTab(
              fieldTitle: 'Medicine Name',
              fieldInfo: 'Catapol',
            ),
            MainInfoTab(
              fieldTitle: 'Dosage',
              fieldInfo: '500 mg',
            ),
          ],
        ),
      ],
    );
  }
}

//?? main info tab ->
class MainInfoTab extends StatelessWidget {
  const MainInfoTab({
    Key? key,
    required this.fieldTitle,
    required this.fieldInfo,
  }) : super(key: key);

  //**
  final String fieldTitle;
  final String fieldInfo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.w,
      height: 10.h,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fieldTitle,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: 0.5.h),
            Text(
              fieldInfo,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }
}

//?? Extended info ->
class ExtendedInfo extends StatelessWidget {
  const ExtendedInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: const [
        ExtendedInfoTab(fieldTitle: 'Medicine Type', fieldInfo: 'Pill'),
        ExtendedInfoTab(
            fieldTitle: 'Dosage Interval',
            fieldInfo: 'Every 8 hours | 3 times a day'),
        ExtendedInfoTab(fieldTitle: 'Start Time', fieldInfo: '01:19'),
      ],
    );
  }
}

//?? Extended Info Tab ->
class ExtendedInfoTab extends StatelessWidget {
  const ExtendedInfoTab({
    Key? key,
    required this.fieldTitle,
    required this.fieldInfo,
  }) : super(key: key);

  //**
  final String fieldTitle;
  final String fieldInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: Text(
              fieldTitle,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: kTextColor,
                  ),
            ),
          ),
          Text(
            fieldInfo,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: kSecondaryColor,
                ),
          ),
        ],
      ),
    );
  }
}
