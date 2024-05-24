// ignore_for_file: constant_identifier_names, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realmen_staff_application/models/login_register/login_otp_model.dart';
import 'package:realmen_staff_application/models/login_register/login_phone_model.dart';
import 'package:realmen_staff_application/screens/login/login_phone_screen.dart';
import 'package:realmen_staff_application/screens/main_bottom_bar/main_screen.dart';
import 'package:realmen_staff_application/screens/message/success_screen.dart';
import 'package:realmen_staff_application/service/authentication/authenticate_service.dart';
import 'package:realmen_staff_application/service/share_prreference/share_prreference.dart';
import 'package:sizer/sizer.dart';
import 'package:pinput/pinput.dart';

class LoginOTPScreen extends StatefulWidget {
  const LoginOTPScreen({super.key});
  static const String LoginOTPScreenRoute = "/login-otp-screen";

  @override
  State<LoginOTPScreen> createState() => _LoginOTPScreenState();
}

class _LoginOTPScreenState extends State<LoginOTPScreen> {
  // UI
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 49,
      height: 49,
      textStyle: const TextStyle(
          fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffC4C4C4)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color(0xff777777)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(239, 240, 241, 1),
      ),
    );
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
                        height: 60.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SingleChildScrollView(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Image.asset(
                                    'assets/images/logo.png',
                                    width: 250,
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
                                    "Nhập OTP",
                                    style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff444444),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Pinput(
                                    defaultPinTheme: defaultPinTheme,
                                    focusedPinTheme: focusedPinTheme,
                                    submittedPinTheme: submittedPinTheme,
                                    length: 5,
                                    pinputAutovalidateMode:
                                        PinputAutovalidateMode.onSubmit,
                                    showCursor: true,
                                    onCompleted: (pin) => submitOtp(),
                                    controller: otpController,
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed:
                                            _buttonEnabled ? resendOtp : null,
                                        child: const Center(
                                          child: Text(
                                            "Gửi lại mã OTP",
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        _countdown == 0 ? "" : '${_countdown}s',
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // margin: const EdgeInsets.only(top: 22),
                                        width: 24.w,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          color: Colors.white,
                                          border: Border.all(
                                              color: const Color(0xffC4C4C4),
                                              width: 1,
                                              style: BorderStyle.solid),
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                            padding: const EdgeInsets.only(
                                                left: 1, right: 1),
                                            backgroundColor: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                          ),
                                          child: Text(
                                            "quay lại".toUpperCase(),
                                            style: const TextStyle(
                                                letterSpacing: 0.5,
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      Container(
                                        // margin: const EdgeInsets.only(top: 24),
                                        width: 50.w,
                                        height: 50,
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
                                          borderRadius:
                                              BorderRadius.circular(24),
                                        ),
                                        child: ElevatedButton(
                                          onPressed: submitOtp
                                          // No API
                                          // () => Get.toNamed(
                                          //     MainScreen.MainScreenRoute)

                                          ,
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                            backgroundColor: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                          ),
                                          child: const Text(
                                            "ĐĂNG NHẬP",
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: Color(0xffC4C4C4),
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
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
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startCountdown();
    super.initState();
  }

  TextEditingController otpController = TextEditingController();
  bool _buttonEnabled = true;
  int _countdown = 30;
  late Timer _timer;
  void submitOtp() async {
    String phone = await SharedPreferencesService.getPhone();
    String otp = otpController.text.toString();
    LoginOtpModel loginOtpModel = LoginOtpModel(phone: phone, passCode: otp);
    AuthenticateService authenticateService = AuthenticateService();
    if (otp.length == 5) {
      try {
        var result = await authenticateService.loginOtp(loginOtpModel);
        if (result != null && result['statusCode'] == 200) {
          try {
            if (result['data'].loginOtpResponseModel.jwtToken != null) {
              _successMessage("Đăng nhập thành công");
              // Navigator.pushNamed(context, MainScreen.MainScreenRoute);
              Get.toNamed(MainScreen.MainScreenRoute);
            } else {
              _errorMessage("Lỗi đăng nhập");
            }
          } catch (e) {
            _errorMessage("Sai mã OTP");
          }
        } else if (result['statusCode'] == 500) {
          _errorMessage(result['message']);
        } else {
          _errorMessage("Sai mã OTP");
          print("$result");
        }
      } catch (e) {
        _errorMessage("Lỗi đăng nhập");
        print("Error: $e");
      }
    } else {
      _errorMessage("Xin nhập đúng mã OTP");
    }
  }

  void _successMessage(String? message) {
    try {
      ShowSnackBar.SuccessSnackBar(context, message!);
    } catch (e) {
      print(e);
    }
  }

  void _errorMessage(String? message) {
    try {
      ShowSnackBar.ErrorSnackBar(context, message!);
    } catch (e) {
      print(e);
    }
  }

  Future<void> resendOtp() async {
    if (mounted) {
      setState(() {
        otpController = TextEditingController();
      });
    }

    startCountdown();
    String phone = await SharedPreferencesService.getPhone();
    LoginPhoneModel loginPhoneModel = LoginPhoneModel(value: phone);
    AuthenticateService authenticateService = AuthenticateService();
    if (phone.isNotEmpty && phone != '') {
      try {
        var result = await authenticateService.loginPhone(loginPhoneModel);
        if (result['statusCode'] == 200) {
          _successMessage("Gửi lại mã OTP thành công");
        } else if (result['statusCode'] == 500) {
          _errorMessage("${result['error']}");
        } else {
          _errorMessage("Gửi lại mã OTP thất bại");
        }
      } catch (e) {
        _errorMessage("Gửi lại mã OTP thất bại");
      }
    } else {
      _errorMessage("Gửi lại mã OTP thất bại");
      Get.toNamed(LoginPhoneScreen.LoginPhoneScreenRoute);
    }
  }

  void startCountdown() {
    setState(() {
      _buttonEnabled = false;
      _countdown = 30;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _timer.cancel();
          _buttonEnabled = true;
        }
      });
    });
  }
}
