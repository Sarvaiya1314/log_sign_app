import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:log_sign_app/login_screen.dart';

import 'app_text_field.dart';

class ToastSigUpScreen extends StatefulWidget {
  const ToastSigUpScreen({Key? key}) : super(key: key);

  @override
  State<ToastSigUpScreen> createState() => _ToastSigUpScreenState();
}

class _ToastSigUpScreenState extends State<ToastSigUpScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController userName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  dynamic username = "userData";
  User? userCradential;

  signUpUser() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: userName.text, password: passwordController.text).then((value) {
        userCradential = value.user;
        debugPrint('user Data -----> ${value.user}');
        //email varifaction use mate
        value.user!.sendEmailVerification();
        setState(() {});
      });
    } on FirebaseAuthException catch (error) {
      debugPrint('code ---> ${error.code}');
      if (error.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('email already in use')));
        return false;
      } else if (error.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('invalid email')));
        return false;
      } else if (error.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password should be at least 6 characters')));
        return false;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error!.code)));
        debugPrint('message ---> ${error.message}');
        Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => LoginScreen(),
            ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
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
                  height: 50,
                ),
                AppTextField(
                  controller: userName,
                  labelText: 'User Name',
                  hintText: "User Name",
                  validator: (username) {
                    if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(username!)) {
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
                      return "Enter Valid Number";
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
                  validator: (pass) {
                    if (RegExp(r'^[a-zA-Z0-9]+\.[0-9]').hasMatch(pass!)) {
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
                  validator: (repass) {
                    if (RegExp(r'^[a-zA-Z0-9]+\.[0-9]').hasMatch(repass!)) {
                      return "";
                    } else {
                      return "Please Enter Valid Password";
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    formKey.currentState!.validate();

                    signUpUser();
                  },
                  child: Container(
                    height: 59,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: const Color(0xFFFF5165),
                    ),
                    child: const Center(
                      child: Text(
                        'Sign Up ',
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

  /* showToastMessage(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: (Colors.black54),
        elevation: 0,
        margin: const EdgeInsets.all(12),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        onVisible: () {
          debugPrint("onVisible ----->>> ");
        },
        // showCloseIcon: true,
        dismissDirection: DismissDirection.horizontal,
        action: SnackBarAction(
          label: 'dismiss',
          onPressed: () {},
        ),
      ),
    );
  }

  bool validator() {
    if (userName.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter User Name')));
      return false;
    } else if (!RegExp(r'^[a-zA-Z0-9]+\.[0-9]').hasMatch(userName.text)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please Enter Valid User Name')));
      return false;
    } else if (phoneNumber.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter Phone Number')));
      return false;
    } else if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(phoneNumber.text)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please Enter Valid Phone Number')));
      return false;
    } else if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter Password')));
      return false;
    } else if (!RegExp(r'^[a-zA-Z0-9]+\.[0-9]').hasMatch(passwordController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter Correct Password')));
      return false;
    } else if (rePasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter Password')));
      return false;
    } else if (!RegExp(r'^[a-zA-Z0-9]+\.[0-9]').hasMatch(rePasswordController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter  Repeat Password')));
      return false;
    } else if (passwordController.text != rePasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Both Password Not Match')));
      return false;
    } else {
      showToastMessage("${userName.text} Account Create");
      return true;
    }
  }*/
}
