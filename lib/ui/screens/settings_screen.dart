import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/ui/screens/onboarding_screen.dart';
import 'package:places/ui/screens/res/app_strings.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/my_icons.dart';
import 'package:places/ui/screens/res/themes.dart';
import 'package:places/ui/screens/widgets/my_bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

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

  @override
  Size get preferredSize => Size.fromHeight(height);

  const _AppBar({
    this.height = 56,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Container(
        alignment: Alignment.center,

        // color: Theme.of(context).colorScheme.primary,
        child: Text(
          AppStrings.settings,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      elevation: 0.0,
      toolbarHeight: 56,
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: Column(
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
                  color: Theme.of(context).colorScheme.inactiveBlack,
                ),
              ),
            ),
            height: 56,
            width: double.infinity,
            child: Row(
              children: [
                Text(
                  AppStrings.darkTheme,
                  style: Theme.of(context).textTheme.bodyText1,
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
                  color: Theme.of(context).colorScheme.inactiveBlack,
                ),
              ),
            ),
            height: 48,
            width: double.infinity,
            child: Row(
              children: [
                Text(
                  AppStrings.studyGuide,
                  style: Theme.of(context).textTheme.bodyText1,
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
                      Theme.of(context).colorScheme.green,
                      BlendMode.modulate,
                    ),
                    child: MyIcons.iconInfo,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DarkModeSwitcher extends StatefulWidget {
  const DarkModeSwitcher({Key? key}) : super(key: key);

  @override
  _DarkModeSwitcherState createState() => _DarkModeSwitcherState();
}

class _DarkModeSwitcherState extends State<DarkModeSwitcher> {
  @override
  Widget build(BuildContext context) {
    final settingsInteractor =  Provider.of<SettingsInteractor>(context);

    return CupertinoSwitch(
      trackColor: Theme.of(context).colorScheme.inactiveBlack,
      value: settingsInteractor.isDarkTheme,
      onChanged: settingsInteractor.setDarkTheme,
    );
  }
}
