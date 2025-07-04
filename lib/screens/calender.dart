// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';
//
// /// The hove page which hosts the calendar
// class Calender extends StatefulWidget {
//   /// Creates the home page to display teh calendar widget.
//   const Calender({Key? key}) : super(key: key);
//
//   @override
//   // ignore: library_private_types_in_public_api
//   _CalenderState createState() => _CalenderState();
// }
//
// class _CalenderState extends State<Calender> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//       child: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey,
//                     blurRadius: 4,
//                     offset: Offset(4, 8), // Shadow position
//                   ),
//                 ],
//               ),
//               child: SfCalendar(
//                 view: CalendarView.month,
//
//                 cellBorderColor: Colors.transparent,
//                 todayHighlightColor: Color(0xffFFDB2517),
//                 selectionDecoration: const BoxDecoration(
//                   color: Colors.transparent,
//                   borderRadius: BorderRadius.all(Radius.circular(4)),
//                   shape: BoxShape.rectangle,
//                 ),
//                 dataSource: MeetingDataSource(_getDataSource()),
//                 monthViewSettings: const MonthViewSettings(
//                     showAgenda: true,
//                     agendaStyle: AgendaStyle(
//                         backgroundColor: Colors.white,
//                         appointmentTextStyle: TextStyle(
//                             color: Colors.white,
//                             fontSize: 13,
//                             fontStyle: FontStyle.italic)),
//                     agendaViewHeight: 400,
//                     appointmentDisplayMode:
//                         MonthAppointmentDisplayMode.appointment),
//               ),
//             ),
//           ),
//
//         ],
//       ),
//     ),
//     );
//   }
//
//   List<Meeting> _getDataSource() {
//     final List<Meeting> meetings = <Meeting>[];
//     final DateTime today = DateTime.now();
//     final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
//     final DateTime endTime = startTime.add(const Duration(hours: 2));
//     meetings.add(Meeting(
//         'Conference', startTime, endTime, const Color(0xFF0F8644), false));
//     return meetings;
//   }
// }
//
//
// class MeetingDataSource extends CalendarDataSource {
//   /// Creates a meeting data source, which used to set the appointment
//   /// collection to the calendar
//   MeetingDataSource(List<Meeting> source) {
//     appointments = source;
//   }
//
//   @override
//   DateTime getStartTime(int index) {
//     return _getMeetingData(index).from;
//   }
//
//   @override
//   DateTime getEndTime(int index) {
//     return _getMeetingData(index).to;
//   }
//
//   @override
//   String getSubject(int index) {
//     return _getMeetingData(index).eventName;
//   }
//
//   @override
//   Color getColor(int index) {
//     return _getMeetingData(index).background;
//   }
//
//   @override
//   bool isAllDay(int index) {
//     return _getMeetingData(index).isAllDay;
//   }
//
//   Meeting _getMeetingData(int index) {
//     final dynamic meeting = appointments![index];
//     late final Meeting meetingData;
//     if (meeting is Meeting) {
//       meetingData = meeting;
//     }
//
//     return meetingData;
//   }
// }
//
// /// Custom business object class which contains properties to hold the detailed
// /// information about the event data which will be rendered in calendar.
// class Meeting {
//   /// Creates a meeting class with required details.
//   Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);
//
//   /// Event name which is equivalent to subject property of [Appointment].
//   String eventName;
//
//   /// From which is equivalent to start time property of [Appointment].
//   DateTime from;
//
//   /// To which is equivalent to end time property of [Appointment].
//   DateTime to;
//
//   /// Background which is equivalent to color property of [Appointment].
//   Color background;
//
//   /// IsAllDay which is equivalent to isAllDay property of [Appointment].
//   bool isAllDay;
// }
