import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

bool isValidEmail(String email) {
  final regex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
  );
  return regex.hasMatch(email);
}