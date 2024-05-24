// ignore_for_file: unused_import, constant_identifier_names, unused_field, prefer_final_fields, sized_box_for_whitespace, avoid_unnecessary_containers, avoid_print

import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realmen_staff_application/models/account/account_info_model.dart';
import 'package:realmen_staff_application/models/autocomplete/autocomplete_model.dart';
import 'package:realmen_staff_application/screens/message/success_screen.dart';
import 'package:realmen_staff_application/service/account/account_info_service.dart';
import 'package:realmen_staff_application/service/authentication/authenticate_service.dart';
import 'package:realmen_staff_application/service/autocomplete/autocomplete_service.dart';
import 'package:sizer/sizer.dart';

class ViewEditProfileScreen extends StatefulWidget {
  const ViewEditProfileScreen({super.key});

  @override
  State<ViewEditProfileScreen> createState() => _ViewEditProfileScreenState();
  static const String ViewEditProfileScreenRoute = "/view-edit-profile-screen";
}

class _ViewEditProfileScreenState extends State<ViewEditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: accountInfo != null
          ? Stack(
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
                          child: ListView(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(left: 7),
                                child: Center(
                                  child: Stack(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 50,
                                        child: IconButton(
                                          alignment: Alignment.centerLeft,
                                          color: Colors.black,
                                          iconSize: 22,
                                          icon: const Icon(
                                              Icons.keyboard_arrow_left),
                                          onPressed: () {
                                            Get.back();
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 50,
                                        child: Center(
                                          child: Text(
                                            "thông tin tài khoản".toUpperCase(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 24,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Combo
                              const SizedBox(
                                height: 30,
                              ),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(
                                    children: [
                                      SizedBox(
                                        width: 120,
                                        height: 120,
                                        child: CircleAvatar(
                                          child: ClipOval(
                                            child: Image.network(
                                              avatarUrl ?? avatarDefault,
                                              scale: 1.0,
                                              fit: BoxFit.cover,
                                              width: 120,
                                              height: 120,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 5,
                                        child: Container(
                                          height: 35,
                                          width: 35,
                                          child: const CircleAvatar(
                                            child: ClipOval(
                                              child: Icon(
                                                Icons.card_giftcard,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                // color: Colors.amber,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Họ và Tên đệm",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        width: 80.w,
                                        // height: 40,
                                        child: TextField(
                                          controller: firstNameController,
                                          cursorColor: Colors.black,
                                          cursorWidth: 1,
                                          style: const TextStyle(
                                              height: 1.17,
                                              fontSize: 20,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Color(0xffC4C4C4)),
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Color(0xffC4C4C4)),
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    // top: 10,
                                                    // bottom: 20,
                                                    left: 15,
                                                    right: 15),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                // color: Colors.amber,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Tên",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        width: 80.w,
                                        // height: 40,
                                        child: TextField(
                                          controller: lastNameController,
                                          cursorColor: Colors.black,
                                          cursorWidth: 1,
                                          style: const TextStyle(
                                              height: 1.17,
                                              fontSize: 20,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Color(0xffC4C4C4)),
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Color(0xffC4C4C4)),
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    // top: 10,
                                                    // bottom: 20,
                                                    left: 15,
                                                    right: 15),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                // color: Colors.amber,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Số điện thoại",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        width: 80.w,
                                        // height: 40,
                                        child: TextField(
                                          controller: phoneController,
                                          cursorColor: Colors.black,
                                          cursorWidth: 1,
                                          style: const TextStyle(
                                              height: 1.17,
                                              fontSize: 20,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Color(0xffC4C4C4)),
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Color(0xffC4C4C4)),
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    // top: 10,
                                                    // bottom: 20,
                                                    left: 15,
                                                    right: 15),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                // color: Colors.amber,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Ngày tháng năm sinh ",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        width: 80.w,
                                        // height: 40,
                                        child: TextField(
                                          controller: dobController,
                                          readOnly: true,
                                          cursorColor: Colors.black,
                                          cursorWidth: 1,
                                          style: const TextStyle(
                                              height: 1.17,
                                              fontSize: 20,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Color(0xffC4C4C4)),
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Color(0xffC4C4C4)),
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    // top: 10,
                                                    // bottom: 20,
                                                    left: 15,
                                                    right: 15),
                                            hintText:
                                                "Nhập Ngày sinh dd/mm/yyyy",
                                            hintStyle: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xffC4C4C4)),
                                          ),
                                          onTap: _selectDate,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                // color: Colors.amber,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Giới tính ",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black),
                                      ),
                                      Container(
                                        // margin: const EdgeInsets.only(top: 22),
                                        width: 80.w,
                                        // height: 40,
                                        // padding: EdgeInsets.symmetric(horizontal: 15),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          border: Border.all(
                                              color: const Color(0xffC4C4C4)),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                              isExpanded: true,
                                              iconSize: 20,
                                              padding: const EdgeInsets.only(
                                                  left: 15, right: 15),
                                              value: genderController,
                                              items: genders
                                                  .map((item) =>
                                                      DropdownMenuItem<String>(
                                                        value: item,
                                                        child: Text(item,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        20)),
                                                      ))
                                                  .toList(),
                                              onChanged: (item) => setState(
                                                  () =>
                                                      genderController = item)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                // color: Colors.amber,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Địa chỉ",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        width: 80.w,
                                        // height: 40,
                                        child: TextField(
                                          controller: addressController,
                                          cursorColor: Colors.black,
                                          cursorWidth: 1,
                                          style: const TextStyle(
                                              height: 1.17,
                                              fontSize: 20,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Color(0xffC4C4C4)),
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Color(0xffC4C4C4)),
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    // top: 10,
                                                    // bottom: 20,
                                                    left: 15,
                                                    right: 15),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 80.w,
                                        height: 50,
                                        child: Autocomplete<PredictionModel>(
                                          displayStringForOption:
                                              displayStringForOption,
                                          initialValue: TextEditingValue(
                                              text: addressController.text),
                                          optionsBuilder:
                                              (textEditingValue) async {
                                            _searchingWithQuery =
                                                textEditingValue.text;
                                            if (textEditingValue.text.isEmpty ||
                                                textEditingValue.text == '') {
                                              return const Iterable.empty();
                                            }
                                            final value =
                                                await autocompleteService
                                                    .getAutocomplete(
                                                        textEditingValue.text);
                                            if (value['statusCode'] == 200) {
                                              autocompleteModel = value['data'];
                                              options = value['data']
                                                  ?.predictions!
                                                  .where((element) => utf8
                                                      .decode(element
                                                          .description!.runes
                                                          .toList())
                                                      .toLowerCase()
                                                      .contains(textEditingValue
                                                          .text
                                                          .toLowerCase()));

                                              return Future.value(options);
                                            }
                                            return [];

                                            // return autocompleteService
                                            //     .getAutocomplete(
                                            //         textEditingValue.text)
                                            //     .then((value) {
                                            //   if (value['data']
                                            //       is AutocompleteModel) {
                                            //     return value['data']
                                            //         .predictions!
                                            //         .where((element) => utf8
                                            //             .decode(element
                                            //                 .description!.runes
                                            //                 .toList())
                                            //             .toLowerCase()
                                            //             .contains(
                                            //                 textEditingValue
                                            //                     .text
                                            //                     .toLowerCase()));
                                            //   } else {
                                            //     return const Iterable.empty();
                                            //   }
                                            // });

                                            // final resultAuto =
                                            //     await autocompleteService
                                            //         .getAutocomplete(
                                            //             _searchingWithQuery!);
                                            // final Iterable<String> options;
                                            // if (resultAuto != null) {
                                            //   if (resultAuto
                                            //           .first['statusCode'] ==
                                            //       200) {
                                            //     options =
                                            //         resultAuto.first['data'];
                                            //     _lastOptions = options;
                                            //     utf8.decode(
                                            //         options.runes
                                            //         .toList());
                                            //     return options;
                                            //   } else {
                                            //     debugPrint(
                                            //         resultAuto.first['error']);
                                            //   }
                                            // }
                                            // return [];
                                          },
                                          onSelected: (address) {
                                            debugPrint(
                                                'You just selected $address');
                                            addressController.text =
                                                utf8.decode(address
                                                    .description!.runes
                                                    .toList());
                                          },
                                          fieldViewBuilder: (context,
                                              controller,
                                              focusNode,
                                              onEditingComplete) {
                                            return TextField(
                                              // controller: addressController,
                                              controller: controller,
                                              focusNode: focusNode,
                                              onEditingComplete:
                                                  onEditingComplete,
                                              cursorColor: Colors.black,
                                              cursorWidth: 1,
                                              style: const TextStyle(
                                                  height: 1.17,
                                                  fontSize: 20,
                                                  color: Colors.black),
                                              decoration: InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Color(0xffC4C4C4)),
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Color(0xffC4C4C4)),
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        // top: 10,
                                                        // bottom: 20,
                                                        left: 15,
                                                        right: 15),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                width: 70.w,
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xff302E2E),
                                        Color(0xe6444141),
                                        Color(0x8c484646),
                                        Color(0x26444141),
                                      ]),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  child: const Text(
                                    "HOÀN TẤT",
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: Color(0xffC4C4C4),
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ))
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  @override
  void initState() {
    super.initState();
    getAccountInfo();
  }

  final AutocompleteService autocompleteService = AutocompleteService();
  late Iterable<String> _lastOptions = <String>[];
  AutocompleteModel? autocompleteModel = AutocompleteModel();
  AccountInfoModel? accountInfo = AccountInfoModel();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingValue addressValue = const TextEditingValue();
  TextEditingController dobController = TextEditingController();
  List<String> genders = ['NAM', 'NỮ'];
  String? genderController = 'NAM';
  String? avatarUrl;
  final storage = FirebaseStorage.instance;
  String avatarDefault =
      "https://cdn.vectorstock.com/i/preview-1x/62/38/avatar-13-vector-42526238.jpg";
  String? _searchingWithQuery;
  Iterable<PredictionModel>? options;

  String displayStringForOption(PredictionModel prediction) =>
      utf8.decode(prediction.description!.runes.toList());

  Future<void> getAccountInfo() async {
    try {
      AccountService accountService = AccountService();
      final result = await accountService.getAccountInfo();
      if (result['statusCode'] == 200) {
        accountInfo = result['data'] as AccountInfoModel;
        if (accountInfo!.thumbnailUrl != null &&
            accountInfo!.thumbnailUrl != "") {
          var reference = storage.ref('avatar/${accountInfo!.thumbnailUrl}');
          avatarUrl = await reference.getDownloadURL();
        } else {
          var reference = storage.ref('avatar/default-2.png');
          avatarUrl = await reference.getDownloadURL();
        }
        setState(() {
          accountInfo;
          avatarUrl;
          firstNameController.text = accountInfo!.firstName ?? '';
          firstNameController.text =
              utf8.decode(firstNameController.text.runes.toList());
          lastNameController.text = accountInfo!.lastName ?? '';
          lastNameController.text =
              utf8.decode(lastNameController.text.runes.toList());
          phoneController.text = accountInfo!.phone ?? '';
          addressController.text = accountInfo!.address ?? '';
          addressController.text =
              utf8.decode(addressController.text.runes.toList());
          addressValue = TextEditingValue(
            text: accountInfo!.address ?? '',
          );
          dobController.text = (accountInfo!.dob)!.substring(0, 10);
        });
      } else {
        _errorMessage(result['message']);
        print(result);
      }
    } on Exception catch (e) {
      _errorMessage("Vui lòng thử lại");
      print(e.toString());
    }
  }

  void _errorMessage(String? message) {
    try {
      ShowSnackBar.ErrorSnackBar(context, message!);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _selectDate() async {
    DateTime? dob = await showDatePicker(
      context: context,
      initialDate: DateTime(2020),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (dob != null) {
      setState(() {
        dobController.text = dob.toString().split(" ")[0];
      });
      print(dobController.toString());
    }
  }
}
