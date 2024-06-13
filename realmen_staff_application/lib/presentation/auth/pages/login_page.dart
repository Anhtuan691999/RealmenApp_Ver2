import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pinput/pinput.dart';
import 'package:realmen_staff_application/data/shared_preferences/auth_pref.dart';
import 'package:realmen_staff_application/presentation/auth/bloc/auth_bloc.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {
  final AuthenticationBloc bloc;
  const LoginPage({super.key, required this.bloc});

  @override
  State<LoginPage> createState() => _LoginPageState();
  static const String LoginPageRoute = "/login-page";
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final FocusNode _focusNodePhone = FocusNode();
    final FocusNode _focusNodePassword = FocusNode();

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
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
                          // height: height * 0.65,
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
                                      // SizedBox(
                                      //   height: 2.h,
                                      // ),
                                      // const Text(
                                      //   "Nhập số điện thoại",
                                      //   style: TextStyle(
                                      //     fontSize: 27,
                                      //     fontWeight: FontWeight.w400,
                                      //     color: Color(0xff444444),
                                      //   ),
                                      // ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Container(
                                        width: 70.w,
                                        // height: height * 0.1,
                                        child: TextFormField(
                                          autofocus: false,
                                          controller: phoneController,
                                          keyboardType: TextInputType.phone,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(
                                                11),
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          focusNode: _focusNodePhone,
                                          onFieldSubmitted: (value) =>
                                              _focusNodePhone.unfocus(),
                                          onTapOutside: (event) =>
                                              _focusNodePhone.unfocus(),
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
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    // top: 10,
                                                    // bottom: 20,
                                                    left: 15,
                                                    right: 15),
                                            hintText: "Nhập số điện thoại",
                                            hintStyle: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xffC4C4C4),
                                            ),
                                            errorStyle: TextStyle(
                                              fontSize: 13.0,
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Vui lòng không để trống sđt';
                                            }

                                            return null; // Trả về null nếu không có lỗi
                                          },
                                        ),
                                      ),

                                      // password
                                      // SizedBox(
                                      //   height: 2.h,
                                      // ),
                                      // const Text(
                                      //   "Nhập mật khẩu",
                                      //   style: TextStyle(
                                      //     fontSize: 27,
                                      //     fontWeight: FontWeight.w400,
                                      //     color: Color(0xff444444),
                                      //   ),
                                      // ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Container(
                                        width: 70.w,
                                        // height: height * 0.1,
                                        child: TextFormField(
                                          autofocus: false,
                                          controller: passwordController,
                                          keyboardType: TextInputType.text,
                                          focusNode: _focusNodePassword,
                                          onFieldSubmitted: (value) =>
                                              _focusNodePassword.unfocus(),
                                          onTapOutside: (event) =>
                                              _focusNodePassword.unfocus(),
                                          onEditingComplete: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _focusNodePhone.unfocus();
                                              _focusNodePassword.unfocus();
                                              widget.bloc.add(
                                                  AuthenticationLoginEvent(
                                                      phone:
                                                          phoneController.text,
                                                      password:
                                                          passwordController
                                                              .text));
                                            }
                                          },
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
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    // top: 10,
                                                    // bottom: 20,
                                                    left: 15,
                                                    right: 15),
                                            hintText: "Nhập mật khẩu",
                                            hintStyle: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xffC4C4C4),
                                            ),
                                            errorStyle: TextStyle(
                                              fontSize: 13.0,
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Vui lòng không để trống mật khẩu';
                                            }

                                            return null; // Trả về null nếu không có lỗi
                                          },
                                        ),
                                      ),

                                      // button login
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      Container(
                                        // margin: const EdgeInsets.only(top: 22),
                                        width: 70.w,
                                        height: 50,
                                        margin: EdgeInsets.only(bottom: 15),
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
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _focusNodePhone.unfocus();
                                              _focusNodePassword.unfocus();
                                              widget.bloc.add(
                                                  AuthenticationLoginEvent(
                                                      phone:
                                                          phoneController.text,
                                                      password:
                                                          passwordController
                                                              .text));
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
      ),
    );
  }
}
