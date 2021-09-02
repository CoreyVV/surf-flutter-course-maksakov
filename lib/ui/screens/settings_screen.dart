import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/main.dart';
import 'package:places/ui/screens/widgets/bottom_navigation_bar.dart';
import 'package:places/ui/screens/onboarding_screen.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/screens/res/themes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AppBar(),
      body: const _Body(),
      bottomNavigationBar: MyBottomNavigationBar(
        pageIndex: 3,
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const _AppBar({
    this.height = 56,
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        padding:
            const EdgeInsets.only(left: 134, top: 16, right: 133, bottom: 16),
        alignment: Alignment.topCenter,
        child: Text(
          'Настройки',
          textAlign: TextAlign.center,
          style: Theme.of(context).accentTextTheme.headline6,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      toolbarHeight: 56,
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 24,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 0.8,
                color: Theme.of(context).unselectedWidgetColor,
              ),
            ),
          ),
          height: 56,
          width: double.infinity,
          child: Row(
            children: [
              Text(
                'Тёмная тема',
                style: Theme.of(context).accentTextTheme.bodyText1,
              ),
              Expanded(
                child: Container(),
              ),
              const DarkModeSwitcher(),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 0.8,
                color: Theme.of(context).unselectedWidgetColor,
              ),
            ),
          ),
          height: 48,
          width: double.infinity,
          child: Row(
            children: [
              Text(
                'Смотреть туториал',
                style: Theme.of(context).accentTextTheme.bodyText1,
              ),
              Expanded(
                child: Container(),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const OnboardingScreen(),
                    ),
                  );
                },
                icon: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).buttonColor,
                    BlendMode.modulate,
                  ),
                  child: MyIcons.iconInfo,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DarkModeSwitcher extends StatefulWidget {
  const DarkModeSwitcher({Key? key}) : super(key: key);

  @override
  _DarkModeSwitcherState createState() => _DarkModeSwitcherState();
}

class _DarkModeSwitcherState extends State<DarkModeSwitcher> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: isSwitched,
      onChanged: (newValue) {
        setState(() {
          isSwitched = newValue;
          themeNotifier.setTheme(isSwitched ? darkTheme : lightTheme);
        });
      },
    );
  }
}
