import 'package:flutter/material.dart';
import 'package:places/ui/screens/onboarding_screen.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/my_icons.dart';
import 'package:places/ui/screens/res/themes.dart';

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
      const Duration(seconds: 2),
      () => true,
    );

    _navigateToNext();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            Theme.of(context).colorScheme.green,
            Theme.of(context).colorScheme.yellow,
          ],
        ),
      ),
      child: const Center(
        child: MyIcon(
          asset: AssetsStr.subtract,
        ),
      ),
    );
  }

  Future<void> _navigateToNext() async {
    await Future.wait(
      [
        _isInitialized,
        Future<bool>.delayed(
          const Duration(seconds: 2),
          () => true,
        ),
      ],
      eagerError: true,
    );

    _toOnboardingScreen();
  }

  void _toOnboardingScreen() {
    Navigator.of(context).pushReplacement<void, void>(
      MaterialPageRoute(
        builder: (_) => const OnboardingScreen(),
      ),
    );
  }
}
