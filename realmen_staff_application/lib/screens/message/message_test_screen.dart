// ignore_for_file: constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:realmen_staff_application/screens/message/success_screen.dart';

class MessageTestScreen extends StatefulWidget {
  const MessageTestScreen({super.key});

  @override
  State<MessageTestScreen> createState() => _MessageTestScreenState();
  static const MessageTestScreenRoute = "/message-text-screen";
}

class _MessageTestScreenState extends State<MessageTestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      body: Center(
        child: Stack(alignment: Alignment.center, children: <Widget>[
          Positioned(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: ElevatedButton(
                      onPressed: () => {_successMessage("Thanh công")},
                      child: const Text("Click to show Success message"),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => {_errorMessage("Error")},
                      child: const Text("Click to show Error message"),
                    ),
                  ),
                ],
              )
            ],
          ))
        ]),
      ),
    );
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
}
