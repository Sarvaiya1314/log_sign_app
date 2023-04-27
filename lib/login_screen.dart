import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:log_sign_app/app_text_field.dart';
import 'package:log_sign_app/home_screen.dart';
import 'package:log_sign_app/toast_signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  User? userCradential;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  loginUser() async {
    /*try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text).then((value) {
        userCradential = value.user;
        debugPrint('user Data -----> ${value.user}');
        userCradential = value.user;

        if (value.user!.emailVerified) {
          userCradential = value.user;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(' User has been Login')));
          return false;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('%%%%%%%%%%%%%%%%%')));
          return false;
        }
      });
    } on FirebaseAuthException catch (error) {
      debugPrint('code ---> ${error.code}');
      if (error.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login done')));
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
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
      }
    }*/
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text).then((value) {
        userCradential = value.user;
        debugPrint('user Data -----> ${value.user}');
        userCradential = value.user;
        value.user!.sendEmailVerification();

        if (value.user!.emailVerified) {
          userCradential = value.user;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(' User has been Login')));
          return false;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(' First U Verified Your email ')));
          value.user!.sendEmailVerification();
          return false;
        }
      });
    } on FirebaseAuthException catch (error) {
      debugPrint('code ---> ${error.code}');
      if (error.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login ok')));
        Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => HomeScreen(),
            ));
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
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    userCradential = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signInWithGitHub() async {
    // Create a GitHubSignIn instance
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
      clientId: "e2cc7286307a8f37b256",
      clientSecret: "41f07ca8023e90c4a633f8be11210b8a355879b1",
      redirectUrl: 'https://log-sign-app.firebaseapp.com/__/auth/handler',
    );

    // Trigger the sign-in flow
    final result = await gitHubSignIn.signIn(context);

    // Create a credential from the access token
    final githubAuthCredential = GithubAuthProvider.credential(result.token!);

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(githubAuthCredential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  height: 30,
                ),
                const Text(
                  'WELCOME BACK',
                  style: TextStyle(
                    fontFamily: 'Abel',
                    fontSize: 21,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                AppTextField(
                  controller: emailController,
                  labelText: 'Email Address',
                  hintText: "Email",
                  validator: (email) {
                    if (RegExp(r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(email!)) {
                      return "";
                    } else {
                      return "Please Enter Valid Email";
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                AppTextField(
                  controller: passwordController,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  labelText: 'Password',
                  hintText: "Password",
                  validator: (email) {
                    if (RegExp(r'^[a-zA-Z0-9]+\.[0-9]').hasMatch(email!)) {
                      return "";
                    } else {
                      return "Please Enter Valid Password";
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 190),
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      fontFamily: 'Mulish',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF263238),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                InkWell(
                  onTap: () {
                    formKey.currentState!.validate();
                    loginUser();
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
                        'LOGIN',
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
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => ToastSigUpScreen(),
                        ));
                  },
                  child: RichText(
                    text: const TextSpan(
                      text: 'Don’t have an account? ',
                      style: TextStyle(
                        fontFamily: 'Mulish',
                        color: Color(0xFF263238),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign up',
                          style: TextStyle(
                            fontFamily: 'Mulish',
                            color: Color(0xFFFF5165),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: const [
                    Expanded(
                      child: Divider(
                        color: Color(0x2B000000),
                        thickness: 1.5,
                        indent: 5,
                        endIndent: 10,
                        height: 1,
                      ),
                    ),
                    Text(
                      'Or Login with',
                      style: TextStyle(
                        color: Color(0x8C263238),
                        fontSize: 16,
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Color(0x2B000000),
                        thickness: 1.5,
                        indent: 10,
                        endIndent: 5,
                        height: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 49,
                  width: 162,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        'assets/image/facebook.png',
                        height: 37,
                      ),
                      InkWell(
                        onTap: () {
                          signInWithGoogle();
                        },
                        child: Image.asset(
                          'assets/image/google.png',
                          height: 37,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          signInWithGitHub();
                        },
                        child: Image.asset(
                          'assets/image/phone.png',
                          height: 37,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'By clicking Login, '
                    'you agree with our Terms. '
                    'Learn how we process your '
                    'data in our privacy policy '
                    'and cookies policy.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0x7A000000),
                      fontSize: 14,
                      fontFamily: 'Abel',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
