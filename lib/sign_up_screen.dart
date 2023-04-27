import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'app_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController userName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  User? userCradential;

  signUpUser() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: userName.text, password: passwordController.text).then((value) {
        userCradential = value.user;
        debugPrint('user Data -----> ${value.user}');
        value.user!.sendEmailVerification();
        setState(() {});
      });
    } on FirebaseAuthException catch (error) {
      debugPrint('code ---> ${error.code}');
      debugPrint('code ---> ${error.code}');
      debugPrint('message ---> ${error.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 80,
                ),
                const Center(
                  child: Text(
                    'POOL',
                    style: TextStyle(
                      color: Color(0xFFFF5165),
                      fontSize: 52,
                      fontFamily: 'ABeeZee',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'REGISTER ACCOUNT',
                  style: TextStyle(
                    fontFamily: 'Abel',
                    fontSize: 21,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                AppTextField(
                  controller: userName,
                  labelText: 'User Name',
                  hintText: "User Name",
                  validator: (email) {
                    if (RegExp(r'^[a-zA-Z0-9]+\.[0-9]').hasMatch(email!)) {
                      return "";
                    } else {
                      return "Please Enter Valid User Name";
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                AppTextFieldNumber(
                  controller: phoneNumber,
                  labelText: 'Phone Number',
                  keyboardType: TextInputType.number,
                  validator: (phone) {
                    if (RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(phone!)) {
                      return "";
                    } else {
                      return "Number Sarkho Nakh";
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                AppTextField(
                  controller: passwordController,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  labelText: 'Password',
                  hintText: "Password",
                  validator: (email) {
                    if (RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$').hasMatch(email!)) {
                      return "";
                    } else {
                      return "Please Enter Valid Password";
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                AppTextField(
                  controller: rePasswordController,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  labelText: 'Repeat Password',
                  hintText: " Repeat Password",
                  validator: (email) {
                    if (RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$').hasMatch(email!)) {
                      return "";
                    } else {
                      return "Please Enter Valid Password";
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    formKey.currentState!.validate();
                    signUpUser();
                  },
                  child: Container(
                    height: 59,
                    width: 318,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: const Color(0xFFFF5165),
                    ),
                    child: const Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
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
