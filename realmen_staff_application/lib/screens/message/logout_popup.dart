// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:realmen_staff_application/screens/message/success_screen.dart';
import 'package:realmen_staff_application/service/authentication/authenticate_service.dart';

class LogoutPopup extends StatelessWidget {
  const LogoutPopup({super.key});

  // UI
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "đăng xuất".toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Divider(
            color: Colors.grey.shade700,
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              "Xác nhận đăng xuất",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Color(0xff7a7a7a),
              ),
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 4,
                fit: FlexFit.tight,
                child: Container(
                  // margin: const EdgeInsets.only(top: 22),
                  // width: 70.w,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: Text(
                      "quay lại".toUpperCase(),
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              const Flexible(
                flex: 1,
                child: SizedBox(),
              ),
              Flexible(
                flex: 4,
                fit: FlexFit.tight,
                child: Container(
                  // margin: const EdgeInsets.only(top: 22),
                  // width: 70.w,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xff302E2E),
                          Color(0xe6444141),
                          Color(0xe6444141),
                          Color(0x8c484646),
                          Color(0x26444141),
                        ]),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _logout(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: Text(
                      "ĐĂNG xuất".toUpperCase(),
                      style: const TextStyle(
                          fontSize: 22,
                          color: Color(0xffC4C4C4),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // Logic
  Future<void> _logout(BuildContext context) async {
    AuthenticateService authenticateService = AuthenticateService();
    authenticateService.logout();
    _errorMessage(context, "Đăng xuất");
  }

  void _errorMessage(BuildContext context, String? message) {
    try {
      ShowSnackBar.ErrorSnackBar(context, message!);
    } catch (e) {
      print(e);
    }
  }
}
