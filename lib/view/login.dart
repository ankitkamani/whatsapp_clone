import 'package:flutter/material.dart';

import '../Widgets/Buttons/buttons.dart';
import '../constand/constants.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Authenticate",style: TextStyle(fontSize: 22)),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: Constant.formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: Constant.email_con,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "enter valid email";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (val) {
                          Constant.email = val;
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: "Enter Your Email...",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: Constant.password_con,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "enter valid password";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (val) {
                          Constant.password = val;
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: "Enter Your Password...",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50,),
                Buttons.loginButton(),
                const SizedBox(
                  height: 10,
                ),
                Buttons.signupButton(),
                const SizedBox(
                  height: 20,
                ),
                Buttons.googleSigninButton()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
