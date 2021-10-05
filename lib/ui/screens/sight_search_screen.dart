import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/screens/widgets/bottom_navigation_bar.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/screens/sight_details.dart';
import 'package:places/ui/screens/widgets/loading_builder.dart';

enum _State {
  history,
  empty,
  found,
}

List<String> _historyQueries = [];
_State _currentState = _State.empty;

class SightSearchScreen extends StatefulWidget {
  const SightSearchScreen({Key? key}) : super(key: key);

  @override
  _SightSearchScreenState createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
  final FocusNode _focusNode = FocusNode();
  final _foundSight = <Place>[];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _currentState = _historyQueries.isNotEmpty ? _State.history : _State.empty;
    super.initState();
    _controller.addListener(_getSight);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_focusNode);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Список интересных мест'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: _SearchBar(
                  controller: _controller,
                  focusNode: _focusNode,
                  onEditingComplete: _addHistory,
                  onPressed: _onPressed,
                ),
              ),
              if (_currentState == _State.found)
                _FoundSights(listFound: _foundSight)
              else if (_currentState == _State.empty)
                const _NothingFound()
              else if (_currentState == _State.history)
                _History(
                  controller: _controller,
                  onRemovePressed: (value) {
                    setState(() {
                      _historyQueries.remove(value);
                      if (_historyQueries.isEmpty) _currentState = _State.empty;
                    });
                  },
                  onCleanPressed: () {
                    setState(() {
                      _historyQueries.clear();
                      _currentState = _State.empty;
                    });
                  },
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        pageIndex: 0,
      ),
    );
  }

  void _onPressed() {
    _controller.clear();
    _foundSight.clear();
    _historyQueries.isNotEmpty
        ? _currentState = _State.history
        : _currentState = _State.empty;
    setState(() {});
  }

  void _getSight() {
    if (_controller.text != '') {
      // _foundSight = mocks
      //     .where(
      //       (element) => element.name.toLowerCase().contains(
      //             _controller.text.trim(),
      //           ),
      //     )
      //     .toList();
    } else {
      _foundSight.clear();
    }
    _historyQueries.isNotEmpty
        ? _currentState = _State.history
        : _currentState = _State.empty;
    if (_foundSight.isNotEmpty) _currentState = _State.found;
    setState(() {});
  }

  void _addHistory() {
    if ((_controller.text != '') &&
        (!_historyQueries.contains(_controller.text))) {
      _historyQueries.add(_controller.text);
    }
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function() onEditingComplete;
  final void Function() onPressed;

  const _SearchBar({
    required this.controller,
    required this.focusNode,
    required this.onEditingComplete,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      cursorHeight: 24,
      cursorWidth: 1,
      textInputAction: TextInputAction.search,
      onEditingComplete: onEditingComplete,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        fillColor: Theme.of(context).primaryColorDark,
        filled: true,
        hintText: ' Поиск',
        contentPadding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
        prefixIcon: MyIcon(
          asset: AssetsStr.search,
          color: Theme.of(context).unselectedWidgetColor,
          height: 18,
          fit: BoxFit.scaleDown,
        ),
        suffixIcon: Material(
          color: Colors.transparent,
          child: IconButton(
            icon: MyIcon(
              asset: AssetsStr.iconClear,
              color: Theme.of(context).accentColor,
            ),
            iconSize: 18,
            splashRadius: 20,
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}

class _History extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onRemovePressed;
  final void Function() onCleanPressed;

  const _History({
    required this.controller,
    required this.onRemovePressed,
    required this.onCleanPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(top: 32, bottom: 4),
          child: Text(
            'ВЫ ИСКАЛИ',
            style: Theme.of(context)
                .primaryTextTheme
                .bodyText2!
                .copyWith(fontSize: 14),
          ),
        ),
        for (var i = 0; i < _historyQueries.length; i++)
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              children: [
                _HistoryItem(
                  data: _historyQueries[i],
                  controller: controller,
                  onPressed: onRemovePressed,
                ),
                const SizedBox(
                  height: 13,
                ),
                if (i != (_historyQueries.length - 1))
                  const Divider(
                    height: 1,
                  )
                else
                  Container(),
              ],
            ),
          ),
        Container(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: onCleanPressed,
            style: ElevatedButton.styleFrom(
              onPrimary: Theme.of(context).buttonColor,
            ),
            child: const Text('Очистить историю'),
          ),
        ),
      ],
    );
  }
}

//Виджет отображения ничего не найденно
class _NothingFound extends StatelessWidget {
  const _NothingFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 170,
        ),
        MyIcon(
          asset: AssetsStr.search,
          color: Theme.of(context).unselectedWidgetColor,
          height: 48,
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          'Ничего не найденою',
          style: Theme.of(context).primaryTextTheme.headline6,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          'Попробуйте изменить параметры\nпоиска.',
          style: Theme.of(context).primaryTextTheme.bodyText2,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

//Виджет отображения списка найденных мест
class _FoundSights extends StatelessWidget {
  // const _ShowFound({ Key? key }) : super(key: key);
  final List<Place> listFound;

  const _FoundSights({
    required this.listFound,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 29,
        ),
        for (var i = 0; i < listFound.length; i++)
          Column(children: [
            _Item(sight: listFound[i]),
            if (i != (listFound.length - 1))
              const Divider(
                height: 1,
              )
            else
              Container(),
          ]),
      ],
    );
  }
}

//Виджет элемента списка найденных мест
class _Item extends StatelessWidget {
  // const _Item({ Key? key }) : super(key: key);
  final Place sight;

  const _Item({required this.sight});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 78,
      width: double.infinity,
      // padding: EdgeInsets.only(top: 11),
      child: Material(
        child: InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
            Navigator.push<void>(
              context,
              MaterialPageRoute(
                builder: (_) => PlaceDetails(
                  id: sight.id,
                ),
              ),
            );
          },
          child: Ink(
            child: Row(
              children: [
                SizedBox(
                  height: 56,
                  width: 56,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    clipBehavior: Clip.hardEdge,
                    child: Image.network(
                      sight.urls[0],
                      loadingBuilder: loadingBuilder,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(sight.name),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(sight.placeType),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Виджет элемента истории
class _HistoryItem extends StatelessWidget {
  final String data;
  final TextEditingController controller;
  final Function(String) onPressed;

  const _HistoryItem({
    required this.data,
    required this.controller,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      // width: double.infinity,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: InkWell(
              onTap: () {
                controller
                  ..text = data
                  ..selection = TextSelection.fromPosition(
                    TextPosition(
                      offset: controller.text.length,
                    ),
                  );
              },
              child: SizedBox(
                width: 207,
                child: Text(
                  data,
                  maxLines: 2,
                  style: Theme.of(context)
                      .primaryTextTheme
                      .subtitle1!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
          Positioned(
            top: -15,
            right: 0,
            child: IconButton(
              icon: MyIcon(
                asset: AssetsStr.delete,
                color: Theme.of(context).unselectedWidgetColor,
              ),
              splashRadius: 13,
              onPressed: () => onPressed(data),
            ),
          ),
        ],
      ),
    );
  }
}
