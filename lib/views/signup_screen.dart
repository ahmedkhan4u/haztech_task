import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haztech_task/views/home_screen.dart';

import '../controllers/auth_controller.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  AuthController authController = Get.find<AuthController>();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width,
                  height: height * 0.45,
                  child: Image.asset(
                    'assets/play.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Signup',
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  validator: (String? input) {
                    if (input!.isEmpty) {
                      return '*required';
                    }

                    if (!input.isEmail) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                  controller: email,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    suffixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  validator: (String? input) {
                    if (input!.isEmpty) {
                      return '*required';
                    }

                    if (input.length < 6) {
                      return 'Password should be 6+ Characters!';
                    }
                    return null;
                  },
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: Icon(Icons.visibility_off),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() => authController.isUserRegister.value
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : MaterialButton(
                              child: Text('Signup'),
                              color: Color(0xffEE7B23),
                              onPressed: () {
                                if (!formKey.currentState!.validate()) {
                                  return;
                                }
                                authController.register(
                                    email.text.trim(), password.text.trim());
                              },
                            )),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Text.rich(
                    TextSpan(text: 'Already have an account? ', children: [
                      TextSpan(
                        text: 'Signin',
                        style: TextStyle(color: Color(0xffEE7B23)),
                      ),
                    ]),
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
