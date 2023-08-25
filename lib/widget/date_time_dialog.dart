import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:remindly_app/controllers/event/upcoming/upcoming_controller.dart';
import 'package:remindly_app/controllers/newevent/newevent_controller.dart';
import 'package:remindly_app/utils/constants.dart';
import 'package:remindly_app/widget/app_button.dart';

import 'date_selection_container.dart';

class DateTimeDialog extends StatefulWidget {
  final String? titleText;
  String? onClick;

  DateTimeDialog({this.onClick, this.titleText});

  @override
  State<DateTimeDialog> createState() => _DateTimeDialogState();
}

class _DateTimeDialogState extends State<DateTimeDialog> {
  late double screenHeight;
  NewEventController controllerNewEvent = Get.put(NewEventController());
  DateTime currentDate = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: 350.w,
          padding: const EdgeInsets.only(left: 15, right: 15, top: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Select date time",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(
                height: 21,
              ),
              DateSelectionContainer(
                myText:
                    "${controllerNewEvent.myWeekDays[controllerNewEvent.selectedDate.weekday - 1]}, ${controllerNewEvent.selectedDate.day.toString().padLeft(2, '0')}, ${controllerNewEvent.myMonths[controllerNewEvent.selectedDate.month - 1]}",
                myOnTap: () async {
                  final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now().subtract(Duration(days: 0)),
                      lastDate: DateTime(2101));
                  if (picked != null &&
                      picked != controllerNewEvent.selectedDate)
                    setState(
                      () {
                        controllerNewEvent.selectedDate = picked;
                      },
                    );
                },
              ),
              const SizedBox(
                height: 12,
              ),
              DateSelectionContainer(
                myText: DateFormat.jm().format(DateFormat("hh:mm:ss").parse(
                    controllerNewEvent.selectedTime.hour.toString() +
                        ':' +
                        controllerNewEvent.selectedTime.minute.toString() +
                        ':00')),
                myOnTap: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay(
                      hour: DateTime.now().hour,
                      minute: DateTime.now().minute,
                    ),
                  );
                  if (picked != null &&
                      picked != controllerNewEvent.selectedTime) {
                    setState(() {
                      controllerNewEvent.selectedTime = picked;
                      String selTime = picked.hour.toString() +
                          ':' +
                          picked.minute.toString() +
                          ':00';
                      DateFormat.jm()
                          .format(DateFormat("hh:mm:ss").parse(selTime));
                    });
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: AppButton(
                    text: "Done",
                    color: Constant.secondaryColor,
                    onClick: () {
                      DateTime date = DateTime.utc(
                        controllerNewEvent.selectedDate.year,
                        controllerNewEvent.selectedDate.month,
                        controllerNewEvent.selectedDate.day,
                        controllerNewEvent.selectedTime.hour,
                        controllerNewEvent.selectedTime.minute,
                      );
                      controllerNewEvent.checkDiff(date);
                      controllerNewEvent.newDateTime = date.toIso8601String();

                      final formet = DateFormat('HH').format(date);
                      if (currentDate.day.compareTo(date.day) == 0 &&
                          currentDate.month.compareTo(date.month) == 0&&int.parse(formet) < currentDate.hour) {
                        Fluttertoast.showToast(msg: "  Invalid date  ");
                      }else {
                          controllerNewEvent.dateController.text =
                              "${controllerNewEvent.myMonths[controllerNewEvent.selectedDate.month - 1]}-${controllerNewEvent.selectedDate.day}-${controllerNewEvent.selectedDate.year}" +
                                  ", " +
                                  "${controllerNewEvent.selectedTime.hourOfPeriod}:${controllerNewEvent.selectedTime.minute.toString().padLeft(2, '0')} ${int.parse(formet) >= 12 ? "PM" : "AM"}";
                          Navigator.pop(context);
                          print(controllerNewEvent.dateController.text);
                        }


                      ;
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String format(BuildContext context, TimeOfDay time) {
  assert(debugCheckHasMediaQuery(context));
  assert(debugCheckHasMaterialLocalizations(context));
  final MaterialLocalizations localizations = MaterialLocalizations.of(context);
  return localizations.formatTimeOfDay(
    time,
    alwaysUse24HourFormat: MediaQuery.of(context).alwaysUse24HourFormat,
  );
}
