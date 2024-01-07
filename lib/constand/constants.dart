import 'dart:ui';

import 'package:flutter/material.dart';

const Bold = 'Bold';

const Regular = 'Regular';

Stream? messageData;

class Constant {
  static Color appColor = const Color(0xff3AA984);

  static GlobalKey<FormState> signKey = GlobalKey<FormState>();
  static TextEditingController signup_email_con = TextEditingController();
  static TextEditingController signup_password_con = TextEditingController();
  static String? signup_email;
  static String? signup_password;

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static TextEditingController email_con = TextEditingController();
  static TextEditingController password_con = TextEditingController();
  static String? password;
  static String? email;

  static Color textcolor = Colors.white;
}
