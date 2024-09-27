// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:realmen_staff_application/data/models/daily_plan_account_model.dart';
import 'package:realmen_staff_application/data/models/daily_plan_model.dart';
import 'package:realmen_staff_application/data/shared_preferences/auth_pref.dart';
import 'package:realmen_staff_application/repository/DailyPlanRepo/daily_plan_repository.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class WorkScheduleDataSource extends CalendarDataSource {
  List<WorkSchedule> source;
  WorkScheduleDataSource(this.source);

  @override
  List<dynamic> get appointments => source;

  @override
  DateTime getStartTime(int index) {
    return source[index].startTime!;
  }

  @override
  DateTime getEndTime(int index) {
    return source[index].endTime!;
  }

  @override
  String getSubject(int index) {
    return source[index].subject!;
  }

  @override
  Color getColor(int index) {
    return source[index].color!;
  }

  @override
  Future<void> handleLoadMore(DateTime startDate, DateTime endDate) async {
    final IDailyPlanRepository dailyPlanRepository = DailyPlanRepository();
    final _accountId = int.tryParse(AuthPref.getAccountId());

    try {
      // Lấy dữ liệu từ API
      var dailyPlans =
          await dailyPlanRepository.getDailyPlanForStaff(startDate, endDate);

      var dailyPlansStatus = dailyPlans["status"];
      var dailyPlansBody = dailyPlans["body"];

      if (dailyPlansStatus) {
        List<WorkSchedule> newWorkSchedules = [];

        // Chuyển đổi dữ liệu từ API thành danh sách WorkSchedule
        var dailyPlanList = (dailyPlansBody['values'] as List)
            .map((e) => DailyPlanModel.fromJson(e as Map<String, dynamic>))
            .toList();
        for (DailyPlanModel dailyPlan in dailyPlanList) {
          try {
            var dailyPlanById = await dailyPlanRepository
                .getDailyPlanById(dailyPlan.dailyPlanId!);
            var dailyPlansStatus = dailyPlanById["status"];
            var dailyPlansBody = dailyPlanById["body"];
            if (dailyPlansStatus) {
              //dailyPlanAccounts
              dailyPlan.dailyPlanAccounts =
                  DailyPlanModel.fromJson(dailyPlansBody['value'])
                      .dailyPlanAccounts;
              dailyPlan.dailyPlanAccounts = dailyPlan.dailyPlanAccounts!
                  .where((e) => e.accountId == _accountId)
                  .toList();
            }
          } catch (e) {}
        }
        for (DailyPlanModel dailyPlan in dailyPlanList) {
          DateTime startTime = DateTime.parse(dailyPlan.date.toString());
          DateTime endTime = DateTime.parse(dailyPlan.date.toString());

          for (DailyPlanAccountModel dailyPlanAccount
              in dailyPlan.dailyPlanAccounts!) {
            if (dailyPlanAccount.shiftCode == "MORNING_SHIFT") {
              startTime =
                  DateTime(startTime.year, startTime.month, startTime.day, 7);
              endTime = DateTime(endTime.year, endTime.month, endTime.day, 15);
              WorkSchedule workSchedule = WorkSchedule(
                startTime: startTime,
                endTime: endTime,
                color: Colors.deepOrange.shade400,
                subject: "MORNING",
              );
              newWorkSchedules.add(workSchedule);
            } else if (dailyPlanAccount.shiftCode == "NIGHT_SHIFT") {
              startTime =
                  DateTime(startTime.year, startTime.month, startTime.day, 15);
              endTime = DateTime(endTime.year, endTime.month, endTime.day, 23);
              WorkSchedule workSchedule = WorkSchedule(
                startTime: startTime,
                endTime: endTime,
                color: Colors.deepPurple.shade400,
                subject: "NIGHT",
              );
              newWorkSchedules.add(workSchedule);
            }
          }
        }

        // Thêm dữ liệu mới vào danh sách hiện có và thông báo cập nhật
        appointments.addAll(newWorkSchedules);
        notifyListeners(CalendarDataSourceAction.add, newWorkSchedules);
      }
    } catch (e) {
      print("Error while loading more data: $e");
    }
    // String shiftMorning = "MORNING";
    // String shiftNight = "NIGHT";
    // Color colorMorning = Colors.deepOrange.shade400;
    // Color colorNight = Colors.deepPurple.shade400;

    // List<WorkSchedule> loadedAppointment = [
    //   // SANG
    //   WorkSchedule(
    //     startTime: DateTime(2024, 8, 14, 7, 0, 0),
    //     endTime: DateTime(2024, 8, 14, 15, 0, 0),
    //     color: colorMorning,
    //     subject: shiftMorning,
    //   ),
    //   WorkSchedule(
    //     startTime: DateTime(2024, 8, 17, 7, 0, 0),
    //     endTime: DateTime(2024, 8, 17, 15, 0, 0),
    //     color: colorMorning,
    //     subject: shiftMorning,
    //   ),
    //   WorkSchedule(
    //     startTime: DateTime(2024, 8, 16, 7, 0, 0),
    //     endTime: DateTime(2024, 8, 16, 15, 0, 0),
    //     color: colorMorning,
    //     subject: shiftMorning,
    //   ),

    //   // TOI
    //   WorkSchedule(
    //     startTime: DateTime(2024, 8, 21, 15, 0, 0),
    //     endTime: DateTime(2024, 8, 21, 23, 0, 0),
    //     color: colorNight,
    //     subject: shiftNight,
    //   ),
    //   WorkSchedule(
    //     startTime: DateTime(2024, 8, 23, 15, 0, 0),
    //     endTime: DateTime(2024, 8, 23, 23, 0, 0),
    //     color: colorNight,
    //     subject: shiftNight,
    //   ),

    //   // SO LE
    //   WorkSchedule(
    //     startTime: DateTime(2024, 8, 26, 7, 0, 0),
    //     endTime: DateTime(2024, 8, 26, 15, 0, 0),
    //     color: colorMorning,
    //     subject: shiftMorning,
    //   ),

    //   WorkSchedule(
    //     startTime: DateTime(2024, 8, 30, 7, 0, 0),
    //     endTime: DateTime(2024, 8, 30, 15, 0, 0),
    //     color: colorMorning,
    //     subject: shiftMorning,
    //   ),
    // ];
    // appointments.addAll(loadedAppointment);
    // notifyListeners(CalendarDataSourceAction.add, loadedAppointment);
  }
}

class WorkSchedule {
  String? subject;
  DateTime? startTime;
  DateTime? endTime;
  Color? color;
  WorkSchedule({
    this.subject,
    this.startTime,
    this.endTime,
    this.color,
  });
}
