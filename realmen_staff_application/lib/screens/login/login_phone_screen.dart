// ignore_for_file: unused_import, constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:realmen_staff_application/models/login_register/login_phone_model.dart';
import 'package:realmen_staff_application/screens/login/login_otp_screen.dart';

import 'package:realmen_staff_application/screens/message/success_screen.dart';
import 'package:realmen_staff_application/service/authentication/authenticate_service.dart';
import 'package:realmen_staff_application/service/share_prreference/share_prreference.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPhoneScreen extends StatefulWidget {
  const LoginPhoneScreen({super.key});
  static const String LoginPhoneScreenRoute = "/login-phone-screen";

  @override
  State<LoginPhoneScreen> createState() => _LoginPhoneScreenState();
}

class _LoginPhoneScreenState extends State<LoginPhoneScreen> {
  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: 100.h,
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bg.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 10.h,
                      child: Container(
                        // padding: const EdgeInsets.only(top: 10),
                        // margin: EdgeInsets.symmetric(horizontal: 68),
                        width: 80.w,
                        height: 55.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SingleChildScrollView(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Form(
                                key: _formKey,
                                autovalidateMode: AutovalidateMode.always,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Image.asset(
                                      'assets/images/logo.png',
                                      width: 257,
                                      // height: 478,
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    const Text(
                                      "ĐĂNG NHẬP",
                                      style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff444444),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    const Text(
                                      "Nhập số điện thoại",
                                      style: TextStyle(
                                        fontSize: 27,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff444444),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    SizedBox(
                                      width: 70.w,
                                      // height: 40,
                                      child: TextFormField(
                                        controller: phoneController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(11),
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        focusNode: _focusNode,
                                        onTapOutside: (event) =>
                                            _focusNode.unfocus(),
                                        onEditingComplete: () => submitPhone(),
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
                                                BorderRadius.circular(24),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color(0xffC4C4C4)),
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color(0xffC4C4C4)),
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                          contentPadding: const EdgeInsets.only(
                                              // top: 10,
                                              // bottom: 20,
                                              left: 15,
                                              right: 15),
                                          hintText:
                                              "Nhập số điện thoại của bạn",
                                          hintStyle: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xffC4C4C4),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Vui lòng không để trống sđt của bạn';
                                          }

                                          return null; // Trả về null nếu không có lỗi
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Container(
                                      // margin: const EdgeInsets.only(top: 22),
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
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            submitPhone();
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                        ),
                                        child: const Text(
                                          "TIẾP THEO",
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Color(0xffC4C4C4),
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Logic
  TextEditingController phoneController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  // void submitPhone() async {
  //   String phone = phoneController.text.toString();
  //   LoginPhoneModel loginPhoneModel = LoginPhoneModel(value: phone);
  //   AuthenticateService authenticateService = AuthenticateService();
  //   if (phone.isNotEmpty &&
  //       phone != '' &&
  //       RegExp(r'^0\d{8,11}$').hasMatch(phone)) {
  //     try {
  //       var result = await authenticateService.loginPhone(loginPhoneModel);
  //       if (result["data"] == "false" && result['statusCode'] == 200) {
  //         Get.toNamed(RegisterScreen.RegisterScreenRoute);
  //       } else if (result["data"] == "true" && result['statusCode'] == 200) {
  //         Get.toNamed(LoginOTPScreen.LoginOTPScreenRoute);
  //         // Navigator.pushNamed(context, LoginOTPScreen.LoginOTPScreenRoute);
  //       } else if (result['statusCode'] == 500) {
  //         _errorMessage("${result['error']}");
  //       } else {
  //         _errorMessage("Số điện thoại không đúng");
  //         // print("$result['statusCode'] : $result['error']");
  //       }
  //     } catch (e) {
  //       _errorMessage("Số điện thoại không đúng");
  //       print("Error: $e");
  //     }
  //   } else if (phone.isEmpty || phone == '') {
  //     _errorMessage("Xin nhập số điện thoại");
  //   } else if (phone.length < 8 || phone.length > 11) {
  //     _errorMessage("Số điện thoại không đúng");
  //   } else {
  //     _errorMessage("Số điện thoại không đúng");
  //   }
  // }

  // // No API
  void submitPhone() async {
    _focusNode.unfocus();
    String phone = phoneController.text.toString();
    Navigator.pushNamed(context, LoginOTPScreen.LoginOTPScreenRoute);
    try {
      await SharedPreferencesService.savePhone(phone);
    } catch (e) {
      _errorMessage(e.toString());
    }
  }

  void _errorMessage(String? message) {
    try {
      ShowSnackBar.ErrorSnackBar(context, message!);
    } catch (e) {
      print(e);
    }
  }
}
