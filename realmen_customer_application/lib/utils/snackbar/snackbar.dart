// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ShowSnackBar {
  const ShowSnackBar({required this.message});
  final String? message;

  static SuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      width: 85.w,
      padding: const EdgeInsets.all(0),
      content: Container(
        height: 40,
        // width: 50.w,
        decoration: const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Row(
          children: <Widget>[
            const SizedBox(
              width: 15,
            ),
            const Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      // backgroundColor: Colors.purple.withOpacity(0),
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }

  static ErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      width: 85.w,
      padding: const EdgeInsets.all(0),
      content: Container(
        constraints: const BoxConstraints(minHeight: 40),
        // width: 50.w,
        decoration: const BoxDecoration(
          color: Color(0xff4E4C4C),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Row(
          children: <Widget>[
            const SizedBox(
              width: 15,
            ),
            const Icon(
              Icons.info,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 72.w,
              child: Text(
                utf8.decode(message.toString().runes.toList()),
                maxLines: 2,
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      // backgroundColor: Colors.purple.withOpacity(0),
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }
}
