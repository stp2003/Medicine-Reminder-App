import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicine_reminder_app/constants/colors.dart';
import 'package:medicine_reminder_app/global_bloc.dart';
import 'package:medicine_reminder_app/models/error.dart';
import 'package:medicine_reminder_app/models/medicine.dart';
import 'package:medicine_reminder_app/models/medicine_type.dart';
import 'package:medicine_reminder_app/screens/successScreen/success_screen.dart';
import 'package:medicine_reminder_app/utils/convert_time.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'new_entry_bloc.dart';

class NewEntryPage extends StatefulWidget {
  const NewEntryPage({Key? key}) : super(key: key);

  @override
  State<NewEntryPage> createState() => _NewEntryPageState();
}

class _NewEntryPageState extends State<NewEntryPage> {
  //** TEC ->
  late TextEditingController nameController;
  late TextEditingController dosageController;

  //** global key ->
  late GlobalKey<ScaffoldState> _scaffoldKey;

  //**
  late NewEntryBloc _newEntryBloc;

  //?? init ->
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    dosageController = TextEditingController();
    _newEntryBloc = NewEntryBloc();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    initializeErrorListen();
  }

  //?? dispose ->
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    dosageController.dispose();
    _newEntryBloc.dispose();
  }

  //?? build ->
  @override
  Widget build(BuildContext context) {
    //**
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Add New',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 0.8,
          ),
        ),
        centerTitle: true,
      ),

      //?? body ->
      body: Provider<NewEntryBloc>.value(
        value: _newEntryBloc,
        child: Padding(
          padding: EdgeInsets.all(2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //** for medicine name ->
              const PanelTitle(
                title: 'Medicine Name',
                isRequired: true,
              ),
              //?? TFF for name->
              TextFormField(
                maxLength: 15,
                controller: nameController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                ),
                textCapitalization: TextCapitalization.words,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: kOtherColor,
                    ),
              ),

              //** for medicine quantity ->
              const PanelTitle(
                title: 'Dosage in mg',
                isRequired: false,
              ),
              //?? TFF for quantity ->
              TextFormField(
                maxLength: 15,
                controller: dosageController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                ),
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.number,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: kOtherColor,
                    ),
              ),
              SizedBox(height: 2.h),

              //?? Medicine type images ->
              const PanelTitle(title: 'Medicine Type', isRequired: false),
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: StreamBuilder<MedicineType>(
                  stream: _newEntryBloc.selectedMedicineType,
                  builder: (context, snapshot) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MedicineTypeColumn(
                          medicineType: MedicineType.Bottle,
                          name: 'Bottle',
                          iconValue: 'assets/icons/bottle.svg',
                          isSelected: snapshot.data == MedicineType.Bottle
                              ? true
                              : false,
                        ),
                        MedicineTypeColumn(
                          medicineType: MedicineType.Pill,
                          name: 'Pill',
                          iconValue: 'assets/icons/pill.svg',
                          isSelected:
                              snapshot.data == MedicineType.Pill ? true : false,
                        ),
                        MedicineTypeColumn(
                          medicineType: MedicineType.Syringe,
                          name: 'Syringe',
                          iconValue: 'assets/icons/syringe.svg',
                          isSelected: snapshot.data == MedicineType.Syringe
                              ? true
                              : false,
                        ),
                        MedicineTypeColumn(
                          medicineType: MedicineType.Tablet,
                          name: 'Tablet',
                          iconValue: 'assets/icons/tablet.svg',
                          isSelected: snapshot.data == MedicineType.Tablet
                              ? true
                              : false,
                        ),
                      ],
                    );
                  },
                ),
              ),

              //?? Interval Selection ->
              const PanelTitle(title: 'Interval Selection', isRequired: true),
              const IntervalSelection(),

              //??
              const PanelTitle(title: 'Starting Time', isRequired: true),
              const SelectedTime(),
              SizedBox(height: 3.h),

              //??
              Padding(
                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                child: SizedBox(
                  width: 90.w,
                  height: 8.h,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onPressed: () {
                      String? medicineName;
                      int? dosage;

                      //** medicine Name ->
                      if (nameController.text == "") {
                        _newEntryBloc.submitError(EntryError.nameNull);
                        return;
                      }
                      if (nameController.text != "") {
                        medicineName = nameController.text;
                      }
                      //** dosage ->
                      if (dosageController.text == "") {
                        dosage = 0;
                      }
                      if (dosageController.text != "") {
                        dosage = int.parse(dosageController.text);
                      }
                      for (var medicine in globalBloc.medicineList$!.value) {
                        if (medicineName == medicine.medicineName) {
                          _newEntryBloc.submitError(EntryError.nameDuplicate);
                          return;
                        }
                      }
                      if (_newEntryBloc.selectIntervals!.value == 0) {
                        _newEntryBloc.submitError(EntryError.interval);
                        return;
                      }
                      if (_newEntryBloc.selectedTimeOfDay$!.value == 'None') {
                        _newEntryBloc.submitError(EntryError.startTime);
                        return;
                      }

                      String medicineType = _newEntryBloc
                          .selectedMedicineType!.value
                          .toString()
                          .substring(13);

                      int interval = _newEntryBloc.selectIntervals!.value;
                      String startTime =
                          _newEntryBloc.selectedTimeOfDay$!.value;

                      List<int> intIDs =
                          makeIDs(24 / _newEntryBloc.selectIntervals!.value);

                      List<String> notificationIDs =
                          intIDs.map((i) => i.toString()).toList();

                      Medicine newEntryMedicine = Medicine(
                        notificationIDs: notificationIDs,
                        medicineName: medicineName,
                        dosage: dosage,
                        medicineType: medicineType,
                        interval: interval,
                        startTime: startTime,
                      );

                      //** update medicine list via global bloc ->
                      globalBloc.updateMedicineList(newEntryMedicine);

                      //** schedule notification ->
                      // scheduleNotification(newEntryMedicine);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SuccessScreen(),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        'Confirm',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: kScaffoldColor),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //?? init error  ->
  void initializeErrorListen() {
    _newEntryBloc.errorState$!.listen((EntryError error) {
      switch (error) {
        case EntryError.nameNull:
          displayError("Please enter the medicine's name");
          break;

        case EntryError.nameDuplicate:
          displayError("Medicine name already exists");
          break;
        case EntryError.dosage:
          displayError("Please enter the dosage required");
          break;
        case EntryError.interval:
          displayError("Please select the reminder's interval");
          break;
        case EntryError.startTime:
          displayError("Please select the reminder's starting time");
          break;
        default:
      }
    });
  }

  //?? display error in snack bar ->
  void displayError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kOtherColor,
        content: Text(error),
        duration: const Duration(milliseconds: 2000),
      ),
    );
  }

  //?? make ids ->
  List<int> makeIDs(double n) {
    var rng = Random();
    List<int> ids = [];
    for (int i = 0; i < n; i++) {
      ids.add(rng.nextInt(1000000000));
    }
    return ids;
  }
}

//?? select time ->
class SelectedTime extends StatefulWidget {
  const SelectedTime({Key? key}) : super(key: key);

  @override
  State<SelectedTime> createState() => _SelectedTimeState();
}

class _SelectedTimeState extends State<SelectedTime> {
  //**
  TimeOfDay _time = const TimeOfDay(hour: 0, minute: 00);
  bool _clicked = false;

  //??
  Future<TimeOfDay> _selectTime() async {
    final NewEntryBloc newEntryBloc =
        Provider.of<NewEntryBloc>(context, listen: false);

    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _time);

    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        _clicked = true;

        newEntryBloc.updateTime(convertTime(_time.hour.toString()) +
            convertTime(_time.minute.toString()));
      });
    }
    return picked!;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8.h,
      child: Padding(
        padding: EdgeInsets.only(top: 2.h),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: kPrimaryColor,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          onPressed: () {
            _selectTime();
          },
          child: Center(
            child: Text(
              _clicked == false
                  ? "Select Time"
                  : "${convertTime(_time.hour.toString())}:${convertTime(_time.minute.toString())}",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

//?? Interval Selection ->
class IntervalSelection extends StatefulWidget {
  const IntervalSelection({Key? key}) : super(key: key);

  @override
  State<IntervalSelection> createState() => _IntervalSelectionState();
}

class _IntervalSelectionState extends State<IntervalSelection> {
  final _intervals = [6, 8, 12, 24];

  var _selected = 0;

  @override
  Widget build(BuildContext context) {
    //**
    final NewEntryBloc newEntryBloc = Provider.of<NewEntryBloc>(context);
    return Padding(
      padding: EdgeInsets.only(top: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Remind me every',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: kTextColor,
                ),
          ),
          DropdownButton(
            iconEnabledColor: kOtherColor,
            dropdownColor: cardColor,
            itemHeight: 8.h,
            hint: _selected == 0
                ? Text(
                    'Select an Interval',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: kPrimaryColor,
                        ),
                  )
                : null,
            elevation: 4,
            value: _selected == 0 ? null : _selected,
            items: _intervals.map(
              (int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(
                    value.toString(),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: kSecondaryColor,
                        ),
                  ),
                );
              },
            ).toList(),
            onChanged: (newVal) {
              setState(
                () {
                  _selected = newVal!;
                  newEntryBloc.updateInterval(newVal);
                },
              );
            },
          ),
          Text(
            _selected == 1 ? " hour" : " hours",
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: kTextColor),
          ),
        ],
      ),
    );
  }
}

//?? Medicine Type ->
class MedicineTypeColumn extends StatelessWidget {
  const MedicineTypeColumn({
    Key? key,
    required this.medicineType,
    required this.name,
    required this.iconValue,
    required this.isSelected,
  }) : super(key: key);

  //**
  final MedicineType medicineType;
  final String name;
  final String iconValue;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    //**
    final NewEntryBloc newEntryBloc = Provider.of<NewEntryBloc>(context);

    return GestureDetector(
      onTap: () {
        newEntryBloc.updateSelectedMedicine(medicineType);
      },
      child: Column(
        children: [
          //?? image pill ->
          Container(
            width: 20.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.h),
              color: isSelected ? kOtherColor : Colors.white,
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                child: SvgPicture.asset(
                  iconValue,
                  height: 7.h,
                  color: isSelected ? Colors.white : kOtherColor,
                ),
              ),
            ),
          ),

          //?? name pill ->
          Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: Container(
              width: 20.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: isSelected ? kOtherColor : Colors.transparent,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Center(
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: isSelected ? Colors.white : kOtherColor,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//?? panel title ->
class PanelTitle extends StatelessWidget {
  //**
  final String title;
  final bool isRequired;

  const PanelTitle({
    Key? key,
    required this.title,
    required this.isRequired,
  }) : super(key: key);

  //?? build ->
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: title,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            TextSpan(
              text: isRequired ? " *" : "",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: kPrimaryColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
