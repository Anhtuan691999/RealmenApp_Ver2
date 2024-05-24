class SchedulesModel {
  List<ScheduleModel>? scheduleModelList;

  SchedulesModel({this.scheduleModelList});

  factory SchedulesModel.fromJson(Map<String, dynamic> json) {
    return SchedulesModel(
      scheduleModelList: json['values'] != null
          ? (json['values'] as List)
              .map((e) => ScheduleModel.fromJson(e))
              .toList()
          : null,
    );
  }

  List<Map<String, dynamic>> toJson() {
    return scheduleModelList!.map((schedule) => schedule.toJson()).toList();
  }
}

class ScheduleModel {
  int? shiftId;
  int? scheduleId;
  int? staffId;
  String? shift;
  String? workingDate;
  String? startShift;
  String? endShift;
  String? scheduleStatus;

  ScheduleModel({
    this.shiftId,
    this.scheduleId,
    this.staffId,
    this.shift,
    this.workingDate,
    this.startShift,
    this.endShift,
    this.scheduleStatus,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      scheduleId: json['scheduleId'],
      staffId: json['staffId'],
      shift: json['shift'],
      workingDate: json['workingDate'],
      startShift: json['startShift'],
      endShift: json['endShift'],
      scheduleStatus: json['scheduleStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shiftId': shiftId,
      'workingDate': workingDate,
    };
  }
}
