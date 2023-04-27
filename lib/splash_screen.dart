import 'package:flutter/material.dart';
import 'package:log_sign_app/toast_signup.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoaded = false;

  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 6)).then((value) => setState(() {
          isLoaded = true;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateWhere: isLoaded,
      navigateRoute: const ToastSigUpScreen(), backgroundColor: Colors.white,
      linearGradient: const LinearGradient(
        colors: [
          Colors.black12,
          Colors.black87,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      text: WavyAnimatedText(
        "Fitness Gym",
        textStyle: const TextStyle(
          color: Colors.red,
          fontSize: 38,
          fontWeight: FontWeight.w900,
          fontFamily: 'LibreBaskerville',
        ),
      ),
      imageSrc: 'assets/image/pngwing.com.png',
      //  displayLoading: false,
    );
  }
}
