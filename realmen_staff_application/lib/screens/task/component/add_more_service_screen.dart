// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_final_fields, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realmen_staff_application/models/booking/booking_model.dart';
import 'package:realmen_staff_application/screens/task/component/popup_add_service.dart';
import 'package:sizer/sizer.dart';

import '../booking_processing.dart';

class AddMoreServiceScreen extends StatefulWidget {
  AddMoreServiceScreen(this._selectedService);
  List<BookingServiceModel> _selectedService;

  @override
  State<AddMoreServiceScreen> createState() => _AddMoreServiceScreenState();
}

class _AddMoreServiceScreenState extends State<AddMoreServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg.png'),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          SafeArea(
              child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 15,
                bottom: 27,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.only(top: 15, left: 0),
                    width: 90.w,
                    height: 90.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.only(left: 7),
                            child: Center(
                              child: Stack(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 40,
                                    child: IconButton(
                                      alignment: Alignment.centerLeft,
                                      color: Colors.black,
                                      iconSize: 22,
                                      icon:
                                          const Icon(Icons.keyboard_arrow_left),
                                      onPressed: () {
                                        Get.back();
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        "thêm dịch vụ".toUpperCase(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 40,
                          left: 0,
                          right: 0,
                          bottom: 40,
                          child: Container(
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Đơn cắt:  Thứ 2, 27/11/2023  12:00",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 100,
                                              child: const Text(
                                                "Khách hàng: ",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 200,
                                              child: const Text(
                                                " Le Anh Tuan  -  Lv 1",
                                                maxLines: 2,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 100,
                                              child: const Text(
                                                "Số điện thoại: ",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 200,
                                              child: const Text(
                                                "xxxxxx1487",
                                                textAlign: TextAlign.left,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 17,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          "Dịch Vụ: ",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 23,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10,
                                          ),
                                          child: Divider(
                                            color: Colors.black,
                                            height: 2,
                                            thickness: 1,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 10,
                                          ),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: selectedService.length,
                                            itemExtent: 40, // khoảng cách item
                                            itemBuilder: (context, index) {
                                              // Return a Card widget for each item in the list
                                              return Text(
                                                "${index + 1}. ${selectedService[index]!.name}",
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          "Chọn dịch Vụ: ",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 23,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10,
                                          ),
                                          child: Divider(
                                            color: Colors.black,
                                            height: 2,
                                            thickness: 1,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 10,
                                          ),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount:
                                                addBookingServices.length,
                                            itemExtent: 40, // khoảng cách item
                                            itemBuilder: (context, index) {
                                              // Return a Card widget for each item in the list

                                              return AddServiceWidget(
                                                  selectedService:
                                                      addBookingServices[index],
                                                  onSelect: (bool isSelected) {
                                                    _addService(
                                                        isSelected,
                                                        addBookingServices[
                                                            index]);
                                                  });
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: Colors.white,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  border: Border.all(
                                    color: Colors.black54,
                                    width: 1,
                                    style: BorderStyle.solid,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              margin: const EdgeInsets.all(10),
                              child: TextButton(
                                onPressed: () {
                                  _popup();
                                },
                                child: Center(
                                  child: Text(
                                    "thêm ${selectedBookingServices.isNotEmpty ? '${selectedBookingServices.length} ' : ""}dịch vụ"
                                        .toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }

  List<dynamic> selectedService = [];
  @override
  void initState() {
    super.initState();
    selectedService = List<dynamic>.from(widget._selectedService);
  }

  List<serviceDemoModel> addBookingServices = [
    serviceDemoModel(name: "Add Cắt tóc", role: 2, status: false),
    serviceDemoModel(name: "Add Uốn", role: 2, status: false),
    serviceDemoModel(name: "Add Gội đầu", role: 1, status: false),
    serviceDemoModel(name: "Add Cạo mặt", role: 1, status: false),
    serviceDemoModel(name: "Add Massage", role: 1, status: false),
    serviceDemoModel(name: "Add Ráy tai", role: 1, status: false),
    serviceDemoModel(name: "Add Ráy tai", role: 1, status: false),
    serviceDemoModel(name: "Add Ráy tai", role: 1, status: false),
    serviceDemoModel(name: "Add Ráy tai", role: 1, status: false),
  ];

  List<bool>? selectedStates = [];
  // các dịch vụ xác nhận thêm vào
  List<serviceDemoModel> selectedBookingServices = [];

  void _addService(bool isSelected, serviceDemoModel addBookingService) {
    if (isSelected) {
      setState(() {
        selectedBookingServices.add(addBookingService);
      });
    } else if (!isSelected) {
      setState(() {
        selectedBookingServices
            .removeWhere((element) => element == addBookingService);
      });
    }
  }

  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Future<void> _popup() async {
    if (!_isDisposed) {
      return showModalBottomSheet(
        enableDrag: true,
        isDismissible: true,
        isScrollControlled: false,
        context: context,
        backgroundColor: Colors.white,
        barrierColor: const Color(0x8c111111),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (context) =>
            PopUpAddService(selectedBookingServices: selectedBookingServices),
      );
    }
  }
}

class AddServiceWidget extends StatefulWidget {
  const AddServiceWidget(
      {super.key, required this.selectedService, required this.onSelect});
  final serviceDemoModel selectedService;
  final Function(bool) onSelect;
  @override
  State<AddServiceWidget> createState() => _AddServiceWidgetState();
}

class _AddServiceWidgetState extends State<AddServiceWidget> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "+ ${widget.selectedService.name}",
          style: const TextStyle(fontSize: 20),
        ),
        Checkbox(
          value: isSelected,
          onChanged: (bool? value) {
            setState(() {
              isSelected = value!;
              widget.onSelect(isSelected);
            });
          },
        )
      ],
    );
  }
}
