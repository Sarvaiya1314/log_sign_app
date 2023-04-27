import 'package:action_slider/action_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:log_sign_app/login_screen.dart';

class PluginScreen extends StatefulWidget {
  const PluginScreen({Key? key}) : super(key: key);

  @override
  State<PluginScreen> createState() => _PluginScreenState();
}

class _PluginScreenState extends State<PluginScreen> {
  final _controller = ActionSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ActionSlider.standard(
              sliderBehavior: SliderBehavior.stretch,
              width: 300.0,
              backgroundColor: Colors.white,
              toggleColor: const Color(0xFFFF5165),
              action: (controller) async {
                controller.loading(); //starts loading animation
                await Future.delayed(const Duration(seconds: 3));
                controller.success(); //starts success animation
                await Future.delayed(
                  const Duration(seconds: 1),
                  () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                  },
                );
                controller.reset(); //resets the slider
              },
              child: const Text('Slide to confirm'),
            ),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}
