import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(this.source);
  List<Appointment> source;
  @override
  List<dynamic> get appointments => source;
}
