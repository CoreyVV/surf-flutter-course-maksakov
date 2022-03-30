import 'package:flutter/material.dart';
import 'package:places/ui/screens/place_list_screen.dart';
import 'package:places/ui/screens/res/app_strings.dart';
import 'package:places/ui/screens/res/my_icons.dart';
import 'package:places/ui/screens/res/themes.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  int _currentPageValue = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          onPageChanged: _getChangedPageAndMoveBar,
          children: const [
            _FirstPage(),
            _SecondPage(),
            _ThirdPage(),
          ],
        ),
        Positioned(
          left: MediaQuery.of(context).size.width / 2 - 28,
          bottom: 136,
          child: Row(
            children: [
              for (int index = 0; index < 3; index++)
                _MyIndicator(
                  isActive: index == _currentPageValue,
                ),
            ],
          ),
        ),
      ],
    );
  }

  void _getChangedPageAndMoveBar(int page) {
    _currentPageValue = page;
    setState(() {});
  }
}

class _FirstPage extends StatelessWidget {
  const _FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 24,
        ),
        const _ButtonSkip(),
        const SizedBox(
          height: 187,
        ),
        MyIcon(
          asset: AssetsStr.tutorial1Frame,
          color: Theme.of(context).indicatorColor,
        ),
        const SizedBox(
          height: 42.6,
        ),
        Text(
          AppStrings.welcomeOnboardingScreen,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          AppStrings.lookForOnboardingScreen,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: Theme.of(context).colorScheme.secondaryVariant,
              ),
        ),
      ],
    );
  }
}

class _SecondPage extends StatelessWidget {
  const _SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 24,
        ),
        const _ButtonSkip(),
        const SizedBox(
          height: 187,
        ),
        MyIcon(
          asset: AssetsStr.tutorial2Frame,
          color: Theme.of(context).indicatorColor,
        ),
        const SizedBox(
          height: 47.48,
        ),
        Text(
          AppStrings.createRouteOnboardingScreen,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          AppStrings.reachGoalOnboardingScreen,
          textAlign: TextAlign.center,
          style:  Theme.of(context).textTheme.bodyText2!.copyWith(
            color: Theme.of(context).colorScheme.secondaryVariant,
          ),
        ),
      ],
    );
  }
}

class _ThirdPage extends StatelessWidget {
  const _ThirdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 267,
        ),
        MyIcon(
          asset: AssetsStr.tutorial3Frame,
          color: Theme.of(context).indicatorColor,
        ),
        const SizedBox(
          height: 47.78,
        ),
        Text(
          AppStrings.addPlacesOnboardingScreen,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          AppStrings.sharePlacesOnboardingScreen,
          textAlign: TextAlign.center,
          style:  Theme.of(context).textTheme.bodyText2!.copyWith(
            color: Theme.of(context).colorScheme.secondaryVariant,
          ),
        ),
        const SizedBox(
          height: 188,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: _ButtonStart(),
        ),
      ],
    );
  }
}

class _MyIndicator extends StatelessWidget {
  final bool isActive;

  const _MyIndicator({
    required this.isActive,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 8,
      ),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: isActive
            ? Theme.of(context).colorScheme.green
            : Theme.of(context).colorScheme.inactiveBlack,
      ),
    );
  }
}

class _ButtonStart extends StatelessWidget {
  const _ButtonStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushReplacement<void, void>(
            MaterialPageRoute(
              builder: (_) => const PlaceListScreen(),
            ),
          );
        },
        child: Text(
          AppStrings.onStartUppercase,
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}

class _ButtonSkip extends StatelessWidget {
  const _ButtonSkip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      height: 56,
      width: 392,
      padding: const EdgeInsets.only(right: 16),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushReplacement<void, void>(
            MaterialPageRoute(
              builder: (_) => const PlaceListScreen(),
            ),
          );
        },
        child: Text(
          AppStrings.skip,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Theme.of(context).colorScheme.green),
        ),
      ),
    );
  }
}
