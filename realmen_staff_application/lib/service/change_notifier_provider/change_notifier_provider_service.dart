import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ChangeNotifierServices extends ChangeNotifier {
  List<String> _selectedServices = [];
  dynamic _selectedBranch;
  dynamic _selectedStylist;
  List<TimeRegion> _specialTimeRegions = <TimeRegion>[];

  List<TimeRegion> get specialTimeRegions => _specialTimeRegions;

  List<String> get selectedServices => _selectedServices;
  String get selectedBranch => _selectedBranch;
  dynamic get selectedStylist => _selectedStylist;

  void updateSelectedServices(List<String> services) {
    _selectedServices = services;
    notifyListeners();
  }

  void updateSelectedBranch(dynamic branch) {
    _selectedBranch = branch;
    notifyListeners();
  }

  void updateSelectedStylist(dynamic stylist) {
    _selectedStylist = stylist;
    notifyListeners();
  }

  set specialTimeRegions(List<TimeRegion> value) {
    _specialTimeRegions = value;
    notifyListeners();
  }

  void removeSpecialTimeRegion(Appointment selectedAppointment) {
    _specialTimeRegions.removeWhere((region) =>
        region.startTime.isAtSameMomentAs(selectedAppointment.startTime) &&
        region.endTime.isAtSameMomentAs(selectedAppointment.endTime));
    notifyListeners();
  }
}
