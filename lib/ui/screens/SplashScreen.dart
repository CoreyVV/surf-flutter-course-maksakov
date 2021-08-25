import 'package:flutter/material.dart';
import 'package:places/ui/screens/OnboardingScreen.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/icons.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<bool> _isInitialized = Future.value(false);

  @override
  void initState() {
    super.initState();

    _isInitialized = Future<bool>.delayed(
      Duration(seconds: 2),
      () => true,
    );

    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    try {
      await Future.wait(
        [
          _isInitialized,
          Future.delayed(
            Duration(seconds: 2),
          ),
        ],
        eagerError: true,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => OnboardingScreen(),
        ),
      );
    } catch (error) {
      print('Error $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            yellow,
            greenWhite,
          ],
        ),
      ),
      child: Center(
        child: MyIcon(
          asset: AssetsStr.subtract,
        ),
      ),
    );
  }
}
