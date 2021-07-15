import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/main.dart';
import 'package:places/ui/screens/bottom_navigation_bar.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/screens/res/themes.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.only(left: 134, top: 16, right: 133, bottom: 16),
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
      ),
      body: Column(
        children: [
          SizedBox(
            height: 24,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
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
                DarkModeSwither(),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
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
                    print('SettingsScreen/info was tapped');
                  },
                  icon: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).buttonColor,
                        BlendMode.modulate,
                      ),
                      child: MyIcons.icon_info),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}

class DarkModeSwither extends StatefulWidget {
  const DarkModeSwither({Key? key}) : super(key: key);

  @override
  _DarkModeSwitherState createState() => _DarkModeSwitherState();
}

class _DarkModeSwitherState extends State<DarkModeSwither> {
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
