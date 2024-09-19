// ignore_for_file: must_be_immutable, avoid_print, unused_local_variable, avoid_unnecessary_containers, library_private_types_in_public_api, non_constant_identifier_names

import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:realmen_customer_application/features/data/models/account_model.dart';
import 'package:realmen_customer_application/features/presentation/booking/bloc/booking_bloc.dart';

class BCSChooseTimeSlot extends StatefulWidget {
  final BookingBloc bloc;
  final AccountModel selectedStaff;
  BCSChooseTimeSlot({
    super.key,
    required this.bloc,
    required this.selectedStaff,
  });

  @override
  State<BCSChooseTimeSlot> createState() => _BCSChooseTimeSlotState();
}

class _BCSChooseTimeSlotState extends State<BCSChooseTimeSlot> {
  @override
  Widget build(BuildContext context) {
    return listDate!.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(5),
              //   child: Container(
              //     padding: const EdgeInsets.only(
              //         left: 10, right: 0, top: 5, bottom: 5),
              //     decoration: BoxDecoration(
              //       border: Border.all(
              //         color: Colors.grey,
              //         width: 1,
              //         style: BorderStyle.solid,
              //       ),
              //       borderRadius: BorderRadius.circular(5),
              //       color: Colors.white,
              //       boxShadow: const [
              //         BoxShadow(
              //           color: Colors.black26,
              //           offset: Offset(0, 1.5),
              //           blurRadius: 1,
              //           spreadRadius: 0,
              //         ),
              //       ],
              //     ),
              //     child: Container(
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         // mainAxisSize: MainAxisSize.min,
              //         children: [
              //           Align(
              //             alignment: Alignment.centerLeft,
              //             child: Container(
              //               child: const Icon(
              //                 Icons.calendar_today,
              //                 color: Colors.black,
              //                 size: 24,
              //               ),
              //             ),
              //           ),
              //           Expanded(
              //             child: Align(
              //               alignment: Alignment.centerLeft,
              //               child: DropdownButtonHideUnderline(
              //                 child: DropdownButton2(
              //                   isExpanded: true,
              //                   alignment: Alignment.center,
              //                   value: dateController,
              //                   items: listDate != null
              //                       ? listDate
              //                           ?.asMap()
              //                           .entries
              //                           .map(
              //                             (item) => DropdownMenuItem(
              //                               value: item.value['id'],
              //                               child: Container(
              //                                 padding: const EdgeInsets.only(
              //                                     top: 5, bottom: 5, left: 0),
              //                                 // width: 220,
              //                                 // height: 40,
              //                                 child: Row(
              //                                   mainAxisAlignment:
              //                                       MainAxisAlignment
              //                                           .spaceBetween,
              //                                   children: [
              //                                     Row(
              //                                       children: [
              //                                         Container(
              //                                           margin: const EdgeInsets
              //                                               .only(left: 10.0),
              //                                           child: Align(
              //                                             alignment: Alignment
              //                                                 .centerLeft,
              //                                             child: Text(
              //                                               item.value['date']
              //                                                   as String,
              //                                               style: const TextStyle(
              //                                                   fontSize: 15,
              //                                                   fontWeight:
              //                                                       FontWeight
              //                                                           .w400,
              //                                                   color: Colors
              //                                                       .black),
              //                                             ),
              //                                           ),
              //                                         ),
              //                                       ],
              //                                     ),
              //                                     item.value['type'] ==
              //                                             "Ngày thường"
              //                                         ? Container(
              //                                             width: 100,
              //                                             padding:
              //                                                 const EdgeInsets
              //                                                     .symmetric(
              //                                                     horizontal: 5,
              //                                                     vertical: 5),
              //                                             decoration:
              //                                                 const BoxDecoration(
              //                                               color: Color(
              //                                                   0xff207A20),
              //                                             ),
              //                                             child: const Center(
              //                                               child: Text(
              //                                                 "Ngày thường",
              //                                                 style: TextStyle(
              //                                                   fontSize: 14,
              //                                                   fontWeight:
              //                                                       FontWeight
              //                                                           .w700,
              //                                                   color: Colors
              //                                                       .white,
              //                                                 ),
              //                                               ),
              //                                             ),
              //                                           )
              //                                         : Container(
              //                                             width: 100,
              //                                             padding:
              //                                                 const EdgeInsets
              //                                                     .symmetric(
              //                                                     horizontal: 5,
              //                                                     vertical: 5),
              //                                             decoration:
              //                                                 const BoxDecoration(
              //                                               color: Color(
              //                                                   0xff964444),
              //                                             ),
              //                                             child: const Center(
              //                                               child: Text(
              //                                                 "Cuối tuần",
              //                                                 style: TextStyle(
              //                                                   fontSize: 14,
              //                                                   fontWeight:
              //                                                       FontWeight
              //                                                           .w700,
              //                                                   color: Colors
              //                                                       .white,
              //                                                 ),
              //                                               ),
              //                                             ),
              //                                           ),
              //                                   ],
              //                                 ),
              //                               ),
              //                             ),
              //                           )
              //                           .toList()
              //                       : [],
              //                   onChanged: (value) {
              //                     // setstate
              //                     // setState(() {
              //                     //   dateController = value as String?;
              //                     //   dateSeleted = listDate!
              //                     //       .where((date) =>
              //                     //           date['id'] == value.toString())
              //                     //       .toList()
              //                     //       .first;
              //                     //   print("onchange: $dateSeleted");
              //                     //   type = dateSeleted!['type'].toString();
              //                     //   type == "Thứ bảy" || type == "Chủ nhật"
              //                     //       ? type = "Cuối tuần"
              //                     //       : type = "Ngày thường";
              //                     //   isCurrentDate =
              //                     //       _isCurrentDate(dateSeleted!['date']);
              //                     //   widget.onDateSelected(dateSeleted);
              //                     //   if (widget.oneToOne) {
              //                     //     widget.choseDateUpdateStylist!(
              //                     //         dateSeleted!['chosenDate']);
              //                     //   } else {
              //                     //     getTimeSlot(dateSeleted!['chosenDate']);
              //                     //   }
              //                     // });

              //                     // timeSlotKey.currentState?.rebuildTimeslot();
              //                   },
              //                   dropdownStyleData: DropdownStyleData(
              //                     maxHeight: 200,
              //                     width: 325,
              //                     padding: const EdgeInsets.all(0),
              //                     decoration: BoxDecoration(
              //                       // borderRadius: BorderRadius.circular(14),
              //                       color: Colors.grey.shade200,
              //                     ),
              //                     offset: const Offset(-35, -6),
              //                     scrollbarTheme: ScrollbarThemeData(
              //                       // radius: const Radius.circular(40),
              //                       // thickness: MaterialStateProperty.all(6),
              //                       thumbVisibility:
              //                           MaterialStateProperty.all(true),
              //                     ),
              //                   ),
              //                   menuItemStyleData: const MenuItemStyleData(
              //                     height: 40,
              //                     padding: EdgeInsets.only(left: 35, right: 24),
              //                   ),
              //                   buttonStyleData: const ButtonStyleData(
              //                     padding: EdgeInsets.all(0),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 10),
              // SizedBox(
              //   height: 200,
              //   child:
              //   TimeSlot(
              //     key: timeSlotKey,
              //     dateSeleted: dateSeleted,
              //     isCurrentDate: isCurrentDate,
              //     onTimeSelected: widget.onTimeSelected,
              //     onDateSelected: widget.onDateSelected,
              //     stylistSelected: widget.stylistSelected,
              //     timeSlotModel: timeSlotModel,
              //     openBranch: widget.openBranch,
              //     closeBranch: widget.closeBranch,
              //   ),
              // ),
            ],
          )
        : Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                    "Thợ cắt ${widget.selectedStaff.firstName!.substring(widget.selectedStaff!.firstName!.lastIndexOf(" ") + 1)} ${widget.selectedStaff!.lastName!} hiện chưa có lịch làm!"),
              ),
              const Center(
                child: Text("Anh vui lòng chọn thợ cắt khác"),
              )
            ],
          );
  }

  // Logic
  // GlobalKey<_TimeSlotState> timeSlotKey = GlobalKey();
  bool isCurrentDate = true;
  bool isActived = false;
  String? dateController;
  Map<String, dynamic>? dateSeleted;
  String type = "Ngày thường";
  List<Map<String, dynamic>>? listDate = [];
  bool isLoading = true;
  @override
  void initState() {
    //
    // getDate();
    // dateController = listDate?.first['id'].toString();
    // dateSeleted = listDate?.first;
    // type = listDate!.first['type'].toString();
    // // getTimeSlot(dateSeleted!['chosenDate']);

    // widget.onDateSelected(dateController);
    super.initState();
  }

  // @override
  // void didUpdateWidget(ChooseDateAndTimeSlot oldWidget) {
  //   getDate();
  //   if (widget.isChangeStylist != null && widget.isChangeStylist! == true) {
  //     if (listDate!.isNotEmpty) {
  //       dateController = listDate?.first['id'].toString();
  //       dateSeleted = listDate?.first;
  //       print("didUpdateWidget: $dateController");
  //       type = listDate!.first['type'].toString();
  //       timeSlotKey.currentState?.rebuildTimeslot();
  //       setState(() {
  //         widget.isChangeStylist = false;
  //         isCurrentDate = _isCurrentDate(dateSeleted!['date']);
  //       });
  //       getTimeSlot(dateSeleted!['chosenDate']);
  //     }

  //     build(context);
  //   }

  //   super.didUpdateWidget(oldWidget);
  // }

  // hàm để lấy date cho dropdown
  // Future<void> getDate() async {
  //   DateTime now = DateTime.now();
  //   listDate = [];
  //   // nếu kh phải opt OTO
  //   if (!widget.oneToOne) {
  //     if (widget.stylistSelected?.staff?.scheduleList == null) {
  //       for (int i = 0; i <= 2; i++) {
  //         listDate?.add({
  //           'id': i.toString(),
  //           'date': formatDate(now.add(Duration(days: i)))['date'],
  //           'type': formatDate(now.add(Duration(days: i)))['type'],
  //           'chosenDate':
  //               "${formatDate(now.add(Duration(days: i)))['chosenDate']}",
  //         });
  //       }
  //     } else {
  //       try {
  //         //scheduleList
  //         widget.stylistSelected?.staff!.scheduleList!
  //             .asMap()
  //             .entries
  //             .map((schedule) {
  //           DateTime workingDate = DateTime.parse(schedule.value.workingDate!);
  //           DateTime nowFullDate = DateTime(now.year, now.month, now.day, 0);
  //           // // kiểm tra = now
  //           // bool checkNow = workingDate == nowFullDate;
  //           // // kiểm tra workingDate > now
  //           // bool checkIsAfter = workingDate.isAfter(now);
  //           // // kiểm tra workingDate < now + 4 ngày
  //           // bool checkIsBefore =
  //           //     workingDate.isBefore(now.add(const Duration(days: 4)));

  //           // bool checkBetween = checkIsAfter && checkIsBefore;

  //           // lấy những ca làm trong 3 ngày
  //           if (listDate!.isNotEmpty) {
  //             listDate!.removeWhere((date) =>
  //                 date['dateTime'] ==
  //                 "${DateTime.parse(schedule.value.workingDate!)}");
  //           }
  //           if (DateTime.parse(schedule.value.workingDate!) ==
  //                   DateTime(now.year, now.month, now.day, 0) ||
  //               (DateTime.parse(schedule.value.workingDate!).isAfter(now) &&
  //                   DateTime.parse(schedule.value.workingDate!)
  //                       .isBefore(now.add(const Duration(days: 2))))) {
  //             listDate?.add({
  //               'id': schedule.key.toString(),
  //               'date': formatDate(
  //                   DateTime.parse(schedule.value.workingDate!))['date'],
  //               'type': formatDate(
  //                   DateTime.parse(schedule.value.workingDate!))['type'],
  //               'chosenDate': formatDate(
  //                   DateTime.parse(schedule.value.workingDate!))['chosenDate'],
  //               'start': schedule.value.startShift,
  //               'end': schedule.value.endShift,
  //               'dateTime': "${DateTime.parse(schedule.value.workingDate!)}",
  //             });
  //           }
  //         }).toList();

  //         listDate!.sort(((a, b) => a['dateTime'].compareTo(b['dateTime'])));

  //         if (!_isDisposed && mounted) {
  //           setState(() {
  //             listDate;
  //           });
  //         }
  //       } on Exception catch (e) {
  //         listDate?.add({
  //           'date': formatDate(now.add(const Duration(days: 1)))['date'],
  //           'type': formatDate(now.add(const Duration(days: 1)))['type'],
  //           'chosenDate':
  //               "${formatDate(now.add(const Duration(days: 1)))['chosenDate']}",
  //         });

  //         print(e.toString());
  //       }
  //     }
  //     //
  //   } else {
  //     // Option One To One
  //     try {
  //       // nếu stylist đã đc chọn != post booking
  //       // TH có random
  //       // nếu có 1 stylist kiểm tra các acc trong random có cùng ca làm kh
  //       if (widget.staffOneToOne!.length != widget.serviceOTOList!.length) {
  //         // random
  //         if (!_isDisposed && mounted) {
  //           try {
  //             // if chưa chọn stylist - full random
  //             if (widget.staffOneToOne!.isEmpty) {
  //               for (int i = 0; i <= 2; i++) {
  //                 listDate?.add({
  //                   'id': i.toString(),
  //                   'date': formatDate(now.add(Duration(days: i)))['date'],
  //                   'type': formatDate(now.add(Duration(days: i)))['type'],
  //                   'chosenDate':
  //                       "${formatDate(now.add(Duration(days: i)))['chosenDate']}",
  //                 });
  //               }
  //             } else {
  //               // lấy thằng đầu làm mốc
  //               // thay đổi lịch là thay đổi ngi
  //               widget.accountStaffBranchList!.first.staff!.scheduleList!
  //                   .asMap()
  //                   .entries
  //                   .map((schedule) {
  //                 DateTime workingDate =
  //                     DateTime.parse(schedule.value.workingDate!);
  //                 DateTime nowFullDate =
  //                     DateTime(now.year, now.month, now.day, 0);

  //                 // ktr lịch dropdown đã có data
  //                 if (listDate!.isNotEmpty) {
  //                   // xóa trùng lịch
  //                   listDate!.removeWhere((date) =>
  //                       date['dateTime'] ==
  //                       "${DateTime.parse(schedule.value.workingDate!)}");
  //                 }
  //                 // ktr lịch làm của acc có hợp đk 3 ngày
  //                 if (DateTime.parse(schedule.value.workingDate!) ==
  //                         DateTime(now.year, now.month, now.day, 0) ||
  //                     (DateTime.parse(schedule.value.workingDate!)
  //                             .isAfter(now) &&
  //                         DateTime.parse(schedule.value.workingDate!)
  //                             .isBefore(now.add(const Duration(days: 2))))) {
  //                   // add lịch dropdrown
  //                   listDate?.add({
  //                     'id': schedule.key.toString(),
  //                     'date': formatDate(
  //                         DateTime.parse(schedule.value.workingDate!))['date'],
  //                     'type': formatDate(
  //                         DateTime.parse(schedule.value.workingDate!))['type'],
  //                     'chosenDate': formatDate(DateTime.parse(
  //                         schedule.value.workingDate!))['chosenDate'],
  //                     'start': schedule.value.startShift,
  //                     'end': schedule.value.endShift,
  //                     'dateTime':
  //                         "${DateTime.parse(schedule.value.workingDate!)}",
  //                   });
  //                 }
  //               }).toList();
  //               listDate!
  //                   .sort(((a, b) => a['dateTime'].compareTo(b['dateTime'])));
  //             }

  //             if (!_isDisposed && mounted) {
  //               setState(() {
  //                 listDate;
  //               });
  //             }
  //           } on Exception catch (e) {
  //             print(e.toString());
  //             print("Error: $e");
  //           }
  //         }
  //       }
  //       // TH chọn đủ stylist
  //       else {
  //         // staffOneToOne là stylist chọn theo service
  //         for (var stafOneToOneElement in widget.staffOneToOne!) {
  //           // lấy lịch làm của staff đã chọn
  //           stafOneToOneElement.staff!.scheduleList!
  //               .asMap()
  //               .entries
  //               .map((schedule) {
  //             DateTime workingDate =
  //                 DateTime.parse(schedule.value.workingDate!);
  //             DateTime nowFullDate = DateTime(now.year, now.month, now.day, 0);

  //             // lấy những ca làm trong 3 ngày
  //             if (listDate!.isNotEmpty) {
  //               // xóa trùng
  //               listDate!.removeWhere((date) =>
  //                   date['dateTime'] ==
  //                   "${DateTime.parse(schedule.value.workingDate!)}");
  //             }
  //             if (DateTime.parse(schedule.value.workingDate!) ==
  //                     DateTime(now.year, now.month, now.day, 0) ||
  //                 (DateTime.parse(schedule.value.workingDate!).isAfter(now) &&
  //                     DateTime.parse(schedule.value.workingDate!)
  //                         .isBefore(now.add(const Duration(days: 2))))) {
  //               listDate?.add({
  //                 'id': schedule.key.toString(),
  //                 'date': formatDate(
  //                     DateTime.parse(schedule.value.workingDate!))['date'],
  //                 'type': formatDate(
  //                     DateTime.parse(schedule.value.workingDate!))['type'],
  //                 'chosenDate':
  //                     formatDate(DateTime.parse(schedule.value.workingDate!))[
  //                         'chosenDate'],
  //                 'start': schedule.value.startShift,
  //                 'end': schedule.value.endShift,
  //                 'dateTime': "${DateTime.parse(schedule.value.workingDate!)}",
  //               });
  //             }
  //           }).toList();

  //           listDate!.sort(((a, b) => a['dateTime'].compareTo(b['dateTime'])));

  //           if (!_isDisposed && mounted) {
  //             setState(() {
  //               listDate;
  //             });
  //           }
  //         }
  //       }
  //       if (listDate!.isEmpty) {
  //         for (int i = 0; i <= 2; i++) {
  //           listDate?.add({
  //             'id': i.toString(),
  //             'date': formatDate(now.add(Duration(days: i)))['date'],
  //             'type': formatDate(now.add(Duration(days: i)))['type'],
  //             'chosenDate':
  //                 "${formatDate(now.add(Duration(days: i)))['chosenDate']}",
  //           });
  //         }
  //       }
  //     } on Exception catch (e) {
  //       listDate?.add({
  //         'date': formatDate(now.add(const Duration(days: 1)))['date'],
  //         'type': formatDate(now.add(const Duration(days: 1)))['type'],
  //         'chosenDate':
  //             "${formatDate(now.add(const Duration(days: 1)))['chosenDate']}",
  //       });

  //       print(e.toString());
  //     }
  //   }
  // }

  Map<String, dynamic> formatDate(DateTime date) {
    String day = DateFormat('EEEE').format(date);
    day = formatDay(day);
    return {
      'date': "$day, ${DateFormat('dd/MM/yyyy').format(date)}",
      'type':
          day == "Thứ bảy" || day == "Chủ nhật" ? "Cuối tuần" : "Ngày thường",
      // ignore: unnecessary_string_interpolations
      'chosenDate': "${DateFormat('yyyy-MM-dd').format(date)}"
    };
  }

  bool _isCurrentDate(dynamic dateSelected) {
    DateTime now = DateTime.now();
    String? dateNow = formatDate(now.add(const Duration(days: 0)))['date'];
    if (dateSelected.toString() == dateNow) {
      return true;
    } else {
      return false;
    }
  }

  String formatDay(String day) {
    return dayNames[day.toLowerCase()] ?? day;
  }

  final Map<String, String> dayNames = {
    'monday': 'Thứ hai',
    'tuesday': 'Thứ ba',
    'wednesday': 'Thứ tư',
    'thursday': 'Thứ năm',
    'friday': 'Thứ sáu',
    'saturday': 'Thứ bảy',
    'sunday': 'Chủ nhật'
  };
  // List<TimeSlotModel> timeSlotModel = [];
  // tạo data List timeslot để ktr timeslot ava/una
  // Future<void> getTimeSlot(dateSeleted) async {
  //   if (!_isDisposed && mounted) {
  //     if (!widget.oneToOne) {
  //       final chosenDate = dateSeleted;
  //       if (widget.stylistSelected != null &&
  //           widget.stylistSelected!.accountId != null) {
  //         final staffId = widget.stylistSelected?.staff!.staffId;
  //         if (chosenDate != null && staffId != null) {
  //           try {
  //             TimeSlotService timeSlotService = TimeSlotService();
  //             final result =
  //                 await timeSlotService.getTimeSlot(chosenDate, staffId);
  //             if (result['statusCode'] == 200) {
  //               timeSlotModel = result['data'];
  //               if (!_isDisposed && mounted) {
  //                 // gọi didupdate
  //                 setState(() {
  //                   timeSlotModel;
  //                 });
  //               }
  //             } else {
  //               print(result['error']);
  //               if (!_isDisposed && mounted) {
  //                 setState(() {});
  //               }
  //             }
  //           } catch (e) {
  //             print(e.toString());
  //             if (_isDisposed && mounted) {
  //               setState(() {});
  //             }
  //           }
  //         }
  //       } else {
  //         // tạo timslot cho random cua stylist
  //         if (widget.accountStaffList != null) {
  //           for (AccountInfoModel staffElement in widget.accountStaffList!) {
  //             final staffId = staffElement.staff!.staffId;
  //             if (chosenDate != null && staffId != null) {
  //               try {
  //                 TimeSlotService timeSlotService = TimeSlotService();
  //                 final result =
  //                     await timeSlotService.getTimeSlot(chosenDate, staffId);
  //                 if (result['statusCode'] == 200) {
  //                   timeSlotModel.addAll(result['data']);
  //                 } else {
  //                   print(result['message']);
  //                 }
  //               } catch (e) {
  //                 print(e.toString());
  //               }
  //             }
  //           }
  //           if (!_isDisposed && mounted) {
  //             setState(() {
  //               timeSlotModel;
  //             });
  //           }
  //         } else {
  //           if (!_isDisposed && mounted) {
  //             setState(() {
  //               timeSlotModel = [];
  //             });
  //           }
  //         }
  //       }
  //     }
  //     // Option One To One
  //     // set Timeslot data
  //     else {
  //       // ngày đã chọn
  //       final chosenDate = dateSeleted;
  //       //ktra stylist đã chọn có chứa random kh
  //       // TH chứa random
  //       if (widget.staffOneToOne!.length != widget.serviceOTOList!.length) {
  //         // reset data
  //         timeSlotModel = [];
  //         // clone data
  //         List<AccountInfoModel>? accountStaffList =
  //             List<AccountInfoModel>.from(widget.accountStaffBranchList!);
  //         // TH đã có ít nhất 1 stylist đã chọn
  //         if (widget.staffOneToOne!.isNotEmpty) {
  //           try {
  //             // xóa những acc kh cùng ca làm của branch
  //             // lấy từng acc của branch
  //             accountStaffList.removeWhere((accountStaff) {
  //               if (accountStaff.staff!.staffId ==
  //                   widget.staffOneToOne!.first.staff!.staffId) {
  //                 return false;
  //               }
  //               // lấy lịch làm của acc của branch
  //               for (var accountSchedule in accountStaff.staff!.scheduleList!) {
  //                 // lấy lịch làm của stylist đã chọn đầu tiên
  //                 for (var staffSchedule
  //                     in widget.staffOneToOne!.first.staff!.scheduleList!) {
  //                   // ktr ngày lich làm của cả 2 có = ngày đã chọn
  //                   if (accountSchedule.workingDate == chosenDate &&
  //                       staffSchedule.workingDate == chosenDate) {
  //                     // nếu 2 ca làm giống nhau -> kh xóa
  //                     if (accountSchedule.shiftId == staffSchedule.shiftId) {
  //                       return false;
  //                     }
  //                   }
  //                 } // ktra hết lịch làm của stylist đã chọn đầu tiên
  //                 // vs 1 lịch làm của acc branch
  //               } // ktr hết
  //               // nếu chưa return là kh chứa -> xóa
  //               return true;
  //             });
  //           } on Exception catch (e) {}
  //         }

  //         // lấy từng stylist đã chọn để lấy timeslot
  //         // timeslot là tổng hợp tất cả stlist đã chọn
  //         for (var staffOneToOneElement in accountStaffList) {
  //           final staffId = staffOneToOneElement.staff!.staffId;
  //           if (chosenDate != null && staffId != null) {
  //             try {
  //               TimeSlotService timeSlotService = TimeSlotService();
  //               final result =
  //                   await timeSlotService.getTimeSlot(chosenDate, staffId);
  //               if (result['statusCode'] == 200) {
  //                 timeSlotModel.addAll(result['data']);
  //                 if (!_isDisposed && mounted) {
  //                   setState(() {
  //                     timeSlotModel;
  //                   });
  //                 }
  //               } else {
  //                 print(result['error']);
  //                 if (!_isDisposed && mounted) {
  //                   setState(() {});
  //                 }
  //               }
  //             } catch (e) {
  //               print(e.toString());
  //               if (_isDisposed && mounted) {
  //                 setState(() {});
  //               }
  //             }
  //           }
  //         }
  //       }
  //       // khi stylist đã chọn đủ
  //       else {
  //         // reset data
  //         timeSlotModel = [];
  //         // lấy từng stylist đã chọn
  //         // lấy tất cả timeslot của staffOneToOne
  //         for (var staffOneToOneElement in widget.staffOneToOne!) {
  //           final chosenDate = dateSeleted;
  //           final staffId = staffOneToOneElement.staff!.staffId;
  //           if (chosenDate != null && staffId != null) {
  //             try {
  //               TimeSlotService timeSlotService = TimeSlotService();
  //               final result =
  //                   await timeSlotService.getTimeSlot(chosenDate, staffId);
  //               if (result['statusCode'] == 200) {
  //                 timeSlotModel.addAll(result['data']);
  //                 if (!_isDisposed && mounted) {
  //                   setState(() {
  //                     timeSlotModel;
  //                   });
  //                 }
  //               } else {
  //                 print(result['error']);
  //                 if (!_isDisposed && mounted) {
  //                   setState(() {});
  //                 }
  //               }
  //             } catch (e) {
  //               print(e.toString());
  //               if (_isDisposed && mounted) {
  //                 setState(() {});
  //               }
  //             }
  //           }
  //         }
  //       }
  //     }
  //   }
  // }
}

// class TimeSlot extends StatefulWidget {
//   const TimeSlot({
//     super.key,
//     required this.dateSeleted,
//     required this.timeSlotModel,
//     required this.onTimeSelected,
//     required this.onDateSelected,
//     required this.isCurrentDate,
//     required this.stylistSelected,
//     required this.openBranch,
//     required this.closeBranch,
//   });
//   final Map<String, dynamic>? dateSeleted;
//   final bool isCurrentDate;
//   final void Function(dynamic time) onTimeSelected;
//   final void Function(dynamic time) onDateSelected;
//   final AccountInfoModel? stylistSelected;
//   final List<TimeSlotModel> timeSlotModel;

//   final String openBranch;
//   final String closeBranch;

//   @override
//   _TimeSlotState createState() => _TimeSlotState();
// }

// class _TimeSlotState extends State<TimeSlot> {
//   String _selectedTimeSlot = ''; // Track selected time slot

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void didUpdateWidget(TimeSlot oldWidget) {
//     setState(() {
//       build(context);
//     });

//     super.didUpdateWidget(oldWidget);
//   }

//   void rebuildTimeslot() {
//     setState(() {
//       _selectedTimeSlot = '';
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           width: 80,
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,
//               style: BorderStyle.solid,
//               width: 1,
//             ),
//             borderRadius: BorderRadius.circular(5),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const Text(
//                 "Giờ hẹn:",
//                 style: TextStyle(fontSize: 20),
//               ),
//               Text(
//                 _selectedTimeSlot,
//                 style: const TextStyle(fontSize: 23),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(
//           width: 5,
//         ),
//         Center(
//           child: SizedBox(
//             width: 230.0,
//             height: 220.0, // Limit height

//             child: TimeSlotGrid(
//               dateSeleted: widget.dateSeleted,
//               isCurrentDate: widget.isCurrentDate,
//               selectedTimeSlot: _selectedTimeSlot,
//               onTimeSlotSelected: _onTimeSlotSelected,
//               stylistSelected: widget.stylistSelected,
//               timeSlotModel: widget.timeSlotModel,
//               openBranch: widget.openBranch,
//               closeBranch: widget.closeBranch,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   void _onTimeSlotSelected(String timeSlot) {
//     setState(() {
//       if (timeSlot == _selectedTimeSlot) {
//         // Deselect the time slot if it's already selected
//         _selectedTimeSlot = '';
//         widget.onTimeSelected(_selectedTimeSlot);
//         widget.onDateSelected(widget.dateSeleted!['date']);
//       } else {
//         _selectedTimeSlot = timeSlot;
//         widget.onTimeSelected(_selectedTimeSlot);
//         widget.onDateSelected(widget.dateSeleted!['date']);
//       }
//     });
//   }
// }

// class TimeSlotGrid extends StatefulWidget {
//   final Map<String, dynamic>? dateSeleted;
//   final bool isCurrentDate;
//   List<TimeSlotModel> timeSlotModel;
//   final String selectedTimeSlot;
//   final void Function(String timeSlot) onTimeSlotSelected;
//   AccountInfoModel? stylistSelected;

//   final String openBranch;
//   final String closeBranch;

//   TimeSlotGrid({
//     Key? key,
//     required this.dateSeleted,
//     required this.isCurrentDate,
//     required this.selectedTimeSlot,
//     required this.onTimeSlotSelected,
//     required this.timeSlotModel,
//     required this.stylistSelected,
//     required this.openBranch,
//     required this.closeBranch,
//   }) : super(key: key);

//   @override
//   State<TimeSlotGrid> createState() => _TimeSlotGridState();
// }

// class _TimeSlotGridState extends State<TimeSlotGrid> {
//   @override
//   Widget build(BuildContext context) {
//     final now = DateTime.now();
//     final formatter = DateFormat('HH:mm');
//     final currentTime = formatter.format(now);
//     return isLoading
//         ? Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 margin: const EdgeInsets.only(top: 30),
//                 height: 50,
//                 width: 50,
//                 child: const CircularProgressIndicator(),
//               )
//             ],
//           )
//         : GridView.builder(
//             scrollDirection: Axis.horizontal,
//             controller: scrollController,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 crossAxisSpacing: 8.0,
//                 mainAxisSpacing: 8.0,
//                 childAspectRatio: 1 / 1.5),
//             itemCount: timeSlotCards.length,
//             itemBuilder: (BuildContext context, int index) {
//               return timeSlotCards[index];
//             },
//           );
//   }

//   @override
//   void initState() {
//     super.initState();
//     getTimeSlotCard();

//     Future.delayed(Duration.zero, () {
//       // Gọi sau khi build xong
//       final now = DateTime.now();
//       final formatter = DateFormat('HH:mm');
//       final currentTime = formatter.format(now);
//       List<int> scrollListIndex = [];
//       if (widget.isCurrentDate) {
//         for (int i = 0; i < timeSlots.length; i++) {
//           final timeSlot = timeSlots[i];
//           final isSelectable = timeSlot.compareTo(currentTime) >= 0;
//           if (isSelectable) {
//             scrollListIndex.add(timeSlots.indexOf(timeSlots[i]));
//           }
//         }
//       } else if (scrollListIndex.isNotEmpty) {
//         final scrollIndex = scrollListIndex.first;
//         scrollToIndex(scrollIndex);
//       } else {
//         for (int i = 0; i < timeSlots.length; i++) {
//           scrollListIndex.add(timeSlots.indexOf(timeSlots[i]));
//         }
//       }
//     });
//   }

//   @override
//   void didUpdateWidget(TimeSlotGrid oldWidget) {
//     getTimeSlotCard();

//     Future.delayed(Duration.zero, () {
//       // Gọi sau khi build xong
//       final now = DateTime.now();
//       final formatter = DateFormat('HH:mm');
//       final currentTime = formatter.format(now);
//       // List<int> scrollListIndex = [];
//       // if (widget.isCurrentDate) {
//       //   for (int i = 0; i < timeSlots.length; i++) {
//       //     final timeSlot = timeSlots[i];
//       //     final isSelectable = timeSlot.compareTo(currentTime) >= 0;
//       //     if (isSelectable) {
//       //       scrollListIndex.add(timeSlots.indexOf(timeSlots[i]));
//       //     }
//       //   }
//       // } else {
//       //   for (int i = 0; i < timeSlots.length; i++) {
//       //     scrollListIndex.add(timeSlots.indexOf(timeSlots[i]));
//       //   }
//       // }

//       // if (scrollListIndex.isNotEmpty) {
//       //   final scrollIndex = scrollListIndex.first;
//       //   scrollToIndex(scrollIndex);
//       // }
//     });
//     build(context);
//     super.didUpdateWidget(oldWidget);
//   }

//   // ignore: unused_field
//   bool _isDisposed = false;
//   @override
//   void dispose() {
//     _isDisposed = true; // Đánh dấu widget đã bị dispose
//     super.dispose();
//   }

//   bool isLoading = true;
//   // isSelectable true là chọn đc
//   bool checkTimeSlotSelected(dynamic timeSlot) {
//     bool result = false;
//     if (widget.stylistSelected != null &&
//         widget.stylistSelected!.accountId != null) {
//       if (widget.timeSlotModel.isNotEmpty) {
//         try {
//           List<TimeSlotModel> timeSlotGrid = widget.timeSlotModel
//               .where((element) => element.time == '$timeSlot:00')
//               .toList();
//           timeSlotGrid;
//           if (timeSlotGrid.isNotEmpty) {
//             result = timeSlotGrid.first.isAvailable!;
//           } else {
//             result = false;
//           }
//           return result;
//         } catch (e) {
//           return false;
//         }
//       } else {
//         return true;
//       }
//     }
//     // random
//     else {
//       if (widget.timeSlotModel.isNotEmpty) {
//         try {
//           for (var timeSlotElement in widget.timeSlotModel) {
//             if (timeSlotElement.time == '$timeSlot:00' &&
//                 timeSlotElement.isAvailable!) {
//               return true;
//             }
//           }
//           return false;
//         } catch (e) {
//           return false;
//         }
//       } else {
//         return true;
//       }
//     }
//   }

//   List<String> timeSlots = [];
//   ScrollController scrollController = ScrollController();

//   void scrollToIndex(int index) {
//     scrollController.animateTo((index / 3).floor() * 99,
//         duration: const Duration(milliseconds: 1), curve: Curves.easeIn);
//   }

//   List<String> generateTimeSlots() {
//     List<String> timeSlots = [];
//     for (int hour = 7; hour <= 23; hour++) {
//       for (int minute = 0; minute < 60; minute += 20) {
//         final formattedHour = hour.toString().padLeft(2, '0');
//         final formattedMinute = minute.toString().padLeft(2, '0');
//         timeSlots.add('$formattedHour:$formattedMinute');
//       }
//     }
//     return timeSlots;
//   }

//   List<TimeSlotCard> timeSlotCards = [];
//   void getTimeSlotCard() {
//     if (mounted) {
//       setState(() {
//         isLoading = true;
//       });
//     }

//     timeSlotCards = [];
//     timeSlots = generateTimeSlots();

//     // kiểm tra ngày hôm nay
//     final now = DateTime.now();
//     final formatter = DateFormat('HH:mm');
//     final currentTime = formatter.format(now);

//     // kiểm tra chi nhánh

//     final openBranchWidget = DateTime.parse("${widget.openBranch}");
//     final closeBranchWidget = DateTime.parse('${widget.closeBranch}');

//     String openBranch = DateFormat.Hm().format(openBranchWidget);
//     String closeBranch = DateFormat.Hm().format(closeBranchWidget);

//     for (var timeSlot in timeSlots) {
//       final isSelected = timeSlot == widget.selectedTimeSlot;

//       // kiểm tra được chọn hay không
//       // TRUE = avalible
//       bool isSelectable = false;
//       // kiểm tra timeslot vs thời gian rãnh của stylist
//       bool checkTimeSlotStylist = checkTimeSlotSelected(timeSlot);
//       isSelectable = checkTimeSlotStylist;

//       // kiểm tra ngày hôm nay
//       if (widget.isCurrentDate) {
//         if (timeSlot.compareTo(currentTime) >= 0) {
//           isSelectable; // kh thay đổi
//         } else {
//           // buộc false
//           isSelectable = false;
//         }
//       }
//       // kiểm tra giờ mở cửa của branch
//       if (timeSlot.compareTo(openBranch) >= 0 &&
//           timeSlot.compareTo(closeBranch) < 0) {
//         // không thay đổi
//         isSelectable;
//       } else {
//         // buộc false
//         isSelectable = false;
//       }

//       TimeSlotCard timeSlotCard = TimeSlotCard(
//         dateSeleted: widget.dateSeleted,
//         timeSlot: timeSlot,
//         isSelected: isSelected,
//         isSelectable: isSelectable,
//         onSelected: widget.onTimeSlotSelected,
//       );
//       timeSlotCards.add(timeSlotCard);
//     }

//     isLoading = false;
//   }
// }

// class TimeSlotCard extends StatefulWidget {
//   final String timeSlot;
//   final Map<String, dynamic>? dateSeleted;
//   final bool isSelected;
//   final bool isSelectable;
//   final void Function(String timeSlot) onSelected;

//   const TimeSlotCard(
//       {super.key,
//       required this.timeSlot,
//       required this.isSelected,
//       required this.isSelectable,
//       required this.onSelected,
//       required this.dateSeleted});

//   @override
//   State<TimeSlotCard> createState() => _TimeSlotCardState();
// }

// class _TimeSlotCardState extends State<TimeSlotCard> {
//   @override
//   void didUpdateWidget(TimeSlotCard oldWidget) {
//     build(context);
//     super.didUpdateWidget(oldWidget);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final backgroundColor = widget.isSelected
//         ? (widget.dateSeleted!['type'] == "Ngày thường"
//             ? const Color(0xff207A20)
//             : const Color(0xff964444))
//         : (widget.isSelectable ? Colors.white : Colors.grey);
//     final textColor = widget.isSelected ? Colors.white : Colors.black;

//     return GestureDetector(
//       onTap: () {
//         if (widget.isSelectable) {
//           widget.onSelected(widget.timeSlot);
//         }
//       },
//       child: Container(
//         // height: 20.0,
//         // width: 40.0,
//         decoration: BoxDecoration(
//           border: widget.isSelectable
//               ? Border.all(color: Colors.black, width: 1.0)
//               : null,
//           borderRadius: BorderRadius.circular(5.0),
//           color: backgroundColor,
//         ),
//         child: Center(
//           child: Text(
//             widget.timeSlot,
//             style: TextStyle(fontSize: 23, color: textColor),
//           ),
//         ),
//       ),
//     );
//   }
// }
