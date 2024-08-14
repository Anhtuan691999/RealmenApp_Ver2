import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:realmen_customer_application/features/presentation/auth/bloc/auth_bloc.dart';
import 'package:sizer/sizer.dart';

import '../bloc/register_bloc.dart';

class RegisterPage extends StatefulWidget {
  final AuthenticationBloc bloc;
  final String? phone;
  const RegisterPage({super.key, required this.bloc, this.phone});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
  static const String RegisterPageRouter = '/register';
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterBloc registerBloc = RegisterBloc();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final FocusNode _focusNodePhone = FocusNode();
  final FocusNode _focusNodeFirstName = FocusNode();
  final FocusNode _focusNodeLastName = FocusNode();

  TextEditingController phoneController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  DateTime? dobSubmit;
  String gender = 'MALE';
  List<String> genders = ['NAM', 'NỮ'];
  String genderController = 'NAM';

  @override
  void initState() {
    registerBloc.add(RegisterInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      bloc: registerBloc,
      listener: (context, state) {},
      builder: (context, state) {
        phoneController = widget.phone != null
            ? TextEditingController(text: widget.phone.toString())
            : TextEditingController();
        switch (state.runtimeType) {
          case RegisterSelectGenderState:
            final currentState = state as RegisterSelectGenderState;
            genderController = currentState.gender;
            break;
        }
        return Scaffold(
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
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: 30,
                        bottom: 30,
                        // bottom: 10.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: 82.w,
                            height: null,
                            // constraints:
                            //     BoxConstraints(minHeight: 75.h, maxHeight: 80.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Form(
                              key: _formKey,
                              autovalidateMode: AutovalidateMode.always,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Image.asset(
                                      'assets/images/logo.png',
                                      width: 257,
                                      // height: 59,
                                    ),
                                    SizedBox(
                                      height: 3.h,
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
                                      "Nhập thông tin",
                                      style: TextStyle(
                                        fontSize: 27,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff444444),
                                      ),
                                    ),

                                    // Phone
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    SizedBox(
                                      width: 70.w,
                                      // height: 40,
                                      child: TextFormField(
                                        controller: phoneController,
                                        cursorColor: Colors.black,
                                        cursorWidth: 1,
                                        focusNode: _focusNodePhone,
                                        // onTapOutside: (event) =>
                                        //     _focusNodefirstName.unfocus(),
                                        onEditingComplete: () =>
                                            _focusNodePhone.unfocus(),

                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(11),
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        keyboardType: TextInputType.phone,
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
                                              color: Color(0xffC4C4C4)),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Vui lòng không để trống số điện thoại của bạn';
                                          }

                                          return null; // Trả về null nếu không có lỗi
                                        },
                                      ),
                                    ),
                                    // Họ và tên
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    SizedBox(
                                      width: 70.w,
                                      // height: 40,
                                      child: TextFormField(
                                        controller: firstNameController,
                                        cursorColor: Colors.black,
                                        cursorWidth: 1,
                                        focusNode: _focusNodeFirstName,
                                        // onTapOutside: (event) =>
                                        //     _focusNodefirstName.unfocus(),
                                        onEditingComplete: () =>
                                            _focusNodeFirstName.unfocus(),
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .singleLineFormatter, // Đảm bảo chỉ nhập trên một dòng
                                        ],
                                        keyboardType: TextInputType.text,
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
                                              "Nhập Họ và Tên đệm của bạn",
                                          hintStyle: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xffC4C4C4)),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Vui lòng không để trống Họ và Tên đệm của bạn';
                                          }

                                          return null; // Trả về null nếu không có lỗi
                                        },
                                      ),
                                    ),
                                    // Tên
                                    SizedBox(
                                      height: 2.h,
                                    ),

                                    SizedBox(
                                      width: 70.w,
                                      // height: 40,
                                      child: TextFormField(
                                        controller: lastNameController,
                                        cursorColor: Colors.black,
                                        cursorWidth: 1,
                                        focusNode: _focusNodeLastName,
                                        // onTapOutside: (event) =>
                                        //     _focusNodelastName.unfocus(),
                                        onEditingComplete: () =>
                                            _focusNodeLastName.unfocus(),
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .singleLineFormatter, // Đảm bảo chỉ nhập trên một dòng

                                          FilteringTextInputFormatter.deny(RegExp(
                                              r'[\s]')), // Không cho phép khoảng trắng
                                        ],
                                        keyboardType: TextInputType
                                            .text, // Hiển thị bàn phím là chữ

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
                                          hintText: "Nhập Tên của bạn",
                                          hintStyle: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xffC4C4C4)),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Vui lòng không để trống Tên của bạn';
                                          }

                                          return null; // Trả về null nếu không có lỗi
                                        },
                                      ),
                                    ),

                                    // DOB
                                    SizedBox(
                                      height: 2.h,
                                    ),

                                    SizedBox(
                                      width: 70.w,
                                      // height: 40,
                                      child: TextFormField(
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
                                          hintText: "Nhập Ngày sinh dd/mm/yyyy",
                                          hintStyle: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xffC4C4C4)),
                                        ),
                                        onTap:
                                            //_selectDate, EVENT
                                            () async {
                                          DateTime? dob = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime(2000),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime.now(),
                                          );
                                          if (dob != null) {
                                            dobSubmit = dob;
                                            dobController.text =
                                                DateFormat('dd-MM-yyyy')
                                                    .format(dob)
                                                    .toString()
                                                    .split(" ")[0];
                                          }
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Vui lòng không để trống Ngày sinh của bạn';
                                          }

                                          return null; // Trả về null nếu không có lỗi
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    // Gender
                                    Container(
                                      // margin: const EdgeInsets.only(top: 22),
                                      width: 70.w,
                                      // height: 40,
                                      // padding: EdgeInsets.symmetric(horizontal: 15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
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
                                            onChanged: (item) {
                                              genderController = item!;
                                              registerBloc.add(
                                                  RegisterSelectGenderEvent(
                                                      gender:
                                                          genderController));
                                            }),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.5.h,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
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
                                                    AuthenticationShowCreateOtpEvent());
                                              },
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                ),
                                                padding: const EdgeInsets.only(
                                                    left: 1, right: 1),
                                                backgroundColor:
                                                    Colors.transparent,
                                                shadowColor: Colors.transparent,
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
                                          Container(
                                            // margin: const EdgeInsets.only(top: 22),
                                            width: 43.w,
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
                                              onPressed: () {
                                                _focusNodePhone.unfocus();
                                                _focusNodeFirstName.unfocus();
                                                _focusNodeLastName.unfocus();
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  // submitRegister(); EVENT
                                                  widget.bloc.add(
                                                      AuthenticationRegisterEvent(
                                                          phone: phoneController
                                                              .text,
                                                          firstName:
                                                              firstNameController
                                                                  .text,
                                                          lastName:
                                                              lastNameController
                                                                  .text,
                                                          dob: DateFormat(
                                                                  'yyyy-MM-dd')
                                                              .format(
                                                                  dobSubmit!)
                                                              .toString()
                                                              .split(" ")[0],
                                                          thumbnail: "",
                                                          gender:
                                                              genderController));
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                ),
                                                backgroundColor:
                                                    Colors.transparent,
                                                shadowColor: Colors.transparent,
                                              ),
                                              child: const Text(
                                                "HOÀN TẤT",
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
                                    ),
                                    SizedBox(
                                      height: 2.5.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
