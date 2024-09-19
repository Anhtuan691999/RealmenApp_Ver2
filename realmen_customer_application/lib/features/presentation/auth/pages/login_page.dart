import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:realmen_customer_application/features/data/shared_preferences/auth_pref.dart';
import 'package:realmen_customer_application/features/presentation/auth/bloc/auth_bloc.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {
  final AuthenticationBloc bloc;
  const LoginPage({super.key, required this.bloc});

  @override
  State<LoginPage> createState() => _LoginPageState();
  static const String LoginPageRoute = "/login-page";
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    print('Current Route: ${Get.currentRoute}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String phone = AuthPref.getPhone();
    TextEditingController otpController = TextEditingController();
    bool buttonEnabled = false;
    int countdown = 0;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
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

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        bloc: widget.bloc,
        builder: (context, state) {
          if (state is AuthenticationResendOTPState) {
            widget.bloc.add(AuthenticationStartCountdownEvent());
          } else if (state is ShowLoginPageState) {
            widget.bloc.add(AuthenticationStartCountdownEvent());
          } else if (state is CountdownInProgressState) {
            countdown = (state as CountdownInProgressState).countdown!.toInt();
            buttonEnabled = false;
          } else if (state is CountdownFinishedState) {
            buttonEnabled = true;
          }
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
                              height: 65.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: SingleChildScrollView(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
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
                                          onCompleted: (pin) => widget.bloc.add(
                                              AuthenticationLoginEvent(
                                                  otp: pin, phone: phone)),
                                          controller: otpController,
                                        ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        Row(
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                buttonEnabled
                                                    ? widget.bloc.add(
                                                        AuthenticationInputPhoneEvent(
                                                            phone: phone))
                                                    : null;
                                              },
                                              // _buttonEnabled ? resendOtp : null,

                                              child: const Center(
                                                child: Text(
                                                  "Gửi lại mã OTP",
                                                  style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              countdown == 0
                                                  ? ""
                                                  : '${countdown}s',
                                              style:
                                                  const TextStyle(fontSize: 18),
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
                                                    color:
                                                        const Color(0xffC4C4C4),
                                                    width: 1,
                                                    style: BorderStyle.solid),
                                              ),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  widget.bloc.add(
                                                      AuthenticationShowCreateOtpEvent(
                                                          phone: phone));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 1, right: 1),
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  shadowColor:
                                                      Colors.transparent,
                                                ),
                                                child: Text(
                                                  "quay lại".toUpperCase(),
                                                  style: const TextStyle(
                                                      letterSpacing: 0.5,
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal),
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
                                                onPressed: () => widget.bloc.add(
                                                    AuthenticationLoginEvent(
                                                        otp: otpController.text
                                                            .toString(),
                                                        phone: phone)),
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24),
                                                  ),
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  shadowColor:
                                                      Colors.transparent,
                                                ),
                                                child: const Text(
                                                  "ĐĂNG NHẬP",
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      color: Color(0xffC4C4C4),
                                                      fontWeight:
                                                          FontWeight.w700),
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
        });
  }
}
