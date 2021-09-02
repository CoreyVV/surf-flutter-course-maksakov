import 'package:flutter/material.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/screens/sight_list_screen.dart';

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

  void _getChangedPageAndMoveBar(int page) {
    _currentPageValue = page;
    setState(() {});
  }

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
          left: 156,
          bottom: 136,
          child: Row(
            children: [
              for (int i = 0; i < 3; i++)
                _MyIndicator(
                  isActive: i == _currentPageValue,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FirstPage extends StatelessWidget {
  const _FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          'Добро пожаловать\nв Путеводитель',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          'Ищи новые локации и сохраняй\nсамые любимые.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2,
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
          'Построй маршрут\nи отправляйся в путь',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          'Достигай цели максимально\nбыстро и комфортно.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2,
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
          height: 253,
        ),
        MyIcon(
          asset: AssetsStr.tutorial3Frame,
          color: Theme.of(context).indicatorColor,
        ),
        const SizedBox(
          height: 47.78,
        ),
        Text(
          'Добавляй места,\nкоторые нашёл сам',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          'Делись самыми интересными\nи помоги нам стать лучше!',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const SizedBox(
          height: 188,
        ),
        const _ButtonStart(),
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
        borderRadius: BorderRadius.circular(8),
        color: isActive
            ? Theme.of(context).accentIconTheme.color
            : Theme.of(context).unselectedWidgetColor,
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
      width: 376,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushReplacement<void, void>(
            MaterialPageRoute(
              builder: (_) => const SightListScreen(),
            ),
          );
        },
        child: const Text('НА СТАРТ'),
      ),
    );
  }
}

class _ButtonSkip extends StatelessWidget {
  const _ButtonSkip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 66,
      width: 392,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 255,
          top: 28,
        ),
        child: TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement<void, void>(
              MaterialPageRoute(
                builder: (_) => const SightListScreen(),
              ),
            );
          },
          child: Text(
            'Пропустить',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Theme.of(context).buttonColor),
          ),
        ),
      ),
    );
  }
}
