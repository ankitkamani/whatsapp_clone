import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/view/home_screen.dart';
import '../../constand/constants.dart';
import '../../helper/auth_helper.dart';
import '../../model/Sign_In_Model/sign_in_model.dart';
import '../../model/Sign_Up_Model/sign_up.dart';

class Buttons {
  //Login Button
  static Builder loginButton() {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () async {
          if (Constant.formKey.currentState!.validate()) {
            Constant.formKey.currentState!.save();

            SignIn loginData =
                SignIn(email: Constant.email!, password: Constant.password!);

            Map<String, dynamic> res =
                await Auth_Helper.auth_helper.signIn(data: loginData);

            if (res['user'] != null) {
              Get.offUntil(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
                (route) => false,
              );
            } else if (res['error'] != null) {
              Get.snackbar("WhatsApp Clone", "Login Failed");
            }

            Constant.email_con.clear();
            Constant.password_con.clear();
          }
        },
        child: Container(
          height: 40,
          width: 120,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Constant.appColor,
          ),
          child: const Text(
            "Sign In",
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      );
    });
  }

  static InkWell signupButton() {
    return InkWell(
      onTap: () async {
        Get.defaultDialog(
          title: "Sign Up",
          content: Form(
            key: Constant.signKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter valid email";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (val) {
                    Constant.signup_email = val;
                  },
                  controller: Constant.signup_email_con,
                  decoration: const InputDecoration(
                    hintText: "enter email",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter valid password";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (val) {
                    Constant.signup_password = val;
                  },
                  controller: Constant.signup_password_con,
                  decoration: const InputDecoration(
                    hintText: "enter password",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (Constant.signKey.currentState!.validate()) {
                      Constant.signKey.currentState!.save();

                      SignUp signup_detail = SignUp(
                        email: Constant.signup_email!,
                        password: Constant.signup_password!,
                      );

                      Map<String, dynamic> res = await Auth_Helper.auth_helper
                          .signUp(data: signup_detail);

                      if (res['user'] != null) {
                        // Get.snackbar("Chat App", "Signup Success");
                        Get.back();
                      }
                    }

                    Constant.signup_email_con.clear();
                    Constant.signup_password_con.clear();
                  },
                  child: const Text("Sign Up"),
                ),
              ],
            ),
          ),
        );
      },
      child: const Text(
        "Sign up?",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }

  static googleSigninButton() {
    return OutlinedButton(
        onPressed: () async {
          Map res = await Auth_Helper.auth_helper.signInWithGoogle();
          if (res['user'] != null) {
            Get.offUntil(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
                (routes) => false);
          } else if (res['error'] != null) {}
        },
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.g_mobiledata_rounded),
            SizedBox(
              width: 10,
            ),
            Text("SignIn With Google"),
          ],
        ));
  }
}
