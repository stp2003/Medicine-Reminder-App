import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicine_reminder_app/constants/colors.dart';
import 'package:medicine_reminder_app/global_bloc.dart';
import 'package:medicine_reminder_app/models/medicine.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MedicineDetail extends StatefulWidget {
  const MedicineDetail({
    Key? key,
    required this.medicine,
  }) : super(key: key);

  //**
  final Medicine medicine;

  @override
  State<MedicineDetail> createState() => _MedicineDetailState();
}

class _MedicineDetailState extends State<MedicineDetail> {
  @override
  Widget build(BuildContext context) {
    //**
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);

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
            MainSection(
              medicine: widget.medicine,
            ),
            //?? Extended section ->
            ExtendedInfo(
              medicine: widget.medicine,
            ),
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
                onPressed: () {
                  openAlertBox(context, globalBloc);
                },
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

  //?? alert dialog box ->
  openAlertBox(BuildContext context, GlobalBloc globalBloc) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: appBarColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          contentPadding: EdgeInsets.only(top: 1.h),
          title: Text(
            'Delete This Reminder?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                globalBloc.removeMedicine(widget.medicine);
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text(
                'OK',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: kSecondaryColor),
              ),
            ),
          ],
        );
      },
    );
  }
}

//?? main section ->
class MainSection extends StatelessWidget {
  const MainSection({
    Key? key,
    this.medicine,
  }) : super(key: key);

  //**
  final Medicine? medicine;

  @override
  Widget build(BuildContext context) {
    //??
    Hero makeIcon(double size) {
      if (medicine!.medicineType == 'Bottle') {
        return Hero(
          tag: medicine!.medicineName! + medicine!.medicineType!,
          child: SvgPicture.asset(
            'assets/icons/bottle.svg',
            color: kOtherColor,
            height: 7.h,
          ),
        );
      } else if (medicine!.medicineType == 'Pill') {
        return Hero(
          tag: medicine!.medicineName! + medicine!.medicineType!,
          child: SvgPicture.asset(
            'assets/icons/pill.svg',
            color: kOtherColor,
            height: 7.h,
          ),
        );
      } else if (medicine!.medicineType == 'Syringe') {
        return Hero(
          tag: medicine!.medicineName! + medicine!.medicineType!,
          child: SvgPicture.asset(
            'assets/icons/syringe.svg',
            color: kOtherColor,
            height: 7.h,
          ),
        );
      } else if (medicine!.medicineType == 'Tablet') {
        return Hero(
          tag: medicine!.medicineName! + medicine!.medicineType!,
          child: SvgPicture.asset(
            'assets/icons/tablet.svg',
            color: kOtherColor,
            height: 7.h,
          ),
        );
      }
      //** in case of no medicine type icon selection ->
      return Hero(
        tag: medicine!.medicineName! + medicine!.medicineType!,
        child: Icon(
          Icons.error,
          color: kOtherColor,
          size: size,
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        makeIcon(7.h),
        SizedBox(width: 2.w),
        Column(
          children: [
            Hero(
              tag: medicine!.medicineName!,
              child: Material(
                color: Colors.transparent,
                child: MainInfoTab(
                  fieldTitle: 'Medicine Name',
                  fieldInfo: medicine!.medicineName!,
                ),
              ),
            ),
            Hero(
              tag: medicine!.interval!,
              child: MainInfoTab(
                fieldTitle: 'Dosage',
                fieldInfo: medicine!.dosage == 0
                    ? 'Not Specified'
                    : "${medicine!.dosage} mg",
              ),
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
  const ExtendedInfo({
    Key? key,
    this.medicine,
  }) : super(key: key);

  //**
  final Medicine? medicine;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        ExtendedInfoTab(
          fieldTitle: 'Medicine Type',
          fieldInfo: medicine!.medicineType! == 'None'
              ? 'Not Specified'
              : medicine!.medicineType!,
        ),
        ExtendedInfoTab(
          fieldTitle: 'Dosage Interval',
          fieldInfo:
              'Every ${medicine!.interval} hours  |  ${medicine!.interval == 24 ? "One time a day" : "${(24 / medicine!.interval!).floor()} times a day"}',
        ),
        ExtendedInfoTab(
          fieldTitle: 'Start Time',
          fieldInfo:
              '${medicine!.startTime![0]}${medicine!.startTime![1]}:${medicine!.startTime![2]}${medicine!.startTime![3]}',
        ),
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
