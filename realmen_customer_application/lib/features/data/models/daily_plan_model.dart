// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import 'package:realmen_customer_application/features/data/models/daily_plan_account_model.dart';
import 'package:realmen_customer_application/features/data/models/daily_plan_service_model.dart';

class DailyPlanModel extends Equatable {
  int? weeklyPlanId;
  int? dailyPlanId;
  String? date;
  String? dayInWeekCode;
  String? dayInWeekName;
  String? dailyPlanStatusCode;
  String? dailyPlanStatusName;
  List<DailyPlanAccountModel>? dailyPlanAccounts;
  List<DailyPlanServiceModel>? dailyPlanServices;
  DailyPlanModel({
    this.weeklyPlanId,
    this.dailyPlanId,
    this.date,
    this.dayInWeekCode,
    this.dayInWeekName,
    this.dailyPlanStatusCode,
    this.dailyPlanStatusName,
    this.dailyPlanAccounts,
    this.dailyPlanServices,
  });
  @override
  List<Object?> get props => [
        weeklyPlanId,
        dailyPlanId,
        date,
        dayInWeekCode,
        dayInWeekName,
        dailyPlanStatusCode,
        dailyPlanStatusName,
        dailyPlanAccounts,
        dailyPlanServices,
      ];

  factory DailyPlanModel.fromMap(Map<String, dynamic> map) {
    return DailyPlanModel(
      weeklyPlanId:
          map['weeklyPlanId'] != null ? map['weeklyPlanId'] as int : null,
      dailyPlanId:
          map['dailyPlanId'] != null ? map['dailyPlanId'] as int : null,
      date: map['date'] != null ? map['date'] as String : null,
      dayInWeekCode:
          map['dayInWeekCode'] != null ? map['dayInWeekCode'] as String : null,
      dayInWeekName:
          map['dayInWeekName'] != null ? map['dayInWeekName'] as String : null,
      dailyPlanStatusCode: map['dailyPlanStatusCode'] != null
          ? map['dailyPlanStatusCode'] as String
          : null,
      dailyPlanStatusName: map['dailyPlanStatusName'] != null
          ? map['dailyPlanStatusName'] as String
          : null,
      dailyPlanAccounts: map['dailyPlanAccounts'] != null
          ? (map['dailyPlanAccounts'] as List)
              .map((e) =>
                  DailyPlanAccountModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      dailyPlanServices: map['dailyPlanServices'] != null
          ? (map['dailyPlanServices'] as List)
              .map((e) =>
                  DailyPlanServiceModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  factory DailyPlanModel.fromJson(Map<String, dynamic> source) =>
      DailyPlanModel.fromMap(source);
}
